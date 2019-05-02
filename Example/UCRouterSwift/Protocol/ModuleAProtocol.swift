//
//  ModuleAProtocol.swift
//  UCRouterSwift_Example
//
//  Created by Link on 2019/5/2.
//  Copyright © 2019 CocoaPods. All rights reserved.
//

import UCRouterSwift

protocol ModuleAProtocol: UCRoutable {
    
    /// 这里只有本地跨模块调用才需要声明在这里,如果只是url router的话直接注册就可以,不需要这么写,另外参数和返回值必须是基础类型!
    func getModuleAVC() -> UIViewController
}

