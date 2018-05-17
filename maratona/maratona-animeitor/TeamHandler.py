#!/usr/bin/env python2.7
# encoding: utf-8

import random
import sys
import math
import pygame

Rect = pygame.Rect

from util import *
from Team import Team
from Handler import *
from Contest import Contest

class TeamHandler (Handler):
    def __init__(self, teamID, returnTo, timeout = 5000.0):
        Handler.__init__(self)
        if teamID is None:
            teamID = random.choice(Handler.contest.teamMap.keys())
        self.team = Team(teamID)
        self.returnTo = returnTo

        self.teamPhoto = Handler.contest.teamPhotos.get(teamID)

        self.timeout = timeout
        self.timeoutTimer = Timer()

        pygame.mouse.set_visible(False)
    
    def on_event(self, event):
        if Handler.on_event(self, event):
            return True
        if event.type == pygame.KEYDOWN and event.key == pygame.K_SPACE:
            if self.timeoutTimer.clock > 500:
                self.nextHandler = self.returnTo
    
    def tick(self):
        Handler.tick(self)

        if self.teamPhoto == None: # no point being in this handler
            return self.returnTo

        self.timeoutTimer.tick(self.delta())
        if self.timeout and self.timeoutTimer.clock > self.timeout:
            self.nextHandler = self.returnTo

        Handler.contest.rank_teams()
        teamRank = [_[0] for _ in Handler.contest.teamRanking
            if _[1] == self.team.key][0]

        teamUni, teamName = Handler.contest.teamMap[self.team.key]

        get_screen().fill((0, 0, 0))

        block_blit(get_screen(),
            render(font('bold', 48), teamUni, '#FFFFFFi'),
            (0, 48, 1024, 0), 'ct')

        block_blit(get_screen(),
            render(font('roman', 36), teamName, '#FFFFFF'),
            (0, 104, 1024, 0), 'ct')

        block_blit(get_screen(), self.teamPhoto, (0, 156, 1024, 504), 'cc')


        block_blit(get_screen(),
            render(font('italic', 52), teamRank, '#999999'),
            (0, 680, 60, 60), 'rc')

        get_screen().blit(self.team.draw(True), (68, 680))

        pygame.display.flip()

        return self.nextHandler
