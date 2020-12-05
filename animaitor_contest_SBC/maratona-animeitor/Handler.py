#!/usr/bin/env python2.7
# encoding: utf-8

import sys, pygame

from util import *
from Contest import Contest

class Handler (object):
    contest = None

    def __init__(self):
        self.nextHandler = self
        self.oldTime = self.newTime = pygame.time.get_ticks()

    def on_event(self, event):
        if event.type == pygame.QUIT:
            sys.exit()
        elif event.type == pygame.KEYDOWN and event.key == pygame.K_q:
            sys.exit()
        return False
    
    def delta(self):
        deltaTime = self.newTime - self.oldTime
        if deltaTime < 100:
            return deltaTime
        return 0

    def tick(self):
        self.newTime, self.oldTime = pygame.time.get_ticks(), self.newTime
        gTimer.tick(self.delta())
        return self.nextHandler
