//
//  Extension_JMNetwork.swift
//  JMNetwork_Example
//
//  Created by lcy on 2018/9/21.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import Foundation
import CTMediator
import Moya
import Alamofire

/// A dictionary of parameters to apply to a 'URLRequest'
public typealias Parameters = Dictionary<String, Any>

/// 请求成功回调
public typealias RequestCallback = (_ result: Any, _ error:AFError) -> ()

/// 请求类型
public enum RequestType {
    case get
    case post
}

/// TargetName
let JMRquest_TargetName = "JMNetwork"
/// 请求数据
let JMRequestDataAction = "request"
/// TargetModuleName
let TargetModuleName = "JMNetwork"


public extension CTMediator {
    
    /// 请求数据
    ///
    /// - Parameters:
    ///   - url: 请求的url
    ///   - parameters: 请求参数
    /// - requestType: Get Or Post
    ///_ successBlock: 成功请求回调
    ///_ failtureBlock:失败请求回调
    public func jm_request(_ url:URLConvertible,
                           parameters:Parameters? = nil,
                           requestType:HTTPMethod,
                           requestCallback:@escaping RequestCallback
                           ) {
        let params = ["url":url,
                      kCTMediatorParamsKeySwiftTargetModuleName: TargetModuleName,
                      "parameters": parameters,
                      "requestType": requestType,
                      "requestCallback": requestCallback
            ] as [AnyHashable : Any]
        self.performTarget(JMRquest_TargetName, action: JMRequestDataAction, params: params, shouldCacheTarget: true)
    }
}
