//
//  ModuleA.swift
//  UCRouterSwift_Example
//
//  Created by Link on 2019/5/2.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UCRouterSwift
import WebKit

class ModuleA: ModuleAProtocol {
    func getModuleAVC() -> UIViewController {
        let vc = UIViewController()
        vc.title = "ModuleA"
        vc.view.backgroundColor = .green
        return vc
    }
    
    static func getProtocolInstance() -> UCRoutable {
        return ModuleA()
    }
    
    func register() {
        UCRouter.default.registUrl("haha") { (routerInfo) -> UIViewController? in
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
        
        UCRouter.default.registUrl("oral/test") { (routerInfo) -> UIViewController? in
            return VC2()
        }
    }
}
