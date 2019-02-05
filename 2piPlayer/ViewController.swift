//
//  ViewController.swift
//  2piPlayer
//
//  Created by Anirudha Tolambia on 05/02/19.
//  Copyright © 2019 Anirudha Tolambia. All rights reserved.
//

import UIKit
import SpriteKit
import CoreMotion

class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
//        let scene = VideoScene(frame: view.bounds)
//        view.addSubview(scene)
        
        MotionManager.shared.startMonitoringDeviceMotion()
        
    }


}

