//
//  MotionSeekVC.swift
//  2piPlayer
//
//  Created by Anirudha Tolambia on 06/02/19.
//  Copyright © 2019 Anirudha Tolambia. All rights reserved.
//

import UIKit
import AVKit
import CoreMotion

class MotionSeekVC: AVPlayerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.showsPlaybackControls = false
        
        let longPress = UILongPressGestureRecognizer(target: self, action: #selector(self.viewLongPressed(_:)))
        view.addGestureRecognizer(longPress)
    }
    
    @objc private func viewLongPressed(_ gesture: UILongPressGestureRecognizer) {
        switch gesture.state {
        case .began:
            MotionManager.shared.startMonitoringDeviceMotion()
            if let motion = MotionManager.shared.currentMotionData {
                analyze(motion: motion)
            }
            
        case .ended:
            MotionManager.shared.stopMonitoringDeviceMotion()
        default:
            break
        }
    }
    
    private func analyze(motion: CMDeviceMotion) {
        let attitude = motion.attitude
    }
}
