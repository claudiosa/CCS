#!/usr/bin/env python2.7
# encoding: utf-8

import sys
import random
import urllib
import textwrap

from collections import namedtuple
from re import match
from util import *
import exceptions

RunTuple = namedtuple('RunTuple', ['id', 'time', 'team', 'prob', 'answer'])

class InvalidWebcastError (exceptions.Exception):
    pass

class Contest (object):
    def __init__(self, args):
        self.baseDir = args.webcast_dir
        self.minusProbs = args.probs_ajust
        self.selectPattern = '|'.join(args.select_teams)
        if len(args.select_teams) == 0 and len(args.remove_teams) > 0:
            self.removePattern = '|'.join(args.remove_teams)
        else:
            self.removePattern = '@'

        self.contestTime = None
        self.freezeTime = None
        self.blindTime = None
        self.clockOffset = None

        self.numProblems = None
        self.teamMap = {}
        self.teamPhotos = {}
        self.runList = []
        self.newRunList = [[]]
        self.blindRunList = []
        self.unannouncedTeams = []
        self.revealUntil = None

        self.teamDetails = {}
        self.teamSummary = {}
        self.teamRanking = None

        self.problemGroups = []
        self.visibleProblems = []

        self.oldTeamRanking = self.rank_teams()

    def load_contest(self):
        lockFiles()
        inFile = urllib.urlopen(self.baseDir + '/contest')

        line = inFile.readline().decode('utf-8').strip('\r\n')
        self.name = line

        line = inFile.readline().decode('utf-8').strip('\r\n')
        self.contestTime, self.blindTime, self.freezeTime, self.penaltyTime = \
            map(int, line.split('\x1c'))
        
        self.revealUntil = self.freezeTime

        line = inFile.readline().decode('utf-8').strip('\r\n')
        self.numTeams, self.numProblems = map(int, line.split('\x1c'))
        self.numProblems -= self.minusProbs

        for i in range(self.numTeams):
            line = inFile.readline().decode('utf-8').strip('\r\n')
            teamID, teamUni, teamName = line.split('\x1c')
            
            if not match(self.selectPattern, teamID):
                continue
            if match(self.removePattern, teamID):
                continue

            self.teamMap[teamID] = (teamUni, teamName)
        
        self.unannouncedTeams = self.teamMap.keys()

        line = inFile.readline().decode('utf-8').strip('\r\n')
        _, self.numProblemGroups = map(int, line.split('\x1c'))
        for i in range(self.numProblemGroups):
            line = inFile.readline().decode('utf-8').strip('\r\n')
            groupSize, groupVisible = line.split('\x1c')
            groupSize = int(groupSize) - self.minusProbs
            self.problemGroups.append((groupSize, groupVisible))

        inFile.close()
        releaseFiles()
            
        random.seed(self.name)
        self.shuffledProblem = [False] * self.numProblems
        self.visibleProblems = []
        curProblem = 0
        for groupSize, groupVisible in self.problemGroups:
            if groupVisible == 'N':
                curProblem += groupSize
                continue
            if self.visibleProblems:
                self.visibleProblems.append(None)
            problem_group = range(curProblem, curProblem + groupSize)
            if groupVisible == '!':
                random.shuffle(problem_group)
                for problem in problem_group:
                    self.shuffledProblem[problem] = True
            self.visibleProblems.extend(problem_group)
            curProblem += groupSize

        self.visibleProblems.reverse()

    def load_photos(self):
        sys.stderr.write('Loading photos: ')
        failedTeams = []
        for teamID in self.teamMap:
            try:
                raw_photo = image('team_photos/' + teamID + '.jpg')
                scaleFactor = min(1024.0 / raw_photo.get_width(),
                                   504.0 / raw_photo.get_height())
                scaled_width = int(round(raw_photo.get_width() * scaleFactor))
                scaled_height = int(round(raw_photo.get_height() * scaleFactor))
                scaled_photo = pygame.transform.smoothscale(raw_photo,
                                                            (scaled_width,
                                                             scaled_height))
                self.teamPhotos[teamID] = scaled_photo
                sys.stderr.write('.')
            except pygame.error:
                failedTeams.append(teamID)
                sys.stderr.write('!')
        sys.stderr.write('\n')
        if not failedTeams:
            return
        print 'The following teams have missing or corrupted team photos:'
        print
        print textwrap.fill(' '.join(failedTeams))
        print
        # while True:
        #     try:
        #         ans = 'y'
        #     except KeyboardInterrupt:
        #         ans = 'n'
        #     if ans == 'y':
        #         break
        #     elif ans == 'n':
        #         sys.exit(0)

    def load_runs(self):
        lockFiles()
        inFile = urllib.urlopen(self.baseDir + '/runs')
        self.runList = []
        for line in inFile.readlines():
            line = line.strip().decode('utf-8')
            runID, runTime, runTeam, runProb, runAnswer = line.split('\x1c')
            runID = int(runID)
            runTime = int(runTime)
            
            if not match(self.selectPattern, runTeam):
                continue
            if match(self.removePattern, runTeam):
                continue
            
            assert self.teamMap.has_key(runTeam), runTeam
            runProb = ord(runProb) - ord('A')
            assert runAnswer in ('Y', 'N', '?')
            self.runList.append(RunTuple(runID, runTime, runTeam, runProb, runAnswer))

        inFile.close()
        releaseFiles()
        
        self.runList.sort()
        if self.revealUntil != None:
            self.runList = [_ for _ in self.runList if _.time <= self.revealUntil]
        self.blindRunList = [_ for _ in self.runList if _.time >= self.blindTime]
        self.runList = [_ for _ in self.runList if _.time < self.blindTime]

        # destroy acceptance information
        for run in self.blindRunList:
            self.runList.append(run._replace(answer='?'))


    def load_clock(self):
        lockFiles()
        inFile = urllib.urlopen(self.baseDir + '/time')
        line = inFile.readline().decode('utf-8').strip('\r\n')
        inFile.close()
        releaseFiles()

        self.clockOffset = gTimer.clock - int(line) * 1000


    def load_data(self):
        self.load_contest()
        self.load_photos()
        self.load_runs()
        self.load_clock()

    def refresh_runs(self):
        oldRunList = self.runList[:]
        self.oldTeamRanking = self.teamRanking

        self.load_runs()
        self.teamRanking = None
        self.newRunList = self.newRunList[-12:] + [[]]
        for run in self.runList:
            if run not in oldRunList:
                self.newRunList[-1].append(run)
            else:
                oldRunList.remove(run)

    def unblind_runs(self):
        oldRunList = self.runList
        self.oldTeamRanking = self.teamRanking
        self.teamRanking = None
        self.newRunList = [[]]

        for rank, teamID in self.oldTeamRanking[::-1]:
            pendingRuns = []
            for i, run in enumerate(self.blindRunList):
                if run.team != teamID:
                    continue
                if self.teamDetails[teamID][run.prob][2] != None:
                    continue
                pendingRuns.append((run.prob, i))
            if pendingRuns == []:
                continue
            pendingRuns.sort()
            targetIdx = pendingRuns[0][1]
            targetRun = self.blindRunList[targetIdx]
            for i in range(len(self.runList)):
                blindRun = self.runList[i]
                if blindRun.id != targetRun.id:
                    continue
                self.runList[i] = targetRun
                self.newRunList[-1].append(targetRun)
                break
            self.blindRunList.pop(targetIdx)
            break

    def calc_details(self):
        self.teamDetails = {}
        for teamID in self.teamMap.keys():
            teamDetail = [(0, 0, None)] * self.numProblems
            teamRuns = [_ for _ in self.runList if _.team == teamID]
            for run in teamRuns:
                probErrors, probPending, probTime = teamDetail[run.prob]
                if probTime != None:
                    continue
                elif run.answer == 'N':
                    teamDetail[run.prob] = \
                        (probErrors + 1, probPending, probTime)
                elif run.answer == '?':
                    teamDetail[run.prob] = \
                        (probErrors, probPending + 1, probTime)
                else:
                    teamDetail[run.prob] = \
                        (probErrors, probPending, run.time)
            self.teamDetails[teamID] = teamDetail

    def calc_summary(self):
        self.teamSummary = {}
        self.calc_details()
        for teamID in self.teamDetails.keys():
            teamSolved, teamPenalty, teamEarliest = 0, 0, 301 # 301 == infinity
            for probErrors, probPending, probTime in self.teamDetails[teamID]:
                if probTime is not None:
                    teamSolved += 1
                    teamPenalty += probTime + probErrors * 20
                    teamEarliest = min(teamEarliest, probTime)
            self.teamSummary[teamID] = (teamSolved, teamPenalty, teamEarliest)

    def rank_teams(self):
        if self.teamRanking:
            return self.teamRanking

        self.calc_summary()
        teamList = []
        for teamID in self.teamDetails.keys():
            teamSolved, teamPenalty, teamEarliest = self.teamSummary[teamID]
            teamList.append(((-teamSolved, teamPenalty, teamEarliest), teamID))
        teamList.sort()

        # group incomparable teams into tuples
        teamRanking = []
        tmpGroup = []
        for teamKey, teamID in teamList:
            if tmpGroup != [] and tmpGroup[-1][0] != teamKey:
                teamRanking.append(tuple([_[1] for _ in tmpGroup]))
                tmpGroup = [(teamKey, teamID)]
            else:
                tmpGroup.append((teamKey, teamID))
        teamRanking.append(tuple([_[1] for _ in tmpGroup]))

        # finally, return (rank, teamID) pairs
        finalRanking = []
        curRank = 1
        for tp in teamRanking:
            for team in tp:
                finalRanking.append((curRank, team))
            curRank += len(tp)
        self.teamRanking = finalRanking
        return self.teamRanking
    
    def elapsed_time(self):
        elapsedTime = (gTimer.clock - self.clockOffset) / 1000
        return min(elapsedTime, self.contestTime * 60)
