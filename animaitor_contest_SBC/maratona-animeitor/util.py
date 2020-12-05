#!/usr/bin/env python2.7
# encoding: utf-8

import math
import os
import re

import pygame

gScreen = None

def init_pygame(window_mode):
    global gScreen

    pygame.init()
    if window_mode:
        gScreen = pygame.display.set_mode((1024, 768), pygame.RESIZABLE)
    else:
        gScreen = pygame.display.set_mode((1024, 768), pygame.FULLSCREEN)
    get_screen().fill(color('#000000'))

    pygame.key.set_repeat(50, 50)

def get_screen():
    return gScreen

_reColor = re.compile('#[0-9A-Fa-f]{6}')

def color(s):
    if type(s) == tuple:
        assert len(s) == 3
        # ...
        return s
    elif s == None:
        return s

    assert _reColor.match(s)

    return (int(s[1:3], 16), int(s[3:5], 16), int(s[5:7], 16))

class Timer (object):
    def __init__(self):
        self.reset()

    def tick(self, dt):
        self.clock += dt
        self.ticks += 1
    
    def reset(self):
        self.clock = self.ticks = 0

gTimer = Timer()

def pulse(c, d):
    c = color(c)
    d = color(d)

    if not (c and d): # "fixed" pulse
        return c or d
    
    u = (math.sin((math.pi/800.) * gTimer.clock) + 1) / 2. 
    return (int(0.5 + c[0] + u * (d[0] - c[0])),
            int(0.5 + c[1] + u * (d[1] - c[1])),
            int(0.5 + c[2] + u * (d[2] - c[2])))

gFontCache = {}

def font(fn, size):
    fontKey = (fn, size)
    if not gFontCache.has_key(fontKey):
        gFontCache[fontKey] = pygame.font.Font('fonts/' + fn + '.ttf', size)
    return gFontCache[fontKey]

def render(font, s, textColor):
    if type(s) not in (str, unicode):
        s = str(s)
    textColor = color(textColor)

    return font.render(s, True, textColor)

def block_blit(target, source, rect, mode):
    rect = pygame.Rect(rect)

    if mode[0] == 'l':
        posX = rect.left
    elif mode[0] == 'r':
        posX = rect.right - source.get_width()
    elif mode[0] == 'c':
        posX = rect.left + (rect.width - source.get_width()) / 2
    else:
        assert False
    
    if mode[1] == 't':
        posY = rect.top
    elif mode[1] == 'b':
        posY = rect.bottom - source.get_height()
    elif mode[1] == 'c':
        posY = rect.top + (rect.height - source.get_height()) / 2
    else:
        assert False
    
    target.blit(source, (posX, posY))

def draw_rect(surface, rect, backColor, foreColor, borderWidth):
    assert borderWidth >= 0

    rect = pygame.Rect(rect)

    backColor = color(backColor)
    foreColor = color(foreColor)

    if backColor:
        pygame.draw.rect(surface, backColor, rect, 0)
    if foreColor and borderWidth > 0:
        pygame.draw.rect(surface, foreColor, rect, borderWidth)

_gImageCache = {}

def image(filename):
    if _gImageCache.has_key(filename):
        return _gImageCache[filename]
    image = pygame.image.load('images/' + filename)
    _gImageCache[filename] = image
    return image

def cubic_spline(u):
    if u < 0.0:
        u = 0.0
    if u > 1.0:
        u = 1.0
    if u < 0.25:
        return 0.0
    if u > 0.75:
        return 1.0
    u = 2.0 * (u - 0.25)
    return 3 * u**2 - 2 * u**3

def lockFiles():
    while os.path.exists('.lock'):
        time.sleep(0.25)
    with open('.pylock', 'w'):
        pass

def releaseFiles():
    if os.path.exists('.pylock'):
        os.remove('.pylock')
