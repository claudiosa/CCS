SYSTEM     = x86-64_linux
LIBFORMAT  = static_pic

#------------------------------------------------------------
#
# When you adapt this makefile to compile your CPLEX programs
# please copy this makefile and set CPLEXDIR and CONCERTDIR to
# the directories where CPLEX and CONCERT are installed.
#
#------------------------------------------------------------
### FIXED HERE
CPLEXDIR      = /opt/ibm/ILOG/CPLEX_Studio129/cplex
CONCERTDIR    = /opt/ibm/ILOG/CPLEX_Studio129/concert

# ---------------------------------------------------------------------
# Compiler selection 
# ---------------------------------------------------------------------

CCC = g++ -O0
CC  = gcc -O0

# ---------------------------------------------------------------------
# Compiler options 
# ---------------------------------------------------------------------

CCOPT = -m64 -O -fPIC -fno-strict-aliasing -fexceptions -DNDEBUG -DIL_STD
COPT  = -m64 -fPIC -fno-strict-aliasing

# ---------------------------------------------------------------------
# Link options and libraries
# ---------------------------------------------------------------------

CPLEXBINDIR   = $(CPLEXDIR)/bin/$(BINDIST)
CPLEXJARDIR   = $(CPLEXDIR)/lib/cplex.jar
CPLEXLIBDIR   = $(CPLEXDIR)/lib/$(SYSTEM)/$(LIBFORMAT)
CONCERTLIBDIR = $(CONCERTDIR)/lib/$(SYSTEM)/$(LIBFORMAT)

# For dynamic linking
CPLEXBINDIR   = $(CPLEXDIR)/bin/$(SYSTEM)
CPLEXLIB      = cplex$(dynamic:yes=1290)
run           = $(dynamic:yes=LD_LIBRARY_PATH=$(CPLEXBINDIR))

CCLNDIRS  = -L$(CPLEXLIBDIR) -L$(CONCERTLIBDIR) $(dynamic:yes=-L$(CPLEXBINDIR))
CLNDIRS   = -L$(CPLEXLIBDIR) $(dynamic:yes=-L$(CPLEXBINDIR))
CCLNFLAGS = -lconcert -lilocplex -l$(CPLEXLIB) -lm -lpthread -ldl
CLNFLAGS  = -l$(CPLEXLIB) -lm -lpthread -ldl


all:
	make all_c
	make all_cpp

execute: all
	make execute_c
	make execute_cpp

CONCERTINCDIR = $(CONCERTDIR)/include
CPLEXINCDIR   = $(CPLEXDIR)/include
### FOR EXAMPLES IN CPLEXDIR
#EXDIR         = $(CPLEXDIR)/examples
#EXINC         = $(EXDIR)/include
#EXDATA        = $(EXDIR)/data
#EXSRCC        = $(EXDIR)/src/c
#EXSRCCX       = $(EXDIR)/src/c_x
#EXSRCCPP      = $(EXDIR)/src/cpp

CFLAGS  = $(COPT)  -I$(CPLEXINCDIR)
CCFLAGS = $(CCOPT) -I$(CPLEXINCDIR) -I$(CONCERTINCDIR) 

#------------------------------------------------------------
#  make all      : to compile the examples. 
#  make execute  : to compile and execute the examples.
#------------------------------------------------------------
## The EXECUTABLE
C_EX =  transport test_main
CX_EX =  xtransport
CPP_EX =  ilotransport 

all_c: $(C_EX) $(CX_EX)

all_cpp: $(CPP_EX)

execute_c: $(C_EX) $(CX_EX)
	$(run) ./transport 1
	$(run) ./test_main 1
	$(run) ./xtransport 1

execute_cpp: $(CPP_EX)
	$(run) ./ilotransport 1

# ------------------------------------------------------------

clean :
	/bin/rm -rf *.o *~ *.class
	/bin/rm -rf $(C_EX) $(CX_EX) $(CPP_EX)
	/bin/rm -rf *.mps *.ord *.sos  *.sav *.net *.msg *.log *.clp

# ------------------------------------------------------------
#
# The examples -- CHANGE IF YOU
#

transport: transport.o
	$(CC) $(CFLAGS) $(CLNDIRS) -o transport transport.o $(CLNFLAGS)
transport.o: transport.c
	$(CC) -c $(CFLAGS) transport.c -o transport.o

xtransport: xtransport.o
	$(CC) $(CFLAGS) $(CLNDIRS) -o xtransport xtransport.o $(CLNFLAGS)
xtransport.o: xtransport.c
	$(CC) -c $(CFLAGS) xtransport.c -o xtransport.o

ilotransport: ilotransport.o
	$(CCC) $(CCFLAGS) $(CCLNDIRS) -o ilotransport ilotransport.o $(CCLNFLAGS)
ilotransport.o: ilotransport.cpp
	$(CCC) -c $(CCFLAGS) ilotransport.cpp -o ilotransport.o

#### C LANGUAGE ... TEST_MAIN
test_main: test_main.o
	$(CC) $(CFLAGS) $(CLNDIRS) -o test_main test_main.o $(CLNFLAGS)
test_main.o: test_main.c
	$(CC) -c $(CFLAGS) test_main.c -o test_main.o

# Local Variables:
# mode: makefile
# End:
