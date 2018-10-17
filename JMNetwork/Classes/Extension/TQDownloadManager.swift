//
//  TQDownloadManager.swift
//  JMNetwork_Example
//
//  Created by Mengxuan Chen on 2018/10/8.
//  Copyright © 2018年 CocoaPods. All rights reserved.
//

import Foundation
import Alamofire

public enum DownloadState {
    case success
    case failture
}

/// 下载进度回调
public typealias DownloadProgressCallback = (_ progress:Any,_ data:Data,_ url:String) -> ()
/// 下载结果回调
public typealias DownloadFinishCallback = (_ result:DownloadState, _ url:String) -> ()

class TQDownloadManager:NSObject {
    
    static let defalut:TQDownloadManager = TQDownloadManager()
    /// 下载进度回调
    public var downloadProgressCallback:DownloadProgressCallback?
    /// 下载结果回调
    public var downloadFinishCallback:DownloadFinishCallback?
    /// 存储下载请求
    fileprivate var taskEntrepot:NSMutableDictionary = NSMutableDictionary()
    
    fileprivate var totalSize = 0
    
    /// 存储对应的路径
    fileprivate var filePathEntrepot:NSMutableDictionary = NSMutableDictionary()

    /// 开始下载
    public func downloadTask(_ url:String, filePath:String) {
        
        let lock = NSLock()
        let operation = BlockOperation {[weak self] in
            // 0.1 获取数据
            // 判断本地是否有文件,如果有文件就开始接着下载
            var dataBytes = 0
            if FileManager.default.fileExists(atPath: filePath) {
//                print(FileManager.default.contents(atPath: filePath)?.count)
                dataBytes = (FileManager.default.contents(atPath: filePath)?.count)!
            }else {
                FileManager.default.createFile(atPath: filePath, contents: nil, attributes: nil)
            }
            // 0.2 获取请求对象
            let request = NSMutableURLRequest(url: URL(string: url)!)
            // 1.创建请求头信息
            let range = "bytes=\(dataBytes)-"
            request.setValue(range, forHTTPHeaderField: "Range")
            // 2.创建任务
            lock.lock()
            let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.current)
            // 3.开始任务，并把任务放到字典中管理
            let  downloadTask = session.dataTask(with: request as URLRequest)
            downloadTask.resume()
            self?.taskEntrepot[url] = downloadTask
            lock.unlock()
            
        }
        let queue = OperationQueue()
        queue.addOperation(operation)
        filePathEntrepot[url] = filePath
    }
    
    
}


extension TQDownloadManager:URLSessionDataDelegate {
    
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive data: Data) {
        // 0.0 下载进度
        let progress:CGFloat = CGFloat(dataTask.countOfBytesReceived)/CGFloat(dataTask.countOfBytesExpectedToReceive)
        
        // 0.1 当前的url
        let url = dataTask.response?.url?.absoluteString ?? ""
        // 1.0 回调结果
        self.downloadProgressCallback?(progress,data,url)
        // 2.0 开启异步线程写入数据
        let urlStr = self.filePathEntrepot[url] as! String
        let urlPath = URL(string: urlStr)!

        DispatchQueue.global().async {
            do {
                let fileHand = try FileHandle(forWritingTo: urlPath)
                fileHand.seekToEndOfFile()
                fileHand.write(data)
            }catch {
                return
            }
        }
        
    }
    func urlSession(_ session: URLSession, task: URLSessionTask, didCompleteWithError error: Error?) {
        // 0.1 当前的url
        let url = task.response?.url?.absoluteString ?? ""
        // 1.0 成功和失败的判断
        if error == nil {
            downloadFinishCallback?(.success,url)
            return
        }
        downloadFinishCallback?(.failture,url)
    }
   
    func urlSession(_ session: URLSession, dataTask: URLSessionDataTask, didReceive response: URLResponse, completionHandler: @escaping (URLSession.ResponseDisposition) -> Void) {
        completionHandler(.allow)
    }
}

/// 任务的操作管理
extension TQDownloadManager {
    /// 暂停任务
    func pauseTask(_ url:String) {
        let downloadTask = taskEntrepot[url] as! URLSessionTask
        downloadTask.suspend()
    }
    /// 取消任务
    func cancelTask(_ url:String) {
        let downloadTask = taskEntrepot[url] as! URLSessionTask
        downloadTask.cancel()
        // 删除字典中保存的任务
        taskEntrepot.removeObject(forKey: url)
    }
    /// 恢复任务
    func resumeTask(_ url:String) {
        let downloadTask = taskEntrepot[url] as! URLSessionTask
        downloadTask.resume()
    }
}


