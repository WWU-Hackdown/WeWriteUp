#python2
from pwn import *

r = remote("secure-hash.ctf.hackover.de",1337)

r.send("1\nroot" + "test"+"\n" + "t"+ "\n2\nroot\ntest" + "t"+"\n")

for y in range(7):
	print r.recvline()

r.interactive()

