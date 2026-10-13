import sys
TARGET = {34109, 39546, 43895, 20139, 18992, 9212}
def rv(b, p):
    r = s = 0
    while True:
        c = b[p]; p += 1; r |= (c & 0x7f) << s; s += 7
        if c < 0x80: return r, p
def ev(n):
    o = bytearray()
    while True:
        c = n & 0x7f; n >>= 7
        if n: o.append(c | 0x80)
        else: o.append(c); return bytes(o)
def fields(b):
    p = 0; out = []
    while p < len(b):
        st = p; tag, p = rv(b, p); f, wt = tag >> 3, tag & 7
        if wt == 0: v, p = rv(b, p); out.append((f, wt, b[st:p], v))
        elif wt == 2:
            l, p2 = rv(b, p); out.append((f, wt, b[st:p2+l], b[p2:p2+l])); p = p2 + l
        elif wt == 5: p += 4; out.append((f, wt, b[st:p], None))
        elif wt == 1: p += 8; out.append((f, wt, b[st:p], None))
        else: raise Exception('wt %d' % wt)
    return out
