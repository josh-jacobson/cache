# Cache simulator.

import sys
from random import randint

def getAlign(addr, align):
    return (addr / align) * align

def checkAlign(addr, align):
    return addr == getAlign(addr, align)

def assertAlign(addr, align):
    assert checkAlign(addr, align)


class CacheBlock:
    def __init__(self, blksize, nsubblk, writeBack, writeAllocate, base, nextCache):
        if blksize % nsubblk != 0:
            print "nsubblk should divide blksize"
            sys.exit(1)
        self.blksize = blksize
        self.nsubblk = nsubblk
        self.sbsize = blksize / nsubblk
        self.wa = writeAllocate
        self.wb = writeBack

        self.valids = [False] * self.nsubblk
        self.dirties = [False] * self.nsubblk
        self.base = base
        self.timestamp = 0

        self.nextCache = nextCache

    def assertAddress(self, addr, size):
        assertAlign(addr, size)
        assert addr >= self.base
        assert addr + size <= self.base + self.blksize

    def updateTimestamp(self, timestamp):
        self.timestamp = timestamp

    def evict(self):
        for i in xrange(self.nsubblk):
            if self.valids[i] and self.dirties[i]:
                self.nextCache.evictWrite(self.base + i * self.sbsize, self.sbsize)

    def write(self, addr, size):
        self.assertAddress(addr, size)
        offset = addr - self.base
        isubblk = offset / self.sbsize
        if self.valids[isubblk]:
            if self.wb:
                self.dirties[isubblk] = True
            else:
                self.nextCache.write(addr, size)
            return True
        else:
            if self.wa:
                self.nextCache.read(getAlign(addr, self.sbsize), self.sbsize)
                self.valids[isubblk] = True
                if self.wb:
                    self.dirties[isubblk] = True
                else:
                    self.nextCache.write(addr, size)
            else:
                self.nextCache.write(addr, size)
            return False

    def read(self, addr, size):
        self.assertAddress(addr, size)
        offset = addr - self.base
        isubblk = offset / self.sbsize
        if self.valids[isubblk]:
            return True
        else:
            self.nextCache.read(getAlign(addr, self.sbsize), self.sbsize)
            self.valids[isubblk] = True
            return False
    
    def debugString(self):
        dstr = " %4i " % self.timestamp
        for i in xrange(self.nsubblk):
            dstr += " %08x %i%i " % (self.base + self.sbsize * i, self.valids[i], self.dirties[i])
        return dstr

class DummyCache:
    def write(self, addr, size):
        pass

    def read(self, addr, size):
        pass

    def _write(self, addr, size, isEvict):
        pass

class Cache:
    def __init__(self, name, nline, linesize, nway, writeBack, writeAllocate, nsubblk):
        self.name = name
        self.nline = nline
        self.linesize = linesize
        self.nway = nway
        self.writeBack = writeBack
        self.writeAllocate = writeAllocate
        self.nsubblk = nsubblk;

        self.lowerLevel = None

        self.missCnt = 0
        self.hitCnt = 0
        self.evictCnt = 0

        self.timestamp = 0

        self.entries = []
        for i in xrange(nline):
            self.entries.append(dict())

    def setLowerLevel(self, cache):
        self.lowerLevel = cache

    def getNextCache(self):
        if self.lowerLevel == None:
            return DummyCache()
        else:
            return self.lowerLevel

    def evictWrite(self, addr, size):
        self._write(addr, size, True)

    def write(self, addr, size):
        self._write(addr, size, False)

    def _write(self, addr, size, isEvict):
        self.timestamp += 1
        index = (addr / self.linesize) % self.nline
        tag = (addr / self.linesize) / self.nline
        entry = self.entries[index]
        if tag in entry:
            blk = entry[tag]
        else:
            if not self.writeAllocate:
                self.getNextCache()._write(addr, size, isEvict)
                if not isEvict:
                    self.missCnt += 1
                return
            if len(entry) == self.nway:
                minblk = None
                minkey = None
                for key in entry:
                    if minblk == None or entry[key].timestamp < minblk.timestamp:
                        minblk = entry[key]
                        minkey = key
                minblk.evict()
                self.evictCnt += 1
                del entry[minkey]
            assert len(entry) < self.nway
            blk = CacheBlock(self.linesize, self.nsubblk, self.writeBack, self.writeAllocate, getAlign(addr, self.linesize), self.getNextCache())
        writeHit = blk.write(addr, size)
        if not isEvict:
            if writeHit:
                self.hitCnt += 1
            else:
                self.missCnt += 1
            blk.updateTimestamp(self.timestamp)
        entry[tag] = blk

    def read(self, addr, size):
        self.timestamp += 1
        index = (addr / self.linesize) % self.nline
        tag = (addr / self.linesize) / self.nline
        entry = self.entries[index]
        if tag in entry:
            blk = entry[tag]
        else:
            if len(entry) == self.nway:
                minblk = None
                minkey = None
                for key in entry:
                    if minblk == None or entry[key].timestamp < minblk.timestamp:
                        minblk = entry[key]
                        minkey = key
                minblk.evict()
                self.evictCnt += 1
                del entry[minkey]
            assert len(entry) < self.nway
            blk = CacheBlock(self.linesize, self.nsubblk, self.writeBack, self.writeAllocate, getAlign(addr, self.linesize), self.getNextCache())
        if blk.read(addr, size):
            self.hitCnt += 1
        else:
            self.missCnt += 1
        blk.updateTimestamp(self.timestamp)
        entry[tag] = blk

    def write4(self, addr):
        self.write(addr, 4)

    def read4(self, addr):
        self.read(addr, 4)

    def getAddr(self, tag, index, offset):
        index = (index % self.nline) * self.nindex
        offset = offset % self.linesize
        addr = tag * self.nline * self.linesize + index + offset
        addr = addr % 0x100000000
        return addr

    def decodeAddr(self, addr):
        offset = addr % self.linesize
        addr = addr / self.linesize
        index = addr % self.nline
        tag = addr / self.nline
        return tag, index, offset

    def dumpStats(self):
        print self.name
        print "\tHit Count:\t" + str(self.hitCnt)
        print "\tMiss Count:\t" + str(self.missCnt)
        print "\tEvict Count:\t" + str(self.evictCnt)

    def commentStats(self, traceGen):
        traceGen.comment(self.name)
        traceGen.comment("\tHit Count:\t" + str(self.hitCnt))
        traceGen.comment("\tMiss Count:\t" + str(self.missCnt))
        traceGen.comment("\tEvict Count:\t" + str(self.evictCnt))

    def resetStats(self):
        self.missCnt = 0
        self.hitCnt = 0
        self.evictCnt = 0

    def debugString(self):
        dstr = self.name + "\n"
        for i in xrange(self.nline):
            dstr += "- Index " + str(i) + ":\n"
            for tag in self.entries[i]:
                dstr += "\t[%x]" % tag
                dstr += self.entries[i][tag].debugString() + "\n"
        return dstr
