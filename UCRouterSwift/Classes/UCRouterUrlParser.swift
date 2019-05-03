//
//  UCRouterUrlParser.swift
//  Pods-UCRouterSwift_Example
//
//  Created by Link on 2019/5/2.
//

import UIKit

class UCRouterUrlParser {

    // 解析路由
    static func parserUrl(_ urlStr: String, params: [String: String]?) -> UCRouterUrlInfo? {
        
        // 先对urlStr解码,再进行一次编码,保证url只编码了一次
        guard let decodeUrlStr = urlStr.removingPercentEncoding?.removingPercentEncoding else {return nil}
        guard var encodeUrlStr = urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) else {return nil}
        
        // 拼接url
        guard var url = URL(string: encodeUrlStr) else {return nil}
        params?.forEach({ (key, value) in
            if url.query == nil {
                encodeUrlStr += ("?" + key + "=" + String(describing: value))
            } else {
                encodeUrlStr += ("&" + key + "=" + String(describing: value))
            }
            guard let tempUrl = URL(string: encodeUrlStr) else {return}
            url = tempUrl
        })
        
        // 获取注册的urlKey
        let routerKey = (url.host ?? "") + (url.path.count > 1 ? url.path : "")

        // 拼接参数
        var decodeParams = queryParameters(url: url)
        params?.forEach({ (key, value) in
            // 这里手动传入的key如果与url的key名字有冲突默认直接覆盖!
            decodeParams[key] = value
        })
        
        guard let registRouterInfo = UCRouter.routerUrlDict[routerKey] else {return nil}
        registRouterInfo.clearUrlParseInfo()
        registRouterInfo.setUrlDecodeInfo(scheme: url.scheme, host: url.host, path: url.path, query: decodeParams, decodeUrlStr: decodeUrlStr, encodeUrlStr: encodeUrlStr)
        return registRouterInfo
    }
    
    static func queryParameters(url: URL) -> [String: String] {
        let components = NSURLComponents(url: url, resolvingAgainstBaseURL: false)
        let queryItems = components?.queryItems ?? []
        return queryItems.reduce([String: String]()) {
            var dict = $0
            dict[$1.name] = $1.value ?? ""
            return dict
        }
    }
}

public class UCRouterUrlInfo {
    public let registUrl: String
    public let closure: (UCRouterUrlInfo) -> UIViewController?
    
    public private(set) var urlScheme: String?
    public private(set) var urlHost: String?
    public private(set) var urlPath: String?
    public private(set) var urlQuery: [String: String]?
    public private(set) var decodeUrlStr: String?
    public private(set) var encodeUrlStr: String?
    
    public init(registUrl: String, closure: @escaping (UCRouterUrlInfo) -> UIViewController?) {
        self.registUrl = registUrl
        self.closure = closure
    }
    
    func clearUrlParseInfo() {
        urlScheme = nil
        urlHost = nil
        urlPath = nil
        urlQuery = nil
        decodeUrlStr = nil
    }
    
    func setUrlDecodeInfo(scheme: String?, host: String?, path: String?, query: [String: String]?, decodeUrlStr: String?, encodeUrlStr: String?) {
        urlScheme = scheme
        urlHost = host
        urlPath = path
        urlQuery = query
        self.decodeUrlStr = decodeUrlStr
        self.encodeUrlStr = encodeUrlStr
    }
}
