<p align="center">
  <img src="http://i.imgur.com/x2E68WN.png" alt="CodableAlamofire"/>
</p>

[![Build Status](https://travis-ci.org/Otbivnoe/CodableAlamofire.svg?branch=master)](https://travis-ci.org/Otbivnoe/CodableAlamofire)
![Swift 4.0.x](https://img.shields.io/badge/Swift-4.0-orange.svg)
[![SPM compatible](https://img.shields.io/badge/SPM-compatible-brightgreen.svg)](https://github.com/apple/swift-package-manager)
[![Carthage Compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
[![Version](https://img.shields.io/cocoapods/v/CodableAlamofire.svg?style=flat)](http://cocoadocs.org/docsets/CodableAlamofire)
![platforms](https://img.shields.io/badge/platforms-iOS%20%7C%20macOS%20%7C%20tvOS%20%7C%20watchOS%20%7C%20Linux-333333.svg)

**Swift 4 introduces a new `Codable` protocol that lets you serialize and deserialize custom data types without writing any special code and without having to worry about losing your value types. 🎉**

**Awesome, isn't it? And this library helps you write less code! It's an extension for `Alamofire` that converts `JSON` data into `Decodable` object.**

### Useful Resources:
- [Encoding and Decoding Custom Types](https://developer.apple.com/documentation/foundation/archives_and_serialization/encoding_and_decoding_custom_types) - Article by Apple
- [Using JSON with Custom Types](https://developer.apple.com/documentation/foundation/archives_and_serialization/using_json_with_custom_types) - Swift Playground
- Also there is a special session from `WWDC2017` that covers this new feature - [What's New in Foundation](https://developer.apple.com/videos/play/wwdc2017/212/)

# Usage

Let's decode a simple json file:
```
{
    "result": {
        "libraries": [
            {
                "name": "Alamofire",
                "stars": 23857,
                "url": "https://github.com/Alamofire/Alamofire",
                "random_date_commit": 1489276800
            },
            {
                "name": "RxSwift",
                "stars": 9600,
                "url": "https://github.com/ReactiveX/RxSwift",
                "random_date_commit": 1494547200
            }	
        ]
    }
}
```

with the following Swift model: 

```swift
private struct Repo: Decodable {
    let name: String
    let stars: Int
    let url: URL
    let randomDateCommit: Date
    
    private enum CodingKeys: String, CodingKey {
        case name
        case stars
        case url
        case randomDateCommit = "random_date_commit"
    }
}
```

There is a similar method to `responseData`, `responseJSON` - **`responseDecodableObject`**:

```swift 
func responseDecodableObject<T: Decodable>(queue: DispatchQueue? = nil, keyPath: String? = nil, decoder: JSONDecoder = JSONDecoder(), completionHandler: @escaping (DataResponse<T>) -> Void)
```

- `queue` - The queue on which the completion handler is dispatched.
- `keyPath` - The keyPath where object decoding should be performed.
- `decoder` - The decoder that performs the decoding of JSON into semantic `Decodable` type.

```swift
let url = URL(string: "https://raw.githubusercontent.com/otbivnoe/CodableAlamofire/master/keypathArray.json")!
let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .secondsSince1970 // It is necessary for correct decoding. Timestamp -> Date.

Alamofire.request(url).responseDecodableObject(keyPath: "result.libraries", decoder: decoder) { (response: DataResponse<[Repo]>) in
    let repo = response.result.value
    print(repo)
}
```

### Note: 
 - For array: `DataResponse<[Repo]>`
 - For single object: `DataResponse<Repo>`

# Requirements
 - Swift 4+
 - Xcode 9+

# Installation 🔥

## CocoaPods

[CocoaPods](http://cocoapods.org) is a dependency manager for Swift and Objective-C Cocoa projects. It has over eighteen thousand libraries and can help you scale your projects elegantly. You can install it with the following command:

```bash
$ sudo gem install cocoapods
```

To integrate CodableAlamofire, simply add the following line to your `Podfile`:

```ruby
target 'Test' do
  use_frameworks!

  pod 'CodableAlamofire'
  
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
