//
//  ViewController.swift
//  UCRouterSwift
//
//  Created by Link913 on 04/29/2019.
//  Copyright (c) 2019 Link913. All rights reserved.
//

import UIKit
import UCRouterSwift

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.

        view.backgroundColor = .white
    }

    @IBAction func normalJump(_ sender: Any) {
        UCRouter.default.routeUrlStr("demo://haha?haha=111", navgationType: .push(animated: true), params: ["abc": "111"])
    }
    @IBAction func urlFilter(_ sender: Any) {
        UCRouter.default.routeUrlStr("demo1://oral/test?haha=111", navgationType: .push(animated: true), params: ["abc": "111"])
    }
    
    @IBAction func nativeOtherModuleInvoke(_ sender: Any) {
        /// 本地跨组件调用
        let module = UCRouter.default.getModuleInstance(UCRouterKey<ModuleAProtocol>())
        guard let vc = module?.getModuleAVC() else { return }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    @IBAction func openWeb(_ sender: Any) {
        UCRouter.default.routeUrlStr("demo://web/?url=https://www.baidu.com", navgationType: .push(animated: true), params: ["abc": "111"])
    }
}
