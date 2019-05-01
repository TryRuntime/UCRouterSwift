//
//  NavgationDelegate.swift
//  UCRouterSwift_Example
//
//  Created by Link on 2019/5/2.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UIKit
import UCRouterSwift

class NavgationDelegate: UCNavgationable {
    func pushViewController(_ viewController: UIViewController, animated: Bool) {
        let navVC = UIApplication.shared.keyWindow?.rootViewController as! UINavigationController
        navVC.pushViewController(viewController, animated: animated)
    }
    
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?) {
        UIApplication.shared.keyWindow?.rootViewController?.present(viewControllerToPresent, animated: flag, completion: completion)
    }
}
