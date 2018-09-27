//
//  ViewController.swift
//  JMNetwork
//
//  Created by lc4y on 09/21/2018.
//  Copyright (c) 2018 lc4y. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        CTMediator.sharedInstance().jm_request("https://flights.ctrip.com/itinerary/oneway/lxa-ctu?date=2018-10-05&portingToken=e3bf6e6e3f7c4c63a679cb642a81da9b", parameters: nil, requestType: .get, requestCallback: { (responseObject, error) in
            
        })
       

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
