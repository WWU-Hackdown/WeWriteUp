## title
#### challenge
```
Howdy mate! Just login and hand out the flag, aye! You can find on h18johndoe has all you need!

http://yo-know-john-dow.ctf.hackover.de:4567/login

alternative: 46.101.157.142:4567/login
```
## resources
[github](https://github.com/h18johndoe/user_repository/blob/master/user_repo.rb)

### idea
The web page needs an email to login, therefore we cloned the github-repo and looked at the commits with ```git log``` and checked the four emails on the website login.
john_doe@notes.h18 worked.

The login function in the ruby script is vulnerable to SQL-Injections through the reversed password.
We used ```-- '1'= '1' ro '1``` as password and got the flag.

### flag
hackover18{I_KN0W_H4W_70_STALK_2018}

[more write-ups](../../)
