//C hello world example
#include <stdio.h>
//#define PROLOG_MODULE "math"
#include </usr/lib/swi-prolog/include/SWI-Prolog.h>
#include <math.h>
/*
root@goedel:/home/ccs/Dropbox/CCS/prolog/C-call-Prolog# find /usr/lib -name "libswip*" -print
/usr/lib/libswipl.so
/usr/lib/libswipl.a
/usr/lib/libswipl.so.6.6.6
root@goedel:/home/ccs/Dropbox/CCS/prolog/C-call-Prolog# find /usr/lib -name "SWI-Prolog*" -print
/usr/lib/swi-prolog/include/SWI-Prolog.h
root@goedel:/home/ccs/Dropbox/CCS/prolog/C-call-Prolog#
 */
 
int main()
{
	
	char *ancestor(const char *me)
 
	term_t a0 = PL_new_term_refs(3);
	term_t a1 = PL_new_term_refs(3);
    term_t a2 = PL_new_term_refs(3);
    
    static predicate_t p;

  if ( !p )
    p = PL_predicate("pere", 3, "teste.pl");

  PL_put_atom_chars(a0, me);
  PL_open_query(NULL, PL_Q_NORMAL, p, a0);
  PL_open_query(NULL, PL_Q_NORMAL, p, a1);
 
   printf("%s", me);
  return 0;
}

/*
 *
 * 
 * is_a(X,Y) :- ....
 * 
 * 
 pere(a,b,c).
 pere(a,b,d).
 * 
 */
