CC=g++
override CFLAGS+=-DIL_STD -c -Wall -O3 --std=c++11 -I/opt/ibm/ILOG/CPLEX_Studio1263/concert/include -I/opt/ibm/ILOG/CPLEX_Studio1263/cplex/include -Wno-ignored-attributes -Wno-deprecated-declarations -I/opt/ibm/ILOG/CPLEX_Studio1263/opl/include/
override CFLAGSL+=-lcplex -lilocplex -lconcert -lcplex -lm -lpthread -lgmp -lz -I/home/h3nnn4n/scipoptsuite-3.2.1/scip-3.2.1/src
override LDFLAGS+=-DIL_STD -L/opt/ibm/ILOG/CPLEX_Studio1263/cplex/lib/x86-64_linux/static_pic/ \
		  -L/opt/ibm/ILOG/CPLEX_Studio1263/concert/lib/x86-64_linux/static_pic/ -lilocplex -lconcert -lcplex -lm -lpthread -lgmp -lz \
		  -L/home/h3nnn4n/scipoptsuite-3.2.1/scip-3.2.1/lib -lscip.linux.x86_64.gnu.opt \
                  -lobjscip.linux.x86_64.gnu.opt -llpispx.linux.x86_64.gnu.opt -lnlpi.cppad.linux.x86_64.gnu.opt \
                  -fomit-frame-pointer -mtune=native -lsoplex.linux.x86_64.gnu.opt \
                  -lzimpl.linux.x86_64.gnu.opt -lreadline -lncurses -Wl,-rpath,/home/h3nnn4n/scipoptsuite-3.2.1/scip-3.2.1/lib

SOURCES=                          \
    main.cpp                      \
    chvatal.cpp                   \
    reader.cpp                    \
    printer_to_graphviz.cpp       \
    backtrack.cpp utils.cpp       \
    random.cpp                    \
    branch_and_price.cpp          \
    model_cplex.cpp               \
    model_scip.cpp                \
    subproblem.cpp                \
    load_balancer.cpp             \
    perf_data.cpp                 \
    time_keeper.cpp               \
    tabu_search.cpp               \
    greedy_heur.cpp               \
    meta_heuristics_utils.cpp     \
    ant_colony_optimization.cpp   \
    exact_subproblem.cpp	      \
    pricer_csp.cpp 	    		  \
    simmulated_annealing.cpp

OBJECTS=$(SOURCES:.cpp=.o)
EXECUTABLE=magic

all: $(SOURCES) $(EXECUTABLE)

$(EXECUTABLE): $(OBJECTS)
	$(CC) $(LDFLAGS) $(OBJECTS) -o $@ $(CFLAGSL)

.cpp.o:
	$(CC) $(CFLAGS) $< -o $@ $(CFLAGSL)

.PHONY: clean
clean:
	$(RM) $(OBJECTS) $(EXECUTABLE)
