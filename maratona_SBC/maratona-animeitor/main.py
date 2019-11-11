#!/usr/bin/env python2.7
# encoding: utf-8

import pygame
import argparse
from sys import exit
from util import *
from Handler import Handler
from ScoreboardHandler import ScoreboardHandler
from Contest import Contest, InvalidWebcastError

def main():
    parser = argparse.ArgumentParser()
    parser.add_argument('webcast_dir', help='Webcast files directory')
    parser.add_argument('-p', '--probs_ajust', type=int, metavar='N',
        help='Removes N problems from the defined problem quantity in the contest file.',
        default=0)
    parser.add_argument('-w', '--window_mode', action='store_true',
        help='Shows scoreboard in a window.')
    parser.add_argument('-r', '--remove_teams', nargs='+', metavar='PREFIX',
        help='Remove teams whose team id starts with PREFIX. This will be ignored'
        ' if --select_teams is used.', default=[])
    parser.add_argument('-s', '--select_teams', nargs='+', metavar='PREFIX',
        help='Select only the teams whose team id starts with PREFIX.', default=[])
    args = parser.parse_args()

    if len(args.select_teams) > 0 and len(args.remove_teams) > 0:
        print 'Warning: --remove_teams option will be ignored!'
        args.remove_teams = []

    try:
        contest = Contest(args)
        Handler.contest = contest
        contest.load_data()
        init_pygame(args.window_mode)
        handler = ScoreboardHandler()
    except InvalidWebcastError:
        print u'The given webcast is invalid.'
        print u'Check the typed URL: %s' % (args.webcast_dir)
        exit(1)
    except IOError, e:
        print u'Could not open webcast files: ' + e.strerror
        print u'Check the typed URL: %s' % (args.webcast_dir)
        exit(1)

    while 1:
        for event in pygame.event.get():
            handler.on_event(event)
        handler = handler.tick()

if __name__ == '__main__':
    main()
