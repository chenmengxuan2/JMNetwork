//
//  Target_JMNetwork.swift
//  JMNetwork_Example
//
//  Created by lcy on 2018/9/21.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import UIKit
import Alamofire
import Moya
@objc class Target_JMNetwork: NSObject {
    /// 请求数据
    ///
    /// - Parameter params: 请求数据的参数
    @objc func Action_request(_ params: Dictionary<String, Any>) {
        let urlStr:String = params["url"] as!String
        var parameters:Parameters? = nil
        do {
            try parameters = params["parameters"] as? Parameters
        }
        let type = params["requestType"] as! HTTPMethod
        let requestCallback = params["requestCallback"] as! RequestCallback
        requestData(url: urlStr, parameters: parameters, type: type, requestCallback: requestCallback)
    }
}


extension Target_JMNetwork {
    ///  网络请求
    ///
    /// - Parameter
    /// -  url: 请求地址
    /// -  parameters: 请求参数
    /// -  type: 请求类型
    /// - requestCallback: 回调
    fileprivate func requestData(url:URLConvertible,
                                 parameters:Parameters? = nil,
                                 type:HTTPMethod,
                                 requestCallback:@escaping RequestCallback){

        request(url, method: type, parameters: nil, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            requestCallback(response, response.error as! AFError)
        }
        
    }
    
    
    
}


