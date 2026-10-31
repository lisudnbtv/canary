import re, sys, json
START, END, ESC = 0xFE, 0xFF, 0xFD
src, cx, cy, cz, R = sys.argv[1], int(sys.argv[2]), int(sys.argv[3]), int(sys.argv[4]), int(sys.argv[5])
data = open(src, 'rb').read()

def node(i):
    """parse node starting at data[i]==START; returns (type, props_bytes_unescaped, children, end_index)"""
    assert data[i] == START
    t = data[i+1]; i += 2
    props = bytearray(); children = []
    while True:
        c = data[i]
        if c == ESC:
            props.append(data[i+1]); i += 2
        elif c == START:
            ch, i = node(i); children.append(ch)
        elif c == END:
            return (t, bytes(props), children), i + 1
        else:
            props.append(c); i += 1

out = {}
for m in re.finditer(b'\xfe\x04', data):
    i = m.start()
    k = i - 1
    while k >= 0 and data[k] == ESC: k -= 1
    if (i - 1 - k) % 2 == 1: continue
    # header unescaped
    j = i + 2; hdr = bytearray()
    while len(hdr) < 5:
        c = data[j]
        if c == ESC: hdr.append(data[j+1]); j += 2
        else: hdr.append(c); j += 1
    bx = hdr[0] | hdr[1] << 8; by = hdr[2] | hdr[3] << 8; bz = hdr[4]
    if bz != cz or not (bx <= cx + R and bx + 255 >= cx - R and by <= cy + R and by + 255 >= cy - R): continue
    (t, props, children), _ = node(i)
    for (tt, tp, tch) in children:
        if tt not in (5, 14): continue
        x = bx + tp[0]; y = by + tp[1]
        if abs(x - cx) > R or abs(y - cy) > R: continue
        p = 2 + (4 if tt == 14 else 0)
        ground = None; items = []
        while p < len(tp):
            a = tp[p]
            if a == 3: p += 5
            elif a == 9: ground = tp[p+1] | tp[p+2] << 8; p += 3
            else: break
        for (it, ip, ich) in tch:
            if it == 6: items.append(ip[0] | ip[1] << 8)
        out['%d,%d' % (x, y)] = [ground] + items
json.dump(out, open(sys.argv[6], 'w'))
print(len(out))
