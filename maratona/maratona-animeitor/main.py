#!/usr/bin/env python2.7
# encoding: utf-8

import sys, pygame

from util import *
from Handler import Handler
from ScoreboardHandler import ScoreboardHandler
from Contest import Contest, InvalidWebcastError

def main():
    if len(sys.argv) < 2:
        print u'Uso: %s <webcast>' % (sys.argv[0], )
        sys.exit(1)
    else:
        try:
            contest = Contest(sys.argv[1])
            Handler.contest = contest
            contest.load_data()
            init_pygame()
            handler = ScoreboardHandler()
        except InvalidWebcastError:
            print u'O webcast fornecido é inválido.'
            print u'Verifique se o URL foi digitado corretamente:'
            print sys.argv[1]
            sys.exit(1)
        except IOError, e:
            print u'Não foi possível abrir o webcast: ' + e.strerror
            print u'Verifique se o URL foi digitado corretamente:'
            print sys.argv[1]
            sys.exit(1)

    while 1:
        for event in pygame.event.get():
            handler.on_event(event)
        handler = handler.tick()

if __name__ == '__main__':
    main()
