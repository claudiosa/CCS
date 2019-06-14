//#include <stdio.h>

#include <ilcplex/cplex.h>

/* Bring in the declarations for the string and character functions   and malloc */

#include <ctype.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>

/* Include declarations for functions in this program */

static void
   free_and_null (char **ptr),
   usage         (char *progname);


int main (int argc, char *argv[])
{
   /* Declare and allocate space for the variables and arrays where we will
      store the optimization results including the status, objective value,
      and variable values. */


   int      solstat;
   double   objval;
   double   *x     = NULL;

   CPXENVptr     env = NULL;
   CPXLPptr      lp = NULL;
   int           status;

   int           i;
   int           j;
   int           cur_numcols;
   int           cur_numraws;

    char *lp_filename;	/* lp filename */
   	char *out_filename;	/* output filename */
	FILE *result_ndp;	/* file pointer of ndp */

	double cpu_time_used;
	clock_t starttime, endtime;

   /* Check the command line arguments */

   if ( argc != 2 ) {
      usage (argv[0]);
      goto TERMINATE;
   }

   /* Record CPU time and elapsed time */
	starttime = clock();

   /* Get lp filename */
	lp_filename = (char *) malloc((strlen(argv[1]) + 1) * sizeof(char));
	strcpy(lp_filename, argv[1]);


   /* Initialize the CPLEX environment */

   env = CPXopenCPLEX (&status);

      if ( env == NULL ) {
      char  errmsg[CPXMESSAGEBUFSIZE];
      fprintf (stderr, "Could not open CPLEX environment.\n");
      CPXgeterrorstring (env, status, errmsg);
      fprintf (stderr, "%s", errmsg);
      goto TERMINATE;
   }

   /* Turn on output to the screen */

   status = CPXsetintparam (env, CPXPARAM_ScreenOutput, CPX_ON);
   if ( status ) {
      fprintf (stderr,
               "Failure to turn on screen indicator, error %d.\n", status);
      goto TERMINATE;
   }

   /* Create the problem, using the filename as the problem name */


   lp = CPXcreateprob (env, &status, "BOIP");


   if ( lp == NULL ) {
      fprintf (stderr, "Failed to create LP.\n");
      goto TERMINATE;
   }

   /* Now read the file, and copy the data into the created lp */

   status = CPXreadcopyprob (env, lp, lp_filename, NULL);

   if ( status ) {
      fprintf (stderr, "Failed to read and copy the problem data.\n");
      goto TERMINATE;
   }


   /* Optimize the problem and obtain solution. */

   status = CPXmipopt (env, lp);
   if ( status ) {
      fprintf (stderr, "Failed to optimize MIP.\n");
      goto TERMINATE;
   }

   solstat = CPXgetstat (env, lp);
   printf ("Solution status %d.\n", solstat);

   status  = CPXgetobjval (env, lp, &objval);

   if ( status ) {
      fprintf (stderr,"Failed to obtain objective value.\n");
      goto TERMINATE;
   }
/* Set the result filename */
	out_filename = (char *) malloc(strlen(lp_filename) + 2);
	strncpy(out_filename, lp_filename, strlen(lp_filename) - 3);
	out_filename[strlen(lp_filename) - 3] = 0;
	strcat(out_filename, ".out");
	lp_filename= fopen(out_filename, "w");
	fprintf(lp_filename, "Optimal solution of Z= %g \n\n", objval);


   printf ("Objective value %.10g\n", objval);

   /* Stop the clock. Sort and print results.*/
	endtime = clock();
	cpu_time_used=((double) (endtime - starttime)/CLOCKS_PER_SEC);

	/* Write CPU time and elapsed time */
   cur_numcols = CPXgetnumcols (env, lp);


   /* Allocate space for solution */
   x = (double *) malloc (cur_numcols*sizeof(double));


   if ( x == NULL ) {
      fprintf (stderr, "No memory for solution values.\n");
      goto TERMINATE;
   }

   status = CPXgetx (env, lp, x, 0, cur_numcols-1);


   if ( status ) {
      fprintf (stderr, "Failed to obtain solution.\n");
      goto TERMINATE;
   }

   /* Write out the solution */

   for (j = 0 ; j < cur_numcols; j++) {
   fprintf(lp_filename, "x_%d:  = %5.10g\n", j, x[j]);
      printf ( "x_ %d: = %17.10g\n", j, x[j]);
      }


	fprintf(lp_filename,"\n\n\CPU time %8.4f\n", cpu_time_used);


TERMINATE:

   /* Free up the solution */

   free_and_null ((char **) &x);

   /* Free up the problem as allocated by CPXcreateprob, if necessary */

   if ( lp != NULL ) {
      status = CPXfreeprob (env, &lp);
      if ( status ) {
         fprintf (stderr, "CPXfreeprob failed, error code %d.\n", status);
      }
   }

   /* Free up the CPLEX environment, if necessary */

   if ( env != NULL ) {
      status = CPXcloseCPLEX (&env);


      if ( status ) {
      char  errmsg[CPXMESSAGEBUFSIZE];
         fprintf (stderr, "Could not close CPLEX environment.\n");
         CPXgeterrorstring (env, status, errmsg);
         fprintf (stderr, "%s", errmsg);
      }
   }

   return (status);

}  /* END main */


/* This simple routine frees up the pointer *ptr, and sets *ptr to NULL */

static void free_and_null (char **ptr)
{
   if ( *ptr != NULL ) {
      free (*ptr);
      *ptr = NULL;
   }
} /* END free_and_null */


static void usage (char *progname)
{
   fprintf (stderr,"Usage: %s filename\n", progname);
   fprintf (stderr,"   where filename is a file with extension \n");
   fprintf (stderr,"      MPS, SAV, or LP (lower case is allowed)\n");
   fprintf (stderr,"  This program uses the CPLEX MIP optimizer.\n");
   fprintf (stderr," Exiting...\n");
} /* END usage */
