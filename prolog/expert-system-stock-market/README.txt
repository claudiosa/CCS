How to use:

Requirements to use:

* Windows, Mac or Linux - operational system installed
* Install swi-prolog (https://www.swi-prolog.org/)
* 3 files take part of this system:
  - input_output_predicates.pl : predicates for Input/Output and others
  - kb.pl  : knowledge base -- YOU CAN ADD rules here as you wish
  - main-user-interface.pl : user interface, engine, options etc -- main program is called by the 'run' predicate
* Put these 3 files in any directory 
* Go to this directory ... and enjoy it!

Using:

By console:
$ swipl -q -f  main-user-interface.pl -t run

By swi-prolog enviroment, just load:
$ ?- ['main-user-interface.pl'].

Please, care with the inputs, they are very experimental!


/*

Code developed by: Claudio Cesar de Sá -- ccs1664@gmail.com
It is prototype of an Expert System for Stock Market

Based in a paper from: Integrated Intelligent Research (IIR)

Published in: International Journal of Computing Algorithm
 Volume: 04 Issue: 01 June 2015 Pages:15-18   ISSN: 2278-2397

"Rule Based Approach for Stock Selection: An Expert System"


NONE WARRANTY - It is under development -- very incipient application
*/
