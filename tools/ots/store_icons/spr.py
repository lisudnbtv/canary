import sys,json
ap=open('/home/claude/canary/data/items/appearances.dat','rb').read()
def varint(b,i):
    v=0;s=0
    while True:
        c=b[i];i+=1;v|=(c&0x7F)<<s;s+=7
        if c<0x80: return v,i
def fields(b):
    i=0
    while i<len(b):
        k,i=varint(b,i);f,w=k>>3,k&7
        if w==0: v,i=varint(b,i)
        elif w==2:
            l,i=varint(b,i);v=b[i:i+l];i+=l
        elif w==5: v=b[i:i+4];i+=4
        elif w==1: v=b[i:i+8];i+=8
        yield f,w,v
want=set(map(int,sys.argv[1:]))
res={}
for f,w,v in fields(ap):
    if f!=1: continue
    iid=None;spr=None
    for f2,w2,v2 in fields(v):
        if f2==1: iid=v2
        elif f2==2 and spr is None:
            for f3,w3,v3 in fields(v2):
                if f3==3:
                    for f4,w4,v4 in fields(v3):
                        if f4==5:
                            if w4==2: spr,_=varint(v4,0)
                            else: spr=v4
                            break
    if iid in want: res[iid]=spr
print(json.dumps(res))
