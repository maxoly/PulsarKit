<p align="center" >
<img src="Assets/pulsarkit-logo.png" width="500px" alt="PulsarKit" title="PulsarKit">
</p>

![Platform](https://img.shields.io/badge/Platform-iOS-blue.svg)
![iOS 10.0+](http://img.shields.io/badge/iOS-10.0%2B-blue.svg)
![Swift 4.2.x](https://img.shields.io/badge/Swift-4.2-orange.svg)
![Version](https://img.shields.io/cocoapods/v/PulsarKit.svg?style=flat)
[![Build Status](https://travis-ci.org/maxoly/PulsarKit.svg)](https://travis-ci.org/maxoly/PulsarKit)
[![LICENSE](http://img.shields.io/badge/License-MIT-lightgrey.svg)](/LICENSE)
[![Twitter](https://img.shields.io/badge/twitter-@maxoly-blue.svg?style=flat)](http://twitter.com/maxoly)

---

# What is PulsarKit?
PulsarKit is a simple and beautiful wrapper around the official UICollectionView API written in pure Swift. PulsarKit is a library that lets you populate and update collection views **simply using *your models***.

This framework is lightly inspire by [Lighter view controllers](http://objc.io/issues/1-view-controllers/lighter-view-controllers/) and UITableViewSource and UICollectionViewSource in [Xamarin Platform](https://developer.xamarin.com/guides/ios/user_interface/tables/part_1_-_table_parts_and_functionality/).

# Contents

- [Introduction](#introduction)
- [Features Highlights](#features-highlights)
- [Requirements](#requirements)
- [Communication](#communication)
- [Installation](#installation)
- [Usage](#usage)
	- [Basic usage](#basic-usage)
	- [Event handling](#event-handling)
	- [Sizing cells](#sizing-cells)
- [Author](#author)
- [License](#license)

## 👋 Introduction

**Never** implement `UICollectionViewDataSource`, `UICollectionViewDelegate` and `UICollectionViewDelegateFlowLayout` again.

PulsarKit is a small, focused library that lets you populate and update UICollectionView views from **your models**. Forget about dequeuing and type casting cells. Forget about converting an IndexPath to a model object. PulsarKit will hand you dequeued views of the correct type along with the right model object for the index path. You can focus on applying your custom data to your custom view.

## 🚀 Features Highlights

- [x] Fluent interface configuration (`.when(Model).use(Cell)`)
- [x] Easy section and row insertion, updation, deletion and moving (`source.add(model: ...)`)
- [x] Easy reordering of collection view cells and sections
- [x] Easy and fine grained row event handling (`.on.didSelect`)
- [x] Ready to use view controllers
- [x] Powerful plugin system

## 🛑 Requirements

PulsarKit 1.1.x is compatible with:

- **Swift 4.2+**
- iOS 10+
- Xcode 10+

## 📣 Communication

* If you **need help with an PulsarKit feature**, open an issue.
* If you'd like to **discuss a feature request**, open an issue.
* If you **found a bug**, open an issue. The more detail the better!
* If you need to **find or understand an API**, check our documentation or Apple's documentation for UICollectionView, on top of which PulsarKit is built.
* If you want to **contribute**, submit a pull request.

## 💽 Installation

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

## 🕹 Usage

In order to use **PulsarKit** it is necessary to follow 5 simply steps:

1. Conform your models to the `Hashable` protocol
2. Conform your cells or models to the `Bindable` protocol
3. Initialize a new instance of `CollectionSource`
4. Register cells classes
5. Populate the source with your models

The `CollectionSource` is the main class that manages the state of the `UICollectionView`. All that is required is to initialize a *source* with an instance of `UICollectionView`. 

### 🐣 Basic usage

#### Example with Bindable cells

```swift
import PulsarKit

// 1. Conform your models to the `Hashable` protocol
struct User: Hashable {
   let id: String
   let name: String
}

// your custom cell class
class UserCollectionViewCell: UICollectionViewCell {
   @IBOutlet weak var nameLabel: UILabel!
}

// 2. Conform your cells to the `Bindable` protocol
extension UserCollectionViewCell: Bindable {
    func bind(to element: User) {
        nameLabel.text = element.name
    }
}

class MyViewController: UIViewController {
   @IBOutlet weak var collectionView: UICollectionView!

   // 3. Initialize a new instance of `CollectionSource`
   lazy var source = CollectionSource(container: collectionView)

   override func viewDidLoad() {
       super.viewDidLoad()
        
       // 4. Register cells classes
       // the code below tells source to show a `UserCollectionViewCell`
       // for every instance of `User` you adds to source.
       source.when(User.self).use(UserCollectionViewCell.self).withCellBinder()

      // fetch users
      fetchUsersFromNetwork()
   }

   func fetchUsersFromNetwork() {
      userProvider.loadAll { [weak self] (users: [User]) in

         // 5. Populate the source with your models
         self?.source.add(models: users)
         self?.source.update()
      }
   }
}
```
#### Example with Bindable models

```swift
import PulsarKit

// 1. Conform your models to the `Hashable` protocol
struct Order: Hashable {
   let id: String
   let number: Int
}

// 2. Conform your models to the `Bindable` protocol
extension Order: Bindable {
   func bind(to element: OrderCollectionViewCell) {
      element.numberLabel.text = "\(number)"
   }
}

// your cell class
class OrderCollectionViewCell: UICollectionViewCell {
   @IBOutlet weak var numberLabel: UILabel!
}

class MyViewController: UIViewController {
   @IBOutlet weak var collectionView: UICollectionView!

   // 3. Initialize a new instance of `CollectionSource`
   lazy var source = CollectionSource(container: collectionView)

   override func viewDidLoad() {
       super.viewDidLoad()
        
       // 4. Register cells classes
       // the code below tells source to show a `OrderCollectionViewCell`
       // for every instance of `Order` you adds to source.
       source.when(Order.self).use(OrderCollectionViewCell.self).withModelBinder()

      // fetch order
      fetchOrders()
   }

   func fetchOrders() {
      orderProvider.loadAll { [weak self] (orders: [Order]) in

         // 5. Populate the source with your models
         self?.source.add(models: orders)
         self?.source.update()
      }
   }
}
```
### 📡 Event Handling

#### Cell selection
```swift
import PulsarKit

class MyViewController: UIViewController {
   @IBOutlet weak var collectionView: UICollectionView!
   lazy var source = CollectionSource(container: collectionView)

   override func viewDidLoad() {
      super.viewDidLoad()
      
      let user1 = User(id: 1, name: "Guest") 
      let descriptor = source.when(User.self).use(UserCollectionViewCell.self).withCellBinder()

      // the callback is called when user did tap on any cell of type `UserCollectionViewCell`
      descriptor.on.didSelect { context in
         print("model: \(context.model)")
         print("indexPath: \(context.indexPath)")
      }

      // the callback is callend when user did tap on a cell `binded` with a specific instance of user
      descriptor.on(model: user1).didSelect { context in
	     print("model: \(context.model)")
         print("indexPath: \(context.indexPath)")
      }

	  // the callback is callend when user did tap on any cell
      source.on.didSelect { _ in
         print("model: \(context.model)")
         print("indexPath: \(context.indexPath)")
      }  

      // fetch users
      fetchUsersFromNetwork()
   }

   // ...
}
```
### 📐 Sizing cells

PulsarKit supports different kind of cell sizing. You can provide your custom sizing implementing `Sizable` protocol. By default PulsarKit uses the `TableSize` layout that uses autolayout to calculate height and the width of collection view as width of the cell.

PulsarKit has 6 ready-to-use sizes:

- `AutolayoutSize`: uses autolayout to evaluate the width and the height of the cell
- `ContainerSize`: uses the collection view bounds as cell size
- `TableSize`: uses autolayout for height and collection view bounds for width
- `SegmentedSize`: divides the collection view bounds size into equal parts
- `FixedSize`: provide a fixed height/width for all cell types (faster if you plan to have all cell sized same)
- `CompositeSize`: a special size that evaluates combinations of two sizes

#### Fixed sizing
```swift
import PulsarKit

class MyViewController: UIViewController {
   // ...
   override func viewDidLoad() {
      super.viewDidLoad()
      
      let descriptor = source.when(User.self).use(UserCollectionViewCell.self).withCellBinder()

      // fixed cell sizing
      let fixed = FixedSize(width: 40, height: 50)
      descriptor.set(sizeable: fixed)
   }
}
```
#### Composite sizing 
```swift
import PulsarKit

class MyViewController: UIViewController {
   // ...
   override func viewDidLoad() {
      super.viewDidLoad()
      
      let descriptor = source.when(User.self).use(UserCollectionViewCell.self).withCellBinder()

      // sizing composition
      let container = ContainerSize() 	// it uses collection view bounds
      let fixed = FixedSize(height: 50) // fixed height size

      // put togher
      let composite = CompositeSize(widthSize: container, heightSize: fixed)  
      descriptor.set(sizeable: composite)
   }
}
```
#### Custom sizing 
```swift
import PulsarKit

class MyCustomSize: Sizable {
	public func size<View: UIView>(for view: View, descriptor: Descriptor, model: AnyHashable, in container: UIScrollView) -> CGSize {
		// your custom logic here
	}
}

class MyViewController: UIViewController {
   // ...
   override func viewDidLoad() {
      super.viewDidLoad()
      
      let descriptor = source.when(User.self).use(UserCollectionViewCell.self).withCellBinder() 
      descriptor.set(sizeable: MyCustomSize())
   }
}
```


## Author

Massimo Oliviero, massimo.oliviero@gmail.com

## License

PulsarKit is available under the MIT license. See the [See LICENSE](https://github.com/maxoly/PulsarKit/blob/master/LICENSE) file for more info.
