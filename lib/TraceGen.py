# Tools for generating memory access traces.
# Each test case has two traces, one for addres/ctrl and one for data.
# These traces are supposed to be loaded in to the cache tester.
import sys
from random import randint

class TraceGen:
    def __init__(self, addrTrace, dataTrace):
        self.addrTrace = addrTrace
        self.dataTrace = dataTrace
        self.cnt = 0
        self.data = dict()
        self.cache = None

    def setCache(self, cache):
        self.cache = cache

    def read(self, addr):
        if addr >= 0x80000000:
            print "Address overflow."
            sys.exit(1)
        if addr in self.data:
            if self.cache:
                self.cache.read4(addr)
            self.addrTrace.write("%(addr)08x / %(data)08x;\n" % \
                    {"addr" : self.cnt * 4, "data" : addr})
            self.dataTrace.write("%(addr)08x / %(data)08x;\n" % \
                    {"addr" : self.cnt * 4, "data" : self.data[addr]})
            self.cnt += 1
        else:
            print "Read uninitialized memory."
            sys.exit(1)

    def set(self, addr, data):
        self.data[addr] = data

    def qset(self, addr):
        data = randint(0, 2147483647)
        self.set(self, data)

    def dumpMemory(self, memTrace):
        for addr in self.data:
            memTrace.write("%(addr)08x / %(data)08x;\n" % \
                    {"addr" : addr, "data" : self.data[addr]})

    def write(self, addr, data):
        self.data[addr] = data
        if self.cache:
            self.cache.write4(addr)
        addr |= 0x80000000
        self.addrTrace.write("%(addr)08x / %(data)08x;\n" % \
                {"addr" : self.cnt * 4, "data" : addr})
        self.dataTrace.write("%(addr)08x / %(data)08x;\n" % \
                {"addr" : self.cnt * 4, "data" : data})
        self.cnt += 1

    def qwrite(self, addr):
        data = randint(0, 2147483647)
        self.write(addr, data)

    def comment(self, txt = None):
        if txt:
            self.addrTrace.write("# " + txt.replace("\n", "\n# ") + "\n")
            self.dataTrace.write("# " + txt.replace("\n", "\n# ") + "\n")
        else:
            self.addrTrace.write("\n")
            self.dataTrace.write("\n")

    def close(self):
        self.addrTrace.close()
        self.dataTrace.close()
