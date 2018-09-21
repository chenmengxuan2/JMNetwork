//
//  Extension_JMNetwork.swift
//  JMNetwork_Example
//
//  Created by lcy on 2018/9/21.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import Foundation
import CTMediator

/// Error
public enum JMError: Error {
    case invalidURL(url:JMURLConvertible)
}

/// Convenience Properties
extension JMError {
    /// The `URLConvertible` associated with the error.
    public var urlConvertible:JMURLConvertible? {
        switch self {
        case .invalidURL(let url):
            return url
        }
    }
}

///JMURLConvertible
public protocol JMURLConvertible {
    func asURL() throws ->URL
}

extension String:JMURLConvertible {
    /// Returns a URL if `self` represents a valid URL string that conforms to RFC 2396 or throws an `AFError`.
    ///
    /// - throws: An `AFError.invalidURL` if `self` is not a valid URL string.
    ///
    /// - returns: A URL or throws an `AFError`.
    public func asURL() throws -> URL {
        guard let url = URL(string: self) else {
            throw JMError.invalidURL(url: self)
        }
        return url
    }
}
/// A dictionary of parameters to apply to a 'URLRequest'
public typealias Parameters = Dictionary<String, Any>

/// 请求成功回调
public typealias RequestCallback = (_ result: Any, _ error:Error) -> ()

/// 请求类型
public enum RequestType {
    case GET
    case POST
}

/// TargetName
let JMRquest_TargetName = "JMRequest"
/// 请求数据
let JMRequestDataAction = "request"
/// TargetModuleName
let TargetModuleName = "JimiRequest"


public extension CTMediator {
    
    /// 请求数据
    ///
    /// - Parameters:
    ///   - url: 请求的url
    ///   - parameters: 请求参数
    /// - requestType: Get Or Post
    ///_ successBlock: 成功请求回调
    ///_ failtureBlock:失败请求回调
    public func jm_request(_ url:JMURLConvertible,
                           parameters:Parameters?,
                           requestType:RequestType,
                           requestCallback:@escaping RequestCallback,
                           modelType:AnyClass) {
        let params = ["url":url,
                      kCTMediatorParamsKeySwiftTargetModuleName: TargetModuleName,
                      "parameters": parameters,
                      "requestType": requestType,
                      "requestCallback": requestCallback,
                      "modelType": modelType
                      
            ] as [AnyHashable : Any]
        self.performTarget(JMRquest_TargetName, action: JMRequestDataAction, params: params, shouldCacheTarget: true)
    }
}
