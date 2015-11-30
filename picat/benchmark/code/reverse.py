import time
import sys
sys.setrecursionlimit(20000)

def normal_reverse_list (inList):
    if inList == []:
        return []
    else:
        return [inList[-1]] + normal_reverse_list(inList[:-1])

def normal_reverse_tuple(inTuple):
    if inTuple == ():
        return ()
    else:
        return (inTuple[-1],) + normal_reverse_tuple(inTuple[:-1])

def tailend_reverse_list (inList):
    return tailend_reverse_list_aux(inList, [])
def tailend_reverse_list_aux(inList, acc):
    if inList == []:
        return acc
    else:
        return tailend_reverse_list_aux(inList[1:], [inList[0]]+acc)

def tailend_reverse_tuple (inTuple):
    return tailend_reverse_tuple_aux (inTuple, [])
def tailend_reverse_tuple_aux(inTuple, acc):
    if inTuple == ():
        return acc
    else:
        return tailend_reverse_tuple_aux(inTuple[1:], [inTuple[0]]+acc)

class Timer(object):
    def __init__(self, verbose=False):
        self.verbose = verbose

    def __enter__(self):
        self.start = time.time()
        return self

    def __exit__(self, *args):
        self.end = time.time()
        self.secs = self.end - self.start
        self.msecs = self.secs * 1000  # millisecs
        if self.verbose:
            print ('elapsed time: %f ms' % self.msecs)

def dummy(data):
    for i in range(len(data)):
        None

def bench(msg, call, lst, printFlag):
    res = []
    with Timer() as t:
        res = call(lst)
    print("%s : %s s" % (msg, t.secs))
    if (printFlag):
        print(res[:10])

size = 9000+1
bench("dummy", dummy, list(range(1, size)), False)
bench("normal reverse list", normal_reverse_list, list(range(1, size)), False)
bench("tailend reverse tuple", normal_reverse_tuple, tuple(range(1, size)), False)
bench("normal reverse list", tailend_reverse_list, list(range(1, size)), False)
bench("tailend reverse tuple", tailend_reverse_tuple, tuple(range(1, size)), False)
