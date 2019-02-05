//
//  MotionManager.swift
//  2piPlayer
//
//  Created by Anirudha Tolambia on 05/02/19.
//  Copyright © 2019 Anirudha Tolambia. All rights reserved.
//

import CoreMotion

class MotionManager {
    
    
    static let shared = MotionManager()
    private init() { }
    
    private let manager = CMMotionManager()
    
    var isAvailable: Bool {
        return manager.isDeviceMotionAvailable
    }
    
    var currentMotionData: CMDeviceMotion? {
        return manager.deviceMotion
    }
    
    func startMonitoringDeviceMotion() {
        manager.deviceMotionUpdateInterval = 1.0 / 60.0
        
//        manager.startDeviceMotionUpdates()
        let referenceFrame = CMAttitudeReferenceFrame.xArbitraryZVertical
        manager.startDeviceMotionUpdates(using: referenceFrame)
        
//        let queue = OperationQueue.main
//        manager.startDeviceMotionUpdates(to: queue) { [weak self] (motion, error) in
//            if let motion = motion {
//                self?.analyze(motion: motion)
//            }
//        }
        
        
    }
    
    func stopMonitoringDeviceMotion() {
        manager.stopDeviceMotionUpdates()
    }
    
    private func analyze(motion: CMDeviceMotion) {
        
        let attitude = motion.attitude
        let roll = attitude.roll.toDegree
        let pitch = attitude.pitch.toDegree
        let yaw = attitude.yaw.toDegree
        print("Roll: \(roll) Pitch: \(pitch) Yaw: \(yaw)")
        print("Gravity: \(motion.gravity)")
    }
}

typealias Degree = Double
typealias Radian = Double

extension Double {
    var toDegree: Degree {
        return 180.0 / Double.pi * self
    }
}

extension Double {
    var toRadians: Radian {
        return self * Double.pi / 180.0
    }
}
