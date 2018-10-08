## i-love-heddha
#### challenge
````
A continuation of the Ez-Web challenge. enjoy

207.154.226.40:8080
````
### idea
http://207.154.226.40:8080/robots.txt
```
User-agent: * Disallow: /flag/
```

http://207.154.226.40:8080/flag/
```
flag.txt (linking to falg.txt)
```

http://207.154.226.40:8080/flag/flga.txt
```
404 Error
```

http://207.154.226.40:8080/flag/flag.txt
```
Bad luck buddy
```
Set Cookie ```isAllowed=true```.
```
You are using the wrong browser, 'Builder browser 1.0.1' is required
```
Set User-Agent ```Builder browser 1.0.1```
```
You are refered from the wrong location hackover.18 would be the correct place to come from.
```
Set Referer ```hackover.18```
```
aGFja292ZXIxOHs0bmdyeVczYlMzcnYzclM0eXNOMH0=
```
This is the flag, base64 encoded.

### script
```shell
curl http://207.154.226.40:8080/flag/flag.txt --cookie "isAllowed=true" --header "User-Agent: Builder browser 1.0.1" --header "Referer: hackover.18" | base64 --decode
```

### flag
hackover18{4ngryW3bS3rv3rS4ysN0}

[more write-ups](../../)
