# SwiftJNChatApp
Demo chat web service for「Swift実践入門」刊行記念 Tech Talks


## Getting Starterd

### Flows
1. [Open Project with Xcode](https://github.com/noppoMan/SwiftJNChatApp/tree/master#1-open-project-with-xcode)
2. [Edit Your `Sources/Config/Database.swift`](https://github.com/noppoMan/SwiftJNChatApp#2-edit-your-sourcesconfigdatabaseswift)
3. [Schema Migration](https://github.com/noppoMan/SwiftJNChatApp#3-schema-migration)
4. [Run](https://github.com/noppoMan/SwiftJNChatApp#4-run)
5. [Open `http://localhost:3030` with Browser](https://github.com/noppoMan/SwiftJNChatApp#5-open-httplocalhost3030-with-browser)

### 1. Open Project with Xcode
```shell
$ git clone https://github.com/noppoMan/SwiftJNChatApp.git
$ cd SwiftJNChatApp
$ swift package generate-xcodeproj --type=executable
$ open *.xcodeproj 
```

### 2. Edit Your `Sources/Config/Database.swift`

<img src="https://cloud.githubusercontent.com/assets/1511276/23135620/ac93993c-f7dc-11e6-9679-ee48dce11616.png" width="600">

### 3. Add .env into Project Root

First, You need to create github Oauth Application and get `CLIENT_ID` AND `CLIENT_SECRET` from Your Application page.

<img src="https://cloud.githubusercontent.com/assets/1511276/23151633/d87272a4-f83f-11e6-87f7-dcce0bae83ad.png" width="600">

```
$ touch .env
echo "GITHUB_CLIENT_ID=YOUR_CLIENT_ID" >> .env
echo "GITHUB_CLIENT_SECRET=YOUR_SECRET" >> .env
echo "JWT_SECRET=foobar" >> .env
```

### 3. Schema Migration
```shell
$ swift build
$ ./.build/debug/Migration migrate:latest
```

### 4. Run

Select SwiftJNChatApp executable Schema from Schema List

<img src="https://cloud.githubusercontent.com/assets/1511276/23135500/4e86e100-f7dc-11e6-9fcc-491ff0398a86.png" width="300">

and then, press `Command-R` to run application

<img src="https://cloud.githubusercontent.com/assets/1511276/23135745/1d4b958a-f7dd-11e6-9992-205660038a79.png" width="300">  
Xcode says, Server Listening at localhost:3030. So Let's check it in Browser.

### 5. Open `http://localhost:3030` with Browser

<img src="https://cloud.githubusercontent.com/assets/1511276/23135851/8669fd2c-f7dd-11e6-8e03-18a1bd4e16e5.png" width="600">

That's it!

## License
SwiftJNChatApp is released under the MIT license. See LICENSE for details.
