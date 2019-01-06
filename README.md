<p align="center">
    <img src="https://user-images.githubusercontent.com/7799382/50582031-179fe380-0e14-11e9-9f16-bc8b8c69b41b.png" alt="DynamicJSON" />
</p>
<br>
<p align="center">
    <img src="https://user-images.githubusercontent.com/7799382/50578326-80279a00-0ded-11e9-8cfc-5cf45f70bbab.png" alt="Platform: iOS, macOS, watchOS, tvOS" />
    <a href="https://developer.apple.com/swift" target="_blank"><img src="https://user-images.githubusercontent.com/7799382/50578324-80279a00-0ded-11e9-9526-5e548f86e500.png" alt="Language: Swift 4.2" /></a>
    <img src="https://user-images.githubusercontent.com/7799382/50578325-80279a00-0ded-11e9-8a53-2c56bd762880.png" alt="License: MIT" />
</p>

<p align="center">
    <a href="#installation">Installation</a>
  • <a href="#usage">Usage</a>
  • <a href="#license">License</a>
</p>

DynamicJSON is a **dynamically typed** JSON parser built upon the new <a href="https://github.com/apple/swift-evolution/blob/master/proposals/0195-dynamic-member-lookup.md" target="_blank">`@dynamicMemberLookup`</a> feature introduced by Chris Lattner in Swift 4.2. This allows us to access arbitrary object members which are resolved at runtime, allowing Swift to be as flexible as JavaScript when it comes to JSON.

### Before

```swift
if let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
   let user = jsonObject["user"] as? [String: Any],
   let username = user["username"] as? String {
	// ...
}
```

### After

```swift
let username = JSON(data).user.username.string
```

## Installation

-   <a href="https://guides.cocoapods.org/using/using-cocoapods.html" target="_blank">CocoaPods</a>:

```ruby
pod 'DynamicJSON', '~> 2.0'
```
*(if you run into problems, `pod repo update` and try again)*

-   <a href="https://github.com/Carthage/Carthage" target="_blank">Carthage</a>:

```ruby
github "saoudrizwan/DynamicJSON"
```

-   Or drag and drop `DynamicJSON.swift` into your project.

And `import DynamicJSON` in the files you'd like to use it.

## Usage

### 1. Initialize 🐣

Throw `Any`thing into a `JSON` object to get started

```swift
let json = JSON(Data())
           JSON(123)
           JSON(["key": "value"])
           JSON(["element", 1])
           JSON("Hello world")
           JSON(false)
```

...or cast a literal as `JSON`

```swift
let json = "Hello world" as JSON
           123 as JSON
           [1, 2, 3] as JSON

let user: JSON = [
	"username": "Saoud",
	"age": 21,
	"address": [
	    "zip": "12345",
	    "city": "San Diego"
	]
]
```

### 2. Drill in ⛏

Treat `JSON` objects like you're in JavaScript Land

```swift
let dictionary = json.dictionary
let array = json[0].cars.array
let string = json.users[1].username.string
let nsnumber = json.creditCard.pin.number
let double = json[3][1].height.double
let int = json[0].age.int
let bool = json.biography.isHuman.bool
```

Note how `JSON` doesn't actually have properties like `cars` or `users`, instead it uses dynamic member lookup to traverse through its associated JSON data to find the object you're looking for.

In case you have a key that's an actual property of `JSON`, like `number` or `description` for example, just use the string subscript accessor like so:
```swift
let number = json.account.contact["number"].number
let description = json.user.biography["description"].string
```

### 3. Have fun 🤪

`JSON` conforms to `Comparable`

```swift
let json1 = JSON(jsonData1)
let json2 = JSON(jsonData2)

// Equality applies to all types (Dictionary, Array, String, NSNumber, Bool, NSNull)
let isEqual = json1 == json2

// Less/greater than only applies to NSNumbers (Double, Int) and Strings
let isLessThan = json1 < json2
let isLessThanOrEqual = json1 <= json2
let isGreaterThan = json1 > json2
let isGreaterThanOrEqual = json1 >= json2
```

Pretty print for debug purposes

```swift
print(json)
```

Convert to raw object

```swift
let anyObject = json.object
```

Convert to `Data`

```swift
let data = json.data() // optionally specify options...
```

## License

DynamicJSON uses the MIT license. Please file an issue if you have any questions or if you'd like to share how you're using DynamicJSON.

## Contribute

DynamicJSON is in its infancy, but provides the barebones of a revolutionary new way to work with JSON in Swift. Please feel free to send pull requests of any features you think would add to DynamicJSON and its philosophy.

## Questions?

Contact me by email <a href="mailto:hello@saoudmr.com">hello@saoudmr.com</a>, or by twitter <a href="https://twitter.com/sdrzn" target="_blank">@sdrzn</a>. Please create an <a href="https://github.com/saoudrizwan/DynamicJSON/issues">issue</a> if you come across a bug or would like a feature to be added.

## Notable Mentions

* [Paul Hudson](https://www.hackingwithswift.com/)'s wonderful literature over `@dynamicMemberLookup`
* Chris Lattner's Swift Evolution Propsal [SE-0195](https://github.com/apple/swift-evolution/blob/master/proposals/0195-dynamic-member-lookup.md)
* [SwiftyJSON](https://github.com/SwiftyJSON/SwiftyJSON) for giving me a better idea of what the community wants out of a JSON parser
* [Helge Heß](https://github.com/helje5) for helping [remove the need to use optional chaining](https://github.com/saoudrizwan/DynamicJSON/issues/4) (before v2.0.0)
