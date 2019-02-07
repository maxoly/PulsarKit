# PulsarKit

![Platform](https://img.shields.io/badge/Platform-iOS-blue.svg)
![iOS 10.0+](http://img.shields.io/badge/iOS-10.0%2B-blue.svg)
![Swift 4.2.x](https://img.shields.io/badge/Swift-4.2-orange.svg)
![Version](https://img.shields.io/cocoapods/v/PulsarKit.svg?style=flat)
[![Build Status](https://travis-ci.org/maxoly/PulsarKit.svg)](https://travis-ci.org/maxoly/PulsarKit)
[![LICENSE](http://img.shields.io/badge/License-MIT-lightgrey.svg)](/LICENSE)
[![Twitter](https://img.shields.io/badge/twitter-@maxoly-blue.svg?style=flat)](http://twitter.com/maxoly)

---

## What is PulsarKit?
PulsarKit is a simple and beautiful wrapper around the official UICollectionView API written in pure Swift. PulsarKit is a library that lets you populate and update collection views **simply using *your models***.

This framework is lightly inspire by [Lighter view controllers](http://objc.io/issues/1-view-controllers/lighter-view-controllers/) and UITableViewSource and UICollectionViewSource in [Xamarin Platform](https://developer.xamarin.com/guides/ios/user_interface/tables/part_1_-_table_parts_and_functionality/).

# Contents

- [Introduction](#introduction)
- [Features Highlights](#features-highlights)
- [Requirements](#requirements)
- [Communication](#communication)
- [Installation](#installation)
- [Documentation](#documentation)
- [Author](#author)
- [License](#license)

## Introduction

**Never** implement `UICollectionViewDataSource`, `UICollectionViewDelegate` and `UICollectionViewDelegateFlowLayout` again.

PulsarKit is a small, focused library that lets you populate and update UICollectionView views from **your models**. Forget about dequeuing and type casting cells. Forget about converting an IndexPath to a model object. PulsarKit will hand you dequeued views of the correct type along with the right model object for the index path. You can focus on applying your custom data to your custom view.

## Features Highlights

- [x] Fluent interface configuration (`.when(Model).use(Cell)`)
- [x] Easy section and row insertion, updation, deletion and moving (`source.add(model: ...)`)
- [x] Easy and fine grained row event handling (`.on.didSelect`)
- [x] Drop-in ready to use view controllers

## Requirements

PulsarKit 1.0.x is compatible with:
- **Swift 4.2+**
- iOS 10+
- Xcode 10+

## Communication

* If you **need help with an PulsarKit feature**, open an issue.
* If you'd like to **discuss a feature request**, open an issue.
* If you **found a bug**, open an issue. The more detail the better!
* If you need to **find or understand an API**, check our documentation or Apple's documentation for UICollectionView, on top of which PulsarKit is built.
* If you want to **contribute**, submit a pull request.

## Installation

PulsarKit is available through [CocoaPods](http://cocoapods.org). 
CocoaPods is a dependency manager for Cocoa projects. You can install it with the following command:
```shell
$ gem install cocoapods
```

To integrate PulsarKit into your Xcode project using CocoaPods, specify it in your Podfile:
```ruby
source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '10.0'
use_frameworks!

target '<target>' do
pod 'PulsarKit'
end
```

Then, run the following command:
```shell
$ pod install
```

## Documentation

The `CollectionSource` is the main class that manages the state of the `UICollectionView`. All that is required is to initialize a *source* with an instance of `UICollectionView`.

```swift
import PulsarKit

let source = CollectionSource(container: collectionView)
```

## Author

Massimo Oliviero, massimo.oliviero@gmail.com

## License

PulsarKit is available under the MIT license. See the [See LICENSE](https://github.com/maxoly/PulsarKit/blob/master/LICENSE) file for more info.
