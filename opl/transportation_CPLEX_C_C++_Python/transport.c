/* --------------------------------------------------------------------------
 * File: examples/src/cplex/transport.c
 * Version 12.9.0
 * --------------------------------------------------------------------------
 * Licensed Materials - Property of IBM
 * 5725-A06 5725-A29 5724-Y48 5724-Y49 5724-Y54 5724-Y55 5655-Y21
 * Copyright IBM Corporation 2007, 2019. All Rights Reserved.
 *
 * US Government Users Restricted Rights - Use, duplication or
 * disclosure restricted by GSA ADP Schedule Contract with
 * IBM Corp.
 * --------------------------------------------------------------------------
 */

/* Model piecewise linear cost coefficients.
 *
 * The problem is a simple transportation model.  Set the function
 * argument to 0 for a convex piecewise linear model and to 1 for a
 * concave piecewise linear model.
 */

/* Bring in the CPLEX function declarations and the C library
   header file stdio.h with the following single include. */

#include <ilcplex/cplex.h>

/* Bring in the declarations for the string functions */

#include <string.h>

/* Include declaration for functions at end of program */

static void
   free_and_null (char **ptr),
   usage         (char *progname);

static int
   varindex (int m, int n),
   populatebyrow (CPXENVptr env, CPXLPptr lp, int convex);

#define NUM_SUPPLY 3
#define NUM_DEMAND 4
#define SUPPLY_X_DEMAND NUM_SUPPLY * NUM_DEMAND
#define NAME_BUF_SIZE   ((SUPPLY_X_DEMAND + 9) / 10) + 2

static double const supply[NUM_SUPPLY] = {1000.0, 850.0, 1250.0};
static double const demand[NUM_DEMAND] = {900.0, 1200.0, 600.0, 400.0};
static double const convexslope[]  = {120.0, 80.0, 50.0};
static double const concaveslope[] = {30.0, 80.0, 130.0};

int
main (int argc, char **argv)
{
   int status = 0;
   int convex = 0;

   double x[SUPPLY_X_DEMAND];
   double objval;
   int    solstat;


   /* Declare and allocate space for the variables and arrays where we
      will store the optimization results including the status, objective
      value, variable values, dual values, row slacks and variable
      reduced costs. */

   CPXENVptr     env = NULL;
   CPXLPptr      lp = NULL;
   int           i, j;

   if ( argc <=  1 ) {
      usage (argv[0]);
      goto TERMINATE;
   }

   if (argc <= 1)
      convex = 0;
   else
      convex = atoi(argv[1]);

   /* Initialize the CPLEX environment */

   env = CPXopenCPLEX (&status);

   /* If an error occurs, the status value indicates the reason for
      failure.  A call to CPXgeterrorstring will produce the text of
      the error message.  Note that CPXopenCPLEX produces no output,
      so the only way to see the cause of the error is to use
      CPXgeterrorstring.  For other CPLEX routines, the errors will
      be seen if the CPXPARAM_ScreenOutput indicator is set to CPX_ON.  */

   if ( env == NULL ) {
      char errmsg[CPXMESSAGEBUFSIZE];
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

   /* Turn on data checking */

   status = CPXsetintparam (env, CPXPARAM_Read_DataCheck,
			    CPX_DATACHECK_WARN);
   if ( status ) {
      fprintf (stderr,
               "Failure to turn on data checking, error %d.\n", status);
      goto TERMINATE;
   }

   /* Create the problem. */

   lp = CPXcreateprob (env, &status, "transport");

   /* A returned pointer of NULL may mean that not enough memory
      was available or there was some other problem.  In the case of
      failure, an error message will have been written to the error
      channel from inside CPLEX.  In this example, the setting of
      the parameter CPXPARAM_ScreenOutput causes the error message to
      appear on stdout.  */

   if ( lp == NULL ) {
      fprintf (stderr, "Failed to create LP.\n");
      goto TERMINATE;
   }

   /* Now populate the problem with the data.  For building large
      problems, consider setting the row, column and nonzero growth
      parameters before performing this task. */

   status = populatebyrow (env, lp, convex);
   if ( status ) {
      fprintf (stderr, "Failed to populate problem.\n");
      goto TERMINATE;
   }

   /* Optimize the problem and obtain solution. */

   status = CPXmipopt (env, lp);
   if ( status ) {
      fprintf (stderr, "Failed to optimize LP.\n");
      goto TERMINATE;
   }

   /* Write a copy of the problem to a file. */

   status = CPXwriteprob (env, lp, "transport.lp", NULL);
   if ( status ) {
      fprintf (stderr, "Failed to write LP to disk.\n");
      goto TERMINATE;
   }

   status = CPXgetx (env, lp, x, 0, SUPPLY_X_DEMAND-1);
   if ( status ) {
      fprintf (stderr, "Failed to obtain solution.\n");
      goto TERMINATE;
   }

   solstat = CPXgetstat (env, lp);

   status = CPXgetobjval (env, lp, &objval);
   if ( status ) {
      fprintf (stderr, "Failed to obtain obj value.\n");
      goto TERMINATE;
   }

   /* Write the output to the screen. */

   printf ("\nSolution status : %d\n", solstat);
   printf ("Cost            : %.2f\n\n", objval);

   printf ("Solution values:\n");
   for (i = 0; i < NUM_SUPPLY; i++) {
      printf ("   %d: ", i);
      for (j = 0; j < NUM_DEMAND; j++) {
         printf("%.2f\t", x[varindex(i, j)]);
      }
      printf ("\n");
   }


TERMINATE:

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

      /* Note that CPXcloseCPLEX produces no output,
         so the only way to see the cause of the error is to use
         CPXgeterrorstring.  For other CPLEX routines, the errors will
         be seen if the CPXPARAM_ScreenOutput indicator is set to CPX_ON. */

      if ( status > 0 ) {
         char errmsg[CPXMESSAGEBUFSIZE];
         fprintf (stderr, "Could not close CPLEX environment.\n");
         CPXgeterrorstring (env, status, errmsg);
         fprintf (stderr, "%s", errmsg);
      }
   }

   return (status);

}  /* END main */


static int
varindex (int m, int n)
{
   return (m * NUM_DEMAND) + n;
}


static int
populatebyrow (CPXENVptr env,
	       CPXLPptr  lp,
               int convex)
{
   int status = 0;
   int zero   = 0;
   int i, j, k;
   double breakx[SUPPLY_X_DEMAND][4];
   double breaky[SUPPLY_X_DEMAND][4];
   double cost[SUPPLY_X_DEMAND];
   char *names[SUPPLY_X_DEMAND];
   double const *pwl_slope = NULL;

   if ( convex )
      pwl_slope = &convexslope[0];
   else
      pwl_slope = &concaveslope[0];

   for (i = 0; i < SUPPLY_X_DEMAND; i++) {
      names[i] = malloc(NAME_BUF_SIZE * sizeof(names[i]));
      if ( names[i] == NULL ) {
	 status = CPXERR_NO_MEMORY;
	 goto TERMINATE;
      }
   }

   /* Generate the break point data. */
   k = 0;
   for (i = 0; i < NUM_SUPPLY; i++) {
      for (j = 0; j < NUM_DEMAND; j++, k++) {
	 double midval;

	 if ( supply[i] < demand[j] )
	    midval = supply[i];
	 else
	    midval = demand[j];

	 breakx[k][0] = 0.0;
	 breakx[k][1] = 200.0;
	 breakx[k][2] = 400.0;
	 breakx[k][3] = midval;

	 breaky[k][0] = 0.0;
	 breaky[k][1] = breakx[k][1] * pwl_slope[0];
	 breaky[k][2] = breaky[k][1] +
	    pwl_slope[1] * (breakx[k][2] - breakx[k][1]);
	 breaky[k][3] = breaky[k][2] +
	    pwl_slope[2] * (midval - breakx[k][2]);
      }
   }

   /* x(varindex(i, j)) is the amount that is shipped from supplier i to
    * recipient j */
   for (i = 0; i < SUPPLY_X_DEMAND; i++) {
      sprintf(names[i], "x%d", i+1);
      cost[i] = 0.0;
   }
   status = CPXnewcols (env, lp, SUPPLY_X_DEMAND, cost,
                        NULL, NULL, NULL, names);
   if ( status )  goto TERMINATE;

   /* y(varindex(i, j)) is used to model the PWL cost associated with
    * this shipment. */
   for (i = 0; i < SUPPLY_X_DEMAND; i++) {
      sprintf(names[i], "y%d", i+1);
      cost[i] = 1.0;
   }
   status = CPXnewcols (env, lp, SUPPLY_X_DEMAND, cost,
                        NULL, NULL, NULL, names);
   if ( status )  goto TERMINATE;

   /* Supply must meet demand. */
   for (i = 0; i < NUM_SUPPLY; i++) {
      int    ind[NUM_DEMAND];
      double val[NUM_DEMAND];
      for(j = 0; j < NUM_DEMAND; j++) {
         ind[j] = varindex (i, j);
         val[j] = 1.0;
      }

      status = CPXaddrows (env, lp, 0, 1, NUM_DEMAND, &supply[i], "E",
                           &zero, ind, val, NULL, NULL);
      if ( status )  goto TERMINATE;
   }

   /* Demand must meet supply. */
   for (j = 0; j < NUM_DEMAND; j++) {
      int    ind[NUM_SUPPLY];
      double val[NUM_SUPPLY];
      for (i = 0; i < NUM_SUPPLY; i++) {
         ind[i] = varindex (i, j);
         val[i] = 1.0;
      }

      status = CPXaddrows (env, lp, 0, 1, NUM_SUPPLY, &demand[j], "E",
                           &zero, ind, val, NULL, NULL);
      if ( status )  goto TERMINATE;
   }

   /* Add the PWL constraints. */
   for (i = 0; i < SUPPLY_X_DEMAND; i++) {
      sprintf(names[i], "p%d", i+1);
   }

   for (i = 0; i < SUPPLY_X_DEMAND; i++) {
      status = CPXaddpwl (env, lp, SUPPLY_X_DEMAND + i, i,
                          pwl_slope[0], pwl_slope[NUM_SUPPLY - 1],
                          4, breakx[i], breaky[i], names[i]);
      if ( status )  goto TERMINATE;
   }

TERMINATE:

   for (i = 0; i < SUPPLY_X_DEMAND; i++)
      free_and_null ((char **) &names[i]);

   return (status);

}  /* END populatebyrow */


/* This simple routine frees up the pointer *ptr, and sets *ptr to NULL */

static void
free_and_null (char **ptr)
{
   if ( *ptr != NULL ) {
      free (*ptr);
      *ptr = NULL;
   }
} /* END free_and_null */


static void
usage (char *progname)
{
   fprintf (stderr, "Specify an argument to choose between convex and "
                    "concave problems\n");
   fprintf (stderr, "Usage: %s <model>\n", progname);
   fprintf (stderr, "   model = 0 -> convex piecewise linear model\n");
   fprintf (stderr, "   model = 1 -> concave piecewise linear model\n");
   fprintf (stderr, " Exiting...\n");
} /* END usage */
