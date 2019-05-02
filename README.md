# UCRouterSwift

[![CI Status](https://img.shields.io/travis/Link913/UCRouterSwift.svg?style=flat)](https://travis-ci.org/Link913/UCRouterSwift)
[![Version](https://img.shields.io/cocoapods/v/UCRouterSwift.svg?style=flat)](https://cocoapods.org/pods/UCRouterSwift)
[![License](https://img.shields.io/cocoapods/l/UCRouterSwift.svg?style=flat)](https://cocoapods.org/pods/UCRouterSwift)
[![Platform](https://img.shields.io/cocoapods/p/UCRouterSwift.svg?style=flat)](https://cocoapods.org/pods/UCRouterSwift)

## Example

To run the example project, clone the repo, and run `pod install` from the Example directory first.

## Requirements

## Installation

UCRouterSwift is available through [CocoaPods](https://cocoapods.org). To install
it, simply add the following line to your Podfile:

```ruby
pod 'UCRouterSwift'
```

## How to use

参考`Example`

- 1.设置导航协议, URL过滤协议在主工程中的代理

		UCRouter.default.setNavgationAndFilter(navgation: NavgationDelegate(), filter: FilterDelegate())
		
- 2.抽出一个可以共同依赖的协议层,这些协议需要继承`UCRoutable`, 在`register`函数中可以对url进行注册,另外如果我们想本地对外界提供一些支持不要通过url的方式,这里可以在各自的协议声明一些函数,参数和返回值都必须是基本类型,防止耦合.可以参考下`ModuleAProtocol`和`ModuleA`两个文件.

这里举一些url注册的例子:

    UCRouter.default.registUrl("oral/test") { (routerInfo) -> UIViewController? in
        return VC2()
    }
	 UCRouter.default.registUrl("oral") { (routerInfo) -> UIViewController? in
        return VC2()
    }
	 UCRouter.default.registUrl("web") { (routerInfo) -> UIViewController? in
        guard let url = routerInfo.urlQuery?["url"] else {return nil}
        let webView = WKWebView(frame: UIScreen.main.bounds)
        let vc = UIViewController()
        vc.view.addSubview(webView)
        webView.load(URLRequest(url: URL(string: url)!))
        
        return vc
    }
    
调用的例子:

    func openWeb(_ sender: Any) {
        UCRouter.default.routeUrlStr("demo://web/?url=https://www.baidu.com", navgationType: .push(animated: true), params: ["abc": "111"])
    }
    func normalJump(_ sender: Any) {
        UCRouter.default.routeUrlStr("demo://oral/test?haha=111", navgationType: .push(animated: true), params: ["abc": "111"])
    }

协议层是可以大家一起去依赖的,他并不会耦合什么东西,真正实现这些协议的其实还是在各自的模块中.
		
- 3.由于Swift自注册没有什么好的方案,这里需要手动对实现协议的各个`Module`进行注册
		
		UCRouter.default.registProtoclAndModule(UCRouterKey<ModuleAProtocol>(), ModuleA.self)

## Author

Link913, fanyang_32012@outlook.com

## License

UCRouterSwift is available under the MIT license. See the LICENSE file for more info.
