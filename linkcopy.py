import sys
infiles = sys.argv[1:-1]
outfile = sys.argv[-1]
fo = open(outfile, encoding="utf-8")
for fn in infiles:
    f = open(fn, encoding="utf-8")
    fo.write(f.read())
    f.close()
fo.close()
