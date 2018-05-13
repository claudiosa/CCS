#!/usr/bin/env python2.7
# encoding: utf-8

import pygame

from util import *
from Team import Team
from Handler import Handler
from TeamHandler import TeamHandler
from Contest import Contest

class ScoreboardHandler (Handler):
    def __init__(self):
        Handler.__init__(self)

        self.teamHeight = 60
        self.maxOffsetY = len(Handler.contest.teamMap.items()) * self.teamHeight

        self.offsetY = 0
    
        self.animationTimer = Timer()
        self.animationSpeed = 5000.0

        self.keyTimer = Timer()
        self.moveMap = {}
        
        self.pendingScroll = 0

        self.awardsMode = False
        self.lockTo = None

        self.attractTimer = Timer()
        self.attractSpeed = 1000

        self.refreshTimer = Timer()
        self.refreshFreq = 5000

        self.ffTimer = Timer()
        self.ffMode = False
        #self.ffLength = 300000.0 #velocidade do relogio no ffMode (diminua para deixar mais rapido)
        self.ffLength = 100000.0 #velocidade do relogio no ffMode (diminua para deixar mais rapido)

        pygame.mouse.set_visible(False)
    
    def on_event(self, event):
        if Handler.on_event(self, event):
            return True
        if event.type == pygame.KEYDOWN and event.key == pygame.K_SPACE and \
           self.keyTimer.clock > 200:
            self.keyTimer.reset()
            if Handler.contest.revealUntil < Handler.contest.contestTime:
                self.ffMode = True
                self.attractTimer.reset()
                self.refreshTimer.reset()
                return True
            if self.awardsMode:
                lowestTeamList = [_[1] for _ in Handler.contest.teamRanking[::-1] \
                    if _[1] in Handler.contest.unannouncedTeams]
                if len(lowestTeamList) == 0:
                    self.lockTo = None
                    return True
                lowestTeam = lowestTeamList[0]
                if self.lockTo != lowestTeam:
                    self.lockTo = lowestTeam
                    return True
                pendingRuns = [_ for _ in Handler.contest.blindRunList \
                    if _[2] == lowestTeam and \
                    Handler.contest.teamDetails[lowestTeam][_[3]][2] == None]
                if len(pendingRuns) > 0:
                    Handler.contest.unblind_runs()
                    self.setup_animation()
                    return True
                else:
                    Handler.contest.unannouncedTeams.remove(lowestTeam)
                    self.nextHandler = TeamHandler(self.lockTo, self, 1800000.0)
                    if len(lowestTeamList) > 1:
                        self.lockTo = lowestTeamList[1]
                    else:
                        self.lockTo = None
                        self.attractTimer.reset()
                    Handler.contest.newRunList = [[]]
                    return True
    
    def tick(self):
        Handler.tick(self)
        if self.nextHandler != self:
            nextHandler, self.nextHandler = self.nextHandler, self
            return nextHandler

        self.animationTimer.tick(self.delta())
        self.attractTimer.tick(self.delta())
        self.refreshTimer.tick(self.delta())
        self.keyTimer.tick(self.delta())
        if self.ffMode:
            self.ffTimer.tick(self.delta())
            self.ffTimer.clock = min(self.ffTimer.clock, self.ffLength)
            u = self.ffTimer.clock / self.ffLength
            Handler.contest.revealUntil = int(0.0 + \
              (1 - u) * Handler.contest.freezeTime + \
                   u  * Handler.contest.contestTime)
            self.attractSpeed = 300
        else:
            self.attractSpeed = 1000

        curScroll = (abs(self.pendingScroll) + 4) / 5
        if self.pendingScroll < 0:
            curScroll *= -1
        self.offsetY += curScroll
        self.pendingScroll -= curScroll

        if self.offsetY < 0:
            self.offsetY = 0
            self.pendingScroll = 0  # no need to scroll further
        elif self.offsetY > self.maxOffsetY:
            self.offsetY = self.maxOffsetY
            self.pendingScroll = 0

        if (not self.awardsMode) and self.refreshTimer.clock > self.refreshFreq:
            self.refreshTimer.reset()
            try:
                Handler.contest.refresh_runs()
                self.setup_animation()
                Handler.contest.load_clock()
            except IOError, e:
                pass
            if self.lockTo:
                self.offsetY += self.teamHeight * 12
                self.attractTimer.clock = \
                        (self.offsetY * self.attractSpeed) / self.teamHeight
            self.lockTo = None
            for runID, runTime, runTeam, runProb, runRes in \
                Handler.contest.newRunList[-1]:
                if runRes == 'Y':
                    self.lockTo = runTeam

        if not self.lockTo:
            self.pendingScroll = 0
            self.offsetY = (self.teamHeight * self.attractTimer.clock) / self.attractSpeed
            self.offsetY -= self.teamHeight * 12
            if self.offsetY < 0:
                self.offsetY = 0
            if self.offsetY > self.maxOffsetY + self.teamHeight / 2:
                self.attractTimer.reset()
                if self.ffMode:
                    if self.ffTimer.clock >= self.ffLength:
                        self.ffMode = False
                        self.awardsMode = True
                        Handler.contest.newRunList = [[]]
                else:
                    # show a random team photo
                    self.nextHandler = TeamHandler(None, self)

        get_screen().fill((0, 0, 0))
        block_blit(get_screen(), image('logo.jpg'), \
          (0, 0, 1024, 768), 'cc')

        Handler.contest.rank_teams()
        numTeams = len(Handler.contest.teamRanking)
        baseY = -self.offsetY + 48 + self.teamHeight * (numTeams - 1)
        for rank, teamID in Handler.contest.teamRanking[::-1]:
            moveY = 0
            if self.moveMap.has_key(teamID):
                oldPos, newPos = self.moveMap[teamID]
                moveY = self.teamHeight * (oldPos - newPos) * (1 - cubic_spline(self.animationTimer.clock / self.animationSpeed))
                moveY = int(0.5 + moveY)
            if self.lockTo == teamID:
                # keep locked team at screen center
                self.pendingScroll = baseY + moveY - 408 + self.teamHeight / 2

            # only draw stuff that will appear on-screen
            if -self.teamHeight + 40 < baseY < 768:
                if rank >= 100:
                    rank = u'\u221E'
                else:
                    rank = str(rank)
                block_blit(get_screen(), \
                  render(font('italic', 52), \
                    rank, '#999999'), \
                    (0, baseY, 60, self.teamHeight), 'rc')

            if -self.teamHeight + 40 < baseY + moveY < 768:
                team = Team(teamID)
                get_screen().blit(team.draw(self.lockTo == team.key), (68, baseY + moveY))

            # reposition cursor
            baseY -= self.teamHeight

        self.draw_header()

        pygame.display.flip()

        return self
    
    def draw_header(self):
        draw_rect(get_screen(), (-1, -1, 1026, 41), '#333333', '#FFFFFF', 1)
        
        contest_time = min(Handler.contest.revealUntil,
                           Handler.contest.elapsed_time() // 60)
        time_string = "%d minutos" % (contest_time, )
        time_string = time_string.replace('-', u'\u2212')
        block_blit(get_screen(),
            render(font('bold', 24), time_string, '#FFFFFF'),
            (68, 6, 0, 0), 'lt')

        shuffle_index = len([_ for _ in Handler.contest.shuffledProblem if _])
        probX = 918
        for probID in Handler.contest.visibleProblems:
            if probID == None:
                probX -= 10
                continue
            if Handler.contest.shuffledProblem[probID]:
                shuffle_index -= 1
                problem_letter = unichr(ord(u"\u03B1") + shuffle_index)
            else:
                problem_letter = chr(ord('A') + probID)
            block_blit(get_screen(),
                render(font('bold', 32), problem_letter, '#FFFFFF'),
                (probX, 0, 40, 0), 'ct')
            probX -= 44

    def setup_animation(self):
        self.animationTimer.reset()
        # build origin/destination map
        Handler.contest.rank_teams()

        origMap = {}
        pos = 0
        for rank, teamID in Handler.contest.oldTeamRanking:
            origMap[teamID] = pos
            pos += 1

        destMap = {}
        pos = 0
        for rank, teamID in Handler.contest.teamRanking:
            destMap[teamID] = pos
            pos += 1

        self.moveMap = {}
        for teamID in origMap.keys():
            origPos, destPos = origMap[teamID], destMap[teamID]
            if origPos != destPos:
                self.moveMap[teamID] = (origPos, destPos)
