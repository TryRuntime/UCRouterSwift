//
//  UCRouter.swift
//  Pods-UCRouterSwift_Example
//
//  Created by Link on 2019/4/29.
//

import UIKit

public protocol UCRoutable {
    static func getProtocolInstance() -> UCRoutable
    func register()
}

public protocol UCNavgationable {
    func pushViewController(_ viewController: UIViewController, animated: Bool)
    func present(_ viewControllerToPresent: UIViewController, animated flag: Bool, completion: (() -> Void)?)
}

public protocol UCRouterFilterable {
    func shouldOpenRouter(routerUrlInfo: UCRouterUrlInfo, jumpViewController: UIViewController, navgationType: UCNavgationType) -> Bool
}

public enum UCNavgationType {
    case push(animated: Bool)
    case present(animated: Bool)
}

public class UCRouterKey<P> {
    
    let protocolName: String
    public init() {
        protocolName = String(describing: P.self)
    }
}

public class UCRouter {
    public static let `default` = UCRouter()
    
    /// 设置导航以及url过滤器代理
    public func setNavgationAndFilter(navgation: UCNavgationable, filter: UCRouterFilterable) {
        self.navgationDelegate = navgation
        self.filterDelegate = filter
    }
    
    /// 注册协议以及实现该协议的组件
    public func registProtoclAndModule<P>(_ protocolName: UCRouterKey<P>, _ module: UCRoutable.Type) {
        print(protocolName.protocolName)
        let protocolNameStr = protocolName.protocolName
        let protocolInstance = module.getProtocolInstance()
        UCRouter.routerProtocolDict[protocolNameStr] = protocolInstance
        protocolInstance.register()
    }
    
    /// 获取实现该协议的对象
    public func getModuleInstance<P>(_ moduleProtocol: UCRouterKey<P>) -> P? {
        let protocolNameStr = moduleProtocol.protocolName
        return UCRouter.routerProtocolDict[protocolNameStr] as? P
    }
    
    /// 注册url
    public func registUrl(_ route: String, closure: @escaping (UCRouterUrlInfo) -> UIViewController?) {
        let routerInfo = UCRouterUrlInfo(registUrl: route, closure: closure)
        UCRouter.routerUrlDict[route] = routerInfo
    }
    
    /// 路由派发
    public func routeUrlStr(_ urlStr: String, navgationType: UCNavgationType, params: [String: String]? = nil) {
        
        guard let routerInfo = UCRouterUrlParser.parserUrl(urlStr, params: params) else {return}
        guard let vc = routerInfo.closure(routerInfo) else {return}
        
        // 对url进行过滤,由外界处理
        guard self.filterDelegate?.shouldOpenRouter(routerUrlInfo: routerInfo, jumpViewController: vc, navgationType: navgationType) ?? true else {return}
        
        switch navgationType {
        case .push(let animated):
            navgationDelegate?.pushViewController(vc, animated: animated)
        case .present(let animated):
            navgationDelegate?.present(vc, animated: animated, completion: nil)
        }
    }
    
    /// 导航行为delegate,需外界主工程传入
    private var navgationDelegate: UCNavgationable?
    /// url拦截delegate,需外界主工程传入
    private var filterDelegate: UCRouterFilterable?
    /// 存储协议以及实现协议的对象
    private static var routerProtocolDict: [String: UCRoutable] = [:]
    /// 存储url注册时的相关信息
    static var routerUrlDict: [String: UCRouterUrlInfo] = [:]
}
