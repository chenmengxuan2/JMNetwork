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
/// TargetModuleName
let TargetModuleName = "JMNetwork"
/// 下载类的请求参数
enum ActionType:String {
    // 请求数据
    case JMRequestData = "request"
    // 添加下载任务
    case JMAddDownloadTask = "addDownloadTask"
    //暂停下载任务
    case JMPauseDownloadTask = "pauseDownloadTask"
    // 恢复下载任务
    case JMResumeDownloadTask = "resumeDownloadTask"
    // 获取下载进度
    case JMGetDownloadProgress = "getDownloadProgress"
    // 结束任务
    case JMCancelDownloadTask = "cancelDownloadProgress"
    // 获取进度回调
    case JMProgressCallback  = "progressCallback"
    // 回调下载结果
    case JMFinishCallback = "finishCallback"
    
}


public extension CTMediator {
    
    ///   请求数据
    ///
    ///   - Parameters:
    ///   - url: 请求的url
    ///   - parameters: 请求参数
    ///   - requestType: Get Or Post
    ///   _ successBlock: 成功请求回调
    ///   _ failtureBlock:失败请求回调
    public func jm_request(_ url:URLConvertible,
                           parameters:Parameters? = nil,
                           requestType:HTTPMethod,
                           requestCallback:@escaping RequestCallback
                           ) {
        let params = ["url":url,
                      "parameters": parameters ?? (Any).self,
                      "requestType": requestType,
                      "requestCallback": requestCallback
            ] as [AnyHashable : Any]
        self.performTarget(JMRquest_TargetName, action: ActionType.JMRequestData.rawValue, params:jm_setupTargetModuleName(params), shouldCacheTarget: true)
    }
    
    ///   添加下载任务
    ///
    ///   - Parameters:
    ///   - url: 下载的url
    ///   - filePath:  传入的下载路径
    public func jm_addDownloadTask(_ url:String, filePath:String){
        let params = ["url":url,
                      "filePath":filePath
                     ] as [AnyHashable:Any]
        self.performTarget(JMRquest_TargetName, action: ActionType.JMAddDownloadTask.rawValue, params: jm_setupTargetModuleName(params), shouldCacheTarget: true)
    }
    
    ///   暂停下载任务
    ///
    ///   - Parameters:
    ///   - url: 下载的url
    public func jm_pauseDownloadTask(_ url:String){
        let params = ["url":url] as [AnyHashable:Any]
        self.performTarget(JMRquest_TargetName, action: ActionType.JMPauseDownloadTask.rawValue, params: jm_setupTargetModuleName(params), shouldCacheTarget: true)
    }
    
    ///   恢复下载任务
    ///
    ///   - Parameters:
    ///   - url: 下载的url
    public func jm_resumeDownloadTask(_ url:String) {
        let params = ["url":url] as [AnyHashable:Any]
        self.performTarget(JMRquest_TargetName, action: ActionType.JMResumeDownloadTask.rawValue, params: jm_setupTargetModuleName(params), shouldCacheTarget: true)
    }
    
    ///   获取下载进度
    ///
    ///   - Parameters:
    ///   - url: 下载的url
    public func jm_getDownloadProgress(_ url:String) -> Any{
        let params = ["url":url] as [AnyHashable:Any]
        return self.performTarget(JMRquest_TargetName, action: ActionType.JMGetDownloadProgress.rawValue, params: jm_setupTargetModuleName(params), shouldCacheTarget: true)
        
    }
    
    ///   结束任务
    ///
    ///   - Parameters:
    ///   - url: 下载的url
    public func jm_cancelDownloadProgress(_ url:String) {
        let params = ["url":url] as [AnyHashable:Any]
        self.performTarget(JMRquest_TargetName, action: ActionType.JMCancelDownloadTask.rawValue, params: jm_setupTargetModuleName(params), shouldCacheTarget: true)
    }
    
    ///   增加swift区别参数
    ///
    ///   - Parameters:
    ///   - params: 传入参数
    public func jm_setupTargetModuleName(_ params:[AnyHashable : Any]) -> [AnyHashable : Any]{
        let params = NSMutableDictionary.init(dictionary: params)
        params[kCTMediatorParamsKeySwiftTargetModuleName] = TargetModuleName
        return params as! [AnyHashable : Any]
    }
    
    public func jm_progressCallback(_ progressCallback:@escaping DownloadProgressCallback) {
        let params = ["progressCallback":progressCallback]
        self.performTarget(JMRquest_TargetName, action: ActionType.JMProgressCallback.rawValue, params: jm_setupTargetModuleName(params), shouldCacheTarget: true)
    }
    public func jm_finishCallback(_ finishCallback:@escaping DownloadFinishCallback) {
        let params = ["finishCallback":finishCallback]
        self.performTarget(JMRquest_TargetName, action: ActionType.JMFinishCallback.rawValue, params: jm_setupTargetModuleName(params), shouldCacheTarget: true)
    }
}
