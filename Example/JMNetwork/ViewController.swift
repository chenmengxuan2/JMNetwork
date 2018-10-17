//
//  ViewController.swift
//  JMNetwork
//
//  Created by lc4y on 09/21/2018.
//  Copyright (c) 2018 lc4y. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    @IBAction func stopTask(_ sender: Any) {
        
//        TQDownloadManager.defalut.pauseTask("http://updates-http.cdn-apple.com/2018/macos/031-33898-20171026-7a797e9e-b8de-11e7-b1fe-c14fbda7e146/javaforosx.dmg")

        CTMediator.sharedInstance().jm_pauseDownloadTask("http://updates-http.cdn-apple.com/2018/macos/031-33898-20171026-7a797e9e-b8de-11e7-b1fe-c14fbda7e146/javaforosx.dmg")
    }
    @IBAction func startTask(_ sender: Any) {
//        TQDownloadManager.defalut.resumeTask("http://updates-http.cdn-apple.com/2018/macos/031-33898-20171026-7a797e9e-b8de-11e7-b1fe-c14fbda7e146/javaforosx.dmg")
//        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
//        let fileNamePath = filePath + "/java0001.dmg"
        CTMediator.sharedInstance().jm_resumeDownloadTask("http://updates-http.cdn-apple.com/2018/macos/031-33898-20171026-7a797e9e-b8de-11e7-b1fe-c14fbda7e146/javaforosx.dmg")
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        CTMediator.sharedInstance().jm_request("https://flights.ctrip.com/itinerary/oneway/lxa-ctu?date=2018-10-05&portingToken=e3bf6e6e3f7c4c63a679cb642a81da9b", parameters: nil, requestType: .get, requestCallback: { (responseObject, error) in
//
//        })
       
        let filePath = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true).first ?? ""
        let fileNamePath = filePath + "/java88888.dmg"
        CTMediator.sharedInstance().jm_addDownloadTask("http://updates-http.cdn-apple.com/2018/macos/031-33898-20171026-7a797e9e-b8de-11e7-b1fe-c14fbda7e146/javaforosx.dmg", filePath: fileNamePath)
        CTMediator.sharedInstance().jm_progressCallback { (result,data,url) in
            print(result,url)
        }
        CTMediator.sharedInstance().jm_finishCallback { (state, url) in
            print(state,url)
        }
//        let qqPath = filePath + "/qq002.dmg"
//        CTMediator.sharedInstance().jm_addDownloadTask("https://sdlc-esd.oracle.com/ESD6/JSCDL/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jre-8u181-macosx-x64.dmg?GroupName=JSC&FilePath=/ESD6/JSCDL/jdk/8u181-b13/96a7b8442fe848ef90c96a2fad6ed6d1/jre-8u181-macosx-x64.dmg&BHost=javadl.sun.com&File=jre-8u181-macosx-x64.dmg&AuthParam=1539744206_880a1e40bc22727325cdc514a62ea001&ext=.dmg", filePath: qqPath)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}


@objcMembers  class MXModel:NSObject {
    var name = "chenmengxuan"
    var age = "19"
}
