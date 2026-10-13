import lzma,io,json,glob,os,struct
from PIL import Image
U='/mnt/user-data/uploads/OTS/tibia-client-15.25.0a00a0/assets/'
def sheet(fn):
    b=open(U+fn,'rb').read()
    i=0
    while b[i]==0: i+=1
    assert b[i:i+5]==bytes([0x70,0x0A,0xFA,0x80,0x24]),b[i:i+8].hex()
    i+=5
    while b[i]&0x80: i+=1
    i+=1
    props=b[i:i+5]; i+=5+8
    d=lzma.LZMADecompressor(format=lzma.FORMAT_ALONE).decompress(props+b'\xff'*8+b[i:])
    return Image.open(io.BytesIO(d)).convert('RGBA')
