//
//  FilterDelegate.swift
//  UCRouterSwift_Example
//
//  Created by Link on 2019/5/2.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import UCRouterSwift

class FilterDelegate: UCRouterFilterable {
    func shouldOpenRouter(routerUrlInfo: UCRouterUrlInfo, jumpViewController: UIViewController, navgationType: UCNavgationType) -> Bool {
        
        // 举个例子过滤scheme
        guard let scheme = routerUrlInfo.urlScheme, scheme == "demo" else {return false}
        
        return true
    }
}
