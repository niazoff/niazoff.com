---
date: 2020-10-15 9:41
description:
---
# Hello world: Building a site in Swift with Publish
Welcome to my new site built almost (save some CSS) entirely in Swift using John Sundell’s [Publish](https://github.com/JohnSundell/Publish) static site generator. John is the guy behind [swiftbysundell.com](https://swiftbysundell.com) and many more resources cherished by the iOS community. If you’re anything like me, you’ve been through multiple phases of sites built in ways ranging from raw HTML, Vapor Leaf to, possibly, Apple’s old iWeb app. Remember that? Maybe you’ve tried other generators like Jekyll or Hugo. Nothing has felt as natural to me as a Swift developer until now with Publish.

## Static sites vs. dynamic sites
First, what does “static” mean and when do you use it instead of a “dynamic” website? If you’re looking to build a chat web app or an online store that relies on a database, you’re gonna need a server constantly updating the user with the appropriate information. That makes the site dynamic. The server is building static files as needed and sending them your way. I’d recommend using [Vapor](https://vapor.codes) for that type of task. Contrast that with a static site that is just a bunch of files that are all prebuilt and waiting to be shown once you navigate to them. Static sites are [faster, safer and cheaper](https://www.netlify.com/blog/2016/05/18/9-reasons-your-site-should-be-static) to name a few but if every time you wanted to make a change to your header, for example, you’d need to edit each file, that would get extremely tedious and error-prone. That’s where static site generators like Publish come in. Generating a site with Publish is as easy as entering `publish generate` in the command line and it takes your Swift code and creates all those static HTML files for you that you can host wherever you’d like.

## Plot
You create the HTML using [Plot](https://github.com/JohnSundell/Plot), a type-safe [domain-specific language](https://en.wikipedia.org/wiki/Domain-specific_language) or DSL. This means `.h1(“Hello world”)` will be generated as `<h1>Hello world</h1>` and will make sure you’re only able to put values in there that make sense. Try throwing an `li` element in there and you’ll get an compile time error. This also allows Xcode to provide autocomplete suggestions while typing your code. Later, we’ll make use of Plot to create a theme which is the backbone of how our site is generated.

## Step 1: Install Publish CLI
It’s really easy to start a new project using the Publish command line tool. First, open Terminal and clone the Publish repository. Then, in the cloned file, run `make`.

```
$ git clone https://github.com/JohnSundell/Publish.git
$ cd Publish
$ make
```

## Step 2: Create a new website
Now all you have to do is create your website directory wherever you wish, change to that directory and enter `publish new`. 

```
$ mkdir MyTravels
$ cd MyTravels
$ publish new
```

At this point, you can open the project up in Xcode by entering `open Package.swift` and get started on the site.