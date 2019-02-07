# PulsarKit

![Platform](https://img.shields.io/badge/Platform-iOS-blue.svg)
![iOS 10.0+](http://img.shields.io/badge/iOS-10.0%2B-blue.svg)
![Swift 4.2.x](https://img.shields.io/badge/Swift-4.2-orange.svg)
![Version](https://img.shields.io/cocoapods/v/PulsarKit.svg?style=flat)
[![Build Status](https://travis-ci.org/maxoly/PulsarKit.svg)](https://travis-ci.org/maxoly/PulsarKit)
[![LICENSE](http://img.shields.io/badge/License-MIT-lightgrey.svg)](/LICENSE)
[![Twitter](https://img.shields.io/badge/twitter-@maxoly-blue.svg?style=flat)](http://twitter.com/maxoly)

## Description
PulsarKit is a set of class that provides all the methods required to display a `UITableView` or a `UICollectionView`, including row count, returning a cell view for each row, handling row selection and many other great features.

This framework is inspire by [Lighter view controllers](http://objc.io/issues/1-view-controllers/lighter-view-controllers/) and UITableViewSource and UICollectionViewSource in [Xamarin Platform](https://developer.xamarin.com/guides/ios/user_interface/tables/part_1_-_table_parts_and_functionality/).

## Features Highlights



## Requirements

PulsarKit 1.0.x is compatible with **Swift 4.2+** and the following platforms:

- iOS 10+
- Xcode 10+

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

## Author

Massimo Oliviero, massimo.oliviero@gmail.com

## License

PulsarKit is available under the MIT license. See the LICENSE file for more info.
