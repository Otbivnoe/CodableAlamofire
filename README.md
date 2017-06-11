# CodableAlamofire
An extension for Alamofire that converts JSON data into Decodable Objects

# Requirements
 - Swift 4+
 - Xcode 9+

# Installation 🔥

## CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Swift and Objective-C Cocoa projects. It has over eighteen thousand libraries and can help you scale your projects elegantly. You can install it with the following command:

```bash
$ sudo gem install cocoapods
```

Because of `Alamofire` supports Swift 3 at the moment and we can't point out the branch of dependency in `.podspec` file. 
Whe have to overrride the current pod:

```ruby
# TODO: Remove this after all pods are converted to swift 4
def swift4_overrides
    pod 'Alamofire', git: 'https://github.com/Alamofire/Alamofire.git', branch: 'swift4'
end

target 'Test' do
  use_frameworks!

  swift4_overrides
  pod 'CodableAlamofire', :git => 'https://github.com/Otbivnoe/CodableAlamofire.git'
  
end
```

## Carthage

**NOTE: Don't forget to set the correct Command Line Tools:**
*Xcode > Preferences > Locations > Command Line Tools > Xcode 9.0.*


[Carthage](https://github.com/Carthage/Carthage) is a decentralized dependency manager that builds your dependencies and provides you with binary frameworks.

You can install Carthage with [Homebrew](http://brew.sh/) using the following command:

```bash
$ brew update
$ brew install carthage
```
To integrate CodableAlamofire into your Xcode project using Carthage, specify it in your `Cartfile`:
```odgl
github "Otbivnoe/CodableAlamofire"
```

Run `carthage update` to build the framework and drag the built `CodableAlamofire.framework` into your Xcode project.
