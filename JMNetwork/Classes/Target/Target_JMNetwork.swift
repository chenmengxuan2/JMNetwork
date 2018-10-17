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
    
    ///   添加下载任务
    ///
    ///   - Parameters:
    ///   - url: 下载的url
    ///   - filePath: 下载存储的路径
    @objc func Action_addDownloadTask(_ params: Dictionary<String, Any>){
        let url = params["url"] as! String
        let filePath = params["filePath"] as! String
        TQDownloadManager.defalut.downloadTask(url, filePath:filePath)
    }
    
    ///   暂停下载任务
    ///
    ///   - Parameters:
    ///   - url: 下载的url
    @objc func Action_pauseDownloadTask(_ params: Dictionary<String, Any>){
        let url = params["url"] as! String
        TQDownloadManager.defalut.pauseTask(url)
    }
    
    ///   恢复下载任务
    ///
    ///   - Parameters:
    ///   - url: 下载的url
    @objc func Action_resumeDownloadTask(_ params: Dictionary<String, Any>) {
        let url = params["url"] as! String
        TQDownloadManager.defalut.resumeTask(url)
    }
    
    ///   结束任务
    ///
    ///   - Parameters:
    ///   - url: 下载的url
    @objc func Action_cancelDownloadProgress(_ params: Dictionary<String, Any>) {
        let url = params["url"] as! String
        TQDownloadManager.defalut.cancelTask(url)
    }
    
    @objc func Action_progressCallback(_ params: Dictionary<String, Any>) {
        TQDownloadManager.defalut.downloadProgressCallback = params["progressCallback"] as? DownloadProgressCallback
    }
    
    @objc func Action_finishCallback(_ params: Dictionary<String, Any>) {
        TQDownloadManager.defalut.downloadFinishCallback = params["finishCallback"] as? DownloadFinishCallback
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

        request(url, method: type, parameters: parameters, encoding: URLEncoding.default, headers: nil).responseJSON { (response) in
            requestCallback(response, response.error as! AFError)
        }
        
    } 
    
}


