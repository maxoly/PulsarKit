# PulsarKit

[![Build Status](https://travis-ci.org/maxoly/PulsarKit.svg)](https://travis-ci.org/maxoly/PulsarKit)
[![Version](https://img.shields.io/cocoapods/v/PulsarKit.svg?style=flat)](http://cocoapods.org/pods/PulsarKit)
[![License](https://img.shields.io/cocoapods/l/PulsarKit.svg?style=flat)](http://cocoapods.org/pods/PulsarKit)
[![Platform](https://img.shields.io/cocoapods/p/PulsarKit.svg?style=flat)](http://cocoapods.org/pods/PulsarKit)
[![Dependency Status](https://www.versioneye.com/objective-c/pulsarkit/0.2.4/badge.svg)](https://www.versioneye.com/objective-c/pulsarkit/0.2.4)
[![Reference Status](https://www.versioneye.com/objective-c/pulsarkit/reference_badge.svg?style=flat)](https://www.versioneye.com/objective-c/pulsarkit/references)
[![Twitter](https://img.shields.io/badge/twitter-@maxoly-blue.svg?style=flat)](http://twitter.com/maxoly)

PulsarKit is a set of class that provides all the methods required to display a `UITableView` or a `UICollectionView`, including row count, returning a cell view for each row, handling row selection and many other great features.

This framework is inspire by [Lighter view controllers](http://objc.io/issues/1-view-controllers/lighter-view-controllers/) and UITableViewSource and UICollectionViewSource in [Xamarin Platform](https://developer.xamarin.com/guides/ios/user_interface/tables/part_1_-_table_parts_and_functionality/).

## Usage

To run the example project, clone the repo, and run `pod install` from the Example directory first.

In your view controller

```objc
#import <PulsarKit/PulsarKit.h>


@interface MyViewController ()
@property (nonatomic, readwrite, weak) IBOutlet UICollectionView *collectionView;
@property (nonatomic, readwrite, strong) PLKCollectionSource *source;
@end


@implementation MyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    // init
    self.source = [[PLKCollectionSource alloc] initWithCollectionView:self.collectionView];

	// register some cell descriptors
    [self registerCellDescriptor:[PLKModelCellDescriptor descriptorWithCellClass:[MYUserCollectionCell class]
    															   forModelClass:[MYUser class]
	                                                                sizeStrategy:[PLKFixedSize fixedHeight:150.0f]]];
	
	// set data provider
	__weak typeof(self) weakSelf = self;
	[self.source setDataProvider:^(PLKDirection direction) {
		NSArray *users = ... // an array of MYUser instances retrieved from a web server or a database ..
		[weakSelf.sections.addModels:users];
		[weakSelf update];
	}];

	// load data
    [self.source loadData];
}

@end
```

## Requirements

- iOS 8.0+
- Xcode 6.4+

## Installation

PulsarKit is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod "PulsarKit"
```

## Author

Massimo Oliviero, massimo.oliviero@gmail.com

## License

PulsarKit is available under the MIT license. See the LICENSE file for more info.
