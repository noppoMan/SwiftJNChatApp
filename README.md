# SwiftJNChatApp
Demo chat web service for「Swift実践入門」刊行記念 Tech Talks


# Getting Starterd

### Environement Variables

You may need to specify following `Environement Variables` to run application successfully.

* `MYSQL_HOST`: default is localhost
* `MYSQL_USER`: default is root
* `MYSQL_PASSWORD`: default is null
* `GITHUB_CLIENT_ID`
* `GITHUB_CLIENT_SECRET`
* `JWT_SECRET`

## Linux

On the Linux, it's easy to run application with Docker

```shell
$ git clone https://github.com/noppoMan/SwiftJNChatApp.git
$ cd SwiftJNChatApp

# create .env
$ touch .env
echo "GITHUB_CLIENT_ID=YOUR_CLIENT_ID" >> .env
echo "GITHUB_CLIENT_SECRET=YOUR_SECRET" >> .env
echo "JWT_SECRET=foobar" >> .env
echo "MYSQL_HOST=host" >> .env
echo "MYSQL_USER=user" >> .env
echo "MYSQL_PASSWORD=password" >> .env

# Build and run Server and Schema Migrations with Docker
docker build -t swiftjn-chat-app .
docker run -v /path/to/your/.env:/var/www/app/.env swiftjn-chat-app
docker exec -it swiftjn-chat-app /var/www/app/.build/debug/Migration migrate:latest
```

## MacOSX

### Flows
1. [Open Project with Xcode](https://github.com/noppoMan/SwiftJNChatApp/tree/master#1-open-project-with-xcode)
2. [Add `.env` into Project Root](https://github.com/noppoMan/SwiftJNChatApp/tree/master#2-add-env-into-project-root)
3. [Schema Migration](https://github.com/noppoMan/SwiftJNChatApp#3-schema-migration)
4. [Run](https://github.com/noppoMan/SwiftJNChatApp#4-run)

### 1. Open Project with Xcode
```shell
$ git clone https://github.com/noppoMan/SwiftJNChatApp.git
$ cd SwiftJNChatApp
$ swift package generate-xcodeproj --type=executable
$ open *.xcodeproj 
```

### 2. Add `.env` into Project Root

First, You need to create github Oauth Application and get `CLIENT_ID` AND `CLIENT_SECRET` from Your Application page.

<img src="https://cloud.githubusercontent.com/assets/1511276/23151633/d87272a4-f83f-11e6-87f7-dcce0bae83ad.png" width="600">

```
$ touch .env
echo "GITHUB_CLIENT_ID=YOUR_CLIENT_ID" >> .env
echo "GITHUB_CLIENT_SECRET=YOUR_SECRET" >> .env
echo "JWT_SECRET=foobar" >> .env
echo "MYSQL_HOST=host" >> .env
echo "MYSQL_USER=user" >> .env
echo "MYSQL_PASSWORD=password" >> .env
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
Xcode says, Server Listening at localhost:3030.



## Open `http://localhost:3030` with Browser

If you finished to run application on Linux or Mac, let's check it in Browser.

<img src="https://cloud.githubusercontent.com/assets/1511276/23135851/8669fd2c-f7dd-11e6-8e03-18a1bd4e16e5.png" width="600">

That's it!

## License
SwiftJNChatApp is released under the MIT license. See LICENSE for details.

