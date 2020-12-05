#!/usr/bin/env python2.7
# encoding: utf-8

import sys, pygame
import math

Rect = pygame.Rect

from util import *
from Handler import Handler
from Contest import Contest

class Team (object):
    def __init__(self, key):
        self.key = key

    def draw(self, locked):
        surface = pygame.surface.Surface((948, 52))
        surface.fill(color('#000000'))

        if locked:
            draw_rect(surface, (0, 0, 948, 52), '#224444', '#999999', 1)
        else:
            draw_rect(surface, (0, 0, 948, 52), '#222222', '#999999', 1)

        teamUni, teamName = Handler.contest.teamMap[self.key]
        teamUni += ' '
        teamX = 6
        surf = render(font('bold', 18), teamUni, '#FFFFFF')
        surface.blit(surf, (teamX, 4))
        surf = render(font('roman', 18), teamName, '#FFFFFF')
        surface.blit(surf, (teamX, 28))

        teamDetail = Handler.contest.teamDetails[self.key]

        probX = 850
        for probID in Handler.contest.visibleProblems:
            if probID == None:
                probX -= 10
                continue
            probRect = (probX, 4, 40, 44)
            topText = botText = None
            backColor = foreColor = None

            probErrors, probPending, probTime = teamDetail[probID]
            if probErrors > 0:
                if probErrors < 100:
                    botText = '+%d' % (probErrors, )
                else:
                    botText = u'+\u221E'
            if probTime != None:
                backColor, foreColor = '#003300', '#009900'
                topText = '%d' % (probTime, )
            elif probPending > 0:
                backColor, foreColor = '#444400', '#CCCC00'
                topText = '(%d)' % (probPending, )
            elif probErrors > 0:
                backColor, foreColor = '#330000', '#CC0000'

            recentRuns = sum([[_ for _ in L if \
                _[2] == self.key and _[3] == probID] \
              for L in Handler.contest.newRunList], [])
            if recentRuns:
                foreColor = pulse(backColor, foreColor)

            if backColor and foreColor:
                draw_rect(surface, probRect, backColor, foreColor, 2)
            else:
                # "default" rectangle
                draw_rect(surface, probRect, None, '#999999', 1)

            problemFont = font('roman', 18)
            if topText and botText:
                block_blit(surface, render(problemFont, topText, '#FFFFFF'),
                    (probX, 7, 40, 0), 'ct')
                block_blit(surface, render(problemFont, botText, '#FFFFFF'),
                    (probX, 25, 40, 0), 'ct')
            elif topText or botText:
                midText = topText or botText
                block_blit(surface, render(problemFont, midText, '#FFFFFF'),
                    (probX, 16, 40, 0), 'ct')
            probX -= 44
        
        teamSolved, teamPenalty, _ = Handler.contest.teamSummary[self.key]
        block_blit(surface, render(font('bold', 18), teamSolved, '#FFFFFF'),
            (0, 4, 942, 0), 'rt')
        block_blit(surface, render(font('roman', 18), teamPenalty, '#FFFFFF'),
            (0, 28, 942, 0), 'rt')

        return surface
