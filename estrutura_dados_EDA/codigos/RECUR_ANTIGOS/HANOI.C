/* Recursive Version
A Recursive Solution for the Towers of Hanoi
To obtain towers(n,i,a,f):
If n = 1, then
move the top disk from i to f
else
apply towers (n - 1,i,f,a)
move the top disk from i to f
apply towers(n - 1,a,i,f).
*/


void towers(n,i,a,f)
/* Moves the top n disks from peg i to peg f
*/
int n,i,a,f;

{
if(n == 1)
printf("\n %d -> %d\n",i,f);
else
{
	Recursive Version
towers(n,i,a,f)
/* Moves the top n disks
from peg i to peg f
*/
int n,i,a,f;
{
if(n == 1)
printf("\n %d -> %d\n",i,f);
else
{
/*
in the nonrecursive version, a retrn value of 1 means this call has completed
 */
towers(n-1,i,f,a);
printf("\n %d -> %d\n",i,f)
/*
  In the nonrecursive version, a retrn value of 2 means this call has completed; in this version an "implicit" exit then occurs; this must be made explicit in the implementation
*/
towers(n-1,a,i,f);
}
}

/*************/


towers(n-1,i,f,a);
printf("\n %d -> %d\n",i,f)

	 >Comment
towers(n-1,a,i,f);
}
}



