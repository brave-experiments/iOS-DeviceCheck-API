//
//  ViewController.swift
//  DeviceCheckAPI
//
//  Created by Vineet Choudhary on 17/11/17.
//  Copyright © 2017 Developer Insider. All rights reserved.
//

import UIKit
import DeviceCheck

class ViewController: UIViewController {
    @IBOutlet weak var output: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        generateToken()
    }
    
    @IBAction func copyText(_ sender: Any) {
        UIPasteboard.general.string = self.output.text
    }
    
    @IBAction func refreshToken(_ sender: Any) {
        generateToken()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func generateToken(){
        let currentDevice = DCDevice.current
        if currentDevice.isSupported {
            currentDevice.generateToken(completionHandler: { (data, error) in
                DispatchQueue.main.async {
                    if let tokenData = data {
                        self.output.text = tokenData.base64EncodedString()
                    } else {
                        self.output.text = error?.localizedDescription ?? "Something Wrong!!!"
                    }
                }
            })
        } else {
            self.output.text = "Device not supported."
        }
    }

}

