## secure-hash
#### challenge
````
We advise you to replace uses of unordered_hash with our new SecureHashtable class, since we added advanced crypto to make it 14.3 times more secure.

Update: the binary was compiled with g++ and libstdc++, 64bit

We're running a demo version, try it now:

nc secure-hash.ctf.hackover.de 1337
````

### resources
[secure_hash.cpp](Hackover2018/crypto/secure-hash/secure_hash.cpp)

### idea
in ```main```:
```cpp
if (choice == 1) {
  if (name == "root") {
    printf("You are not root!\n");
    continue;
  }
  table.insert_keyvalue(name, password);
} else if (choice == 2) {
  if (table.lookup_keyvalue(name, password)) {
    printf("Success! Logged in as %s\n", name.c_str());
    if (name == "root") {
      printf("You win, the flag is %s\n", flag.c_str());
      return 0;
    }
  } else {
    printf("Invalid credentials!\n");
  }
}
```
To access the flag we need ```name == "root"``` and ```table.lookupvalue("root",...)==true```.
We can insert values to the table, but not with ```name=="root"```.

in ```sha512sum```:
```cpp
mdctx = EVP_CREATE_FN();
md = EVP_get_digestbyname("sha512");
EVP_MD_CTX_init(mdctx);
EVP_DigestInit_ex(mdctx, md, NULL);
EVP_DigestUpdate(mdctx, name.c_str(), name.size());
EVP_DigestUpdate(mdctx, password.c_str(), password.size());
EVP_DigestFinal_ex(mdctx, md_value, &md_len);
EVP_DESTROY_FN(mdctx);
```
We see that the ```std::strings name,password``` get loaded as ```char*``` via ```c_str()```. Using ```name="roottest",password="t"``` would resolve to the same checksum as ```name="root",password="testt"```.

### script
[solve.py](Hackover2018/crypto/secure-hash/solve.py) (needs pwn: ```python -m pip install pwn```)
```python
from pwn import *

r = remote("secure-hash.ctf.hackover.de",1337)

r.send("1\nroot" + "test"+"\n" + "t"+ "\n2\nroot\ntest" + "t"+"\n")

for y in range(7):
	print r.recvline()

r.interactive()
```
output:
```
[+] Opening connection to secure-hash.ctf.hackover.de on port 1337: Done
Main menu:

1 - Register new user

2 - Login

Name: Password: Main menu:

1 - Register new user

2 - Login

Name: Password: Success! Logged in as root

[*] Switching to interactive mode
You win, the flag is hackover18{00ps_y0u_mu5t_h4ve_h1t_a_v3ry_unlikely_5peci4l_c4s3}
[*] Got EOF while reading in interactive
$
[*] Interrupted
[*] Closed connection to secure-hash.ctf.hackover.de port 1337
```
### flag
hackover18{00ps_y0u_mu5t_h4ve_h1t_a_v3ry_unlikely_5peci4l_c4s3}
