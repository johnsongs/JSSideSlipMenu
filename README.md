# JSSideSlipMenu

[![CI Status](http://img.shields.io/travis/johnsongs/JSSideSlipMenu.svg?style=flat)](https://travis-ci.org/johnsongs/JSSideSlipMenu)
[![Version](https://img.shields.io/cocoapods/v/JSSideSlipMenu.svg?style=flat)](http://cocoapods.org/pods/JSSideSlipMenu)
[![License](https://img.shields.io/cocoapods/l/JSSideSlipMenu.svg?style=flat)](http://cocoapods.org/pods/JSSideSlipMenu)
[![Platform](https://img.shields.io/cocoapods/p/JSSideSlipMenu.svg?style=flat)](http://cocoapods.org/pods/JSSideSlipMenu)

[![Preview](https://github.com/johnsongs/JSSideSlipMenu/blob/master/preview.gif)](https://github.com/johnsongs/JSSideSlipMenu/blob/master/preview.gif)

JSSideSlipMenu is a simple slide menu.

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Installation

JSSideSlipMenu is available through [CocoaPods](http://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'JSSideSlipMenu'
```

## Usage

```Objective-C
[[JSSideSlipMenu sharedSideSlipMenu] setMenuSideView:[JSMenuView class] withControlNavigation:navigationController];
```
* JSMenuView is custom view
* navigationController is rootController.
----------
Use `- (void)pushViewController:(UIViewController *)viewController` in JSSideSlipMenu.m method to push next ViewController

## Author

johnsongs, johnson_gs@live.cn

## License

JSSideSlipMenu is available under the MIT license. See the LICENSE file for more info.
