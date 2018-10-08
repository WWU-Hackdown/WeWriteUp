## UnbreakMyStart
#### challenge
```
https://www.youtube.com/watch?v=p2Rch6WvPJE
```

### resources
[unbreak_my_start.tar.xz](unbreak_my_start.tar.xz)

### idea
We inspected the file signatures ("magic numbers") with vim, and compared them with (this)[https://www.garykessler.net/library/file_sigs.html].

```vim -c 'noau e unbreak_my_start.tar.xz '``` and in vim ```:%!xxd```

```
00000000: 504b 0304 1400 0800 0800 04e6 d6b4 4602  PK............F.
00000010: 0021 0116 0000 0074 2fe5 a3e0 07ff 007d  .!.....t/......}
00000020: 5d00 331b 0847 5472 2320 a8d7 45d4 9ae8  ].3..GTr# ..E...
00000030: 3a57 139f 493f c634 8905 8c4f 0bc6 3b67  :W..I?.4...O..;g
00000040: 7028 1a35 f195 abb0 2e26 666d 8c92 da43  p(.5.....&fm...C
00000050: 11e1 10ac 4496 e2ed 36cf 9c99 afe6 5a8e  ....D...6.....Z.
00000060: 311e cb99 f4be 6dca 943c 4410 8873 428a  1.....m..<D..sB.
00000070: 7c17 f47a d17d 7808 b7e4 22b8 ec19 9275  |..z.}x..."....u
00000080: 5073 0c34 5f9e 14ac 1986 d378 7b79 9f87  Ps.4_......x{y..
00000090: 0623 7369 4372 19da 6e33 0217 7f8d 0000  .#siCr..n3......
000000a0: 0000 001c 0f1d febd b436 8c00 0199 0180  .........6......
000000b0: 1000 00ad af23 35b1 c467 fb02 0000 0000  .....#5..g......
000000c0: 0459 5a0a                                .YZ.
```
Leave with ```:%!xxd -r``` and ```:q!```

We compared this with [test.tar.xz](test.tar.xz),which we created with ```tar -cJf test.tar.xz test/```:
```
00000000: fd37 7a58 5a00 0004 e6d6 b446 0200 2101  .7zXZ......F..!.
00000010: 1600 0000 742f e5a3 e027 ff00 7f5d 003a  ....t/...'...].:
00000020: 194a ce1d 909b 2778 1cff 698b 4ee6 7ff5  .J....'x..i.N...
00000030: 3c23 5c3b 3d00 48b1 de3c e395 97c1 0ba4  <#\;=.H..<......
00000040: 6564 60d0 c02d 4a20 e83c d900 2809 0eac  ed`..-J .<..(...
00000050: 5a52 a690 1442 c478 2c50 e656 f635 41ec  ZR...B.x,P.V.5A.
00000060: f0cf ddee 88f9 6398 b4cc 3cb5 1489 a0ff  ......c...<.....
00000070: c846 0d4f 9ea5 8fcb d53e c05d 64f1 dc4e  .F.O.....>.]d..N
00000080: b12c b516 9d74 c960 0f74 542d 4e73 4b8b  .,...t.`.tT-NsK.
00000090: 2d0f d653 9bb8 8b88 2ced e270 0000 0000  -..S....,..p....
000000a0: bfcd 08c1 b2f9 dad4 0001 9b01 8050 0000  .............P..
000000b0: 6683 7108 b1c4 67fb 0200 0000 0004 595a  f.q...g.......YZ
000000c0: 0a  
```
We see the endings are similar and the starts are similar with some bytes distance ```F.!.....t/```.
So we change the first bytes to the bytes of our test.tar.xz
This time we switch in vim to hex with ```:%!xxd -p```. Result:
```
fd377a585a000004e6d6b4460200210116000000742fe5a3e007ff007d5d
00331b084754722320a8d745d49ae83a57139f493fc63489058c4f0bc63b
6770281a35f195abb02e26666d8c92da4311e110ac4496e2ed36cf9c99af
e65a8e311ecb99f4be6dca943c44108873428a7c17f47ad17d7808b7e422
b8ec19927550730c345f9e14ac1986d3787b799f8706237369437219da6e
3302177f8d00000000001c0f1dfebdb4368c0001990180100000adaf2335
b1c467fb020000000004595a0a
```
Leaving with ```:%!xxd -p -r``` and ```:wq```
Next we use ```unxz unbreak_my_start.tar.xz``` and ```tar xf unbreak_my_start.tar``` and get flag.txt

### flag
hackover18{U_f0und_th3_B3st_V3rs10n}
