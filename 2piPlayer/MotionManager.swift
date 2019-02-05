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
    
    func startMonitoringDeviceMotion() {
        manager.deviceMotionUpdateInterval = 0.5
        manager.startDeviceMotionUpdates()
        
        let queue = OperationQueue.main
        manager.startDeviceMotionUpdates(to: queue) { [weak self] (motion, error) in
            if let motion = motion {
                self?.analyze(motion: motion)
            }
        }
    }
    
    func stopMonitoringDeviceMotion() {
        manager.stopDeviceMotionUpdates()
    }
    
    private func analyze(motion: CMDeviceMotion) {
        // roll - around x
        // pitch - around z
        // yaw - around y
        let attitude = motion.attitude
        let roll = attitude.roll.toDegree
        let pitch = attitude.pitch.toDegree
        let yaw = attitude.yaw.toDegree
        print("Roll: \(roll) Pitch: \(pitch) Yaw: \(yaw)")
    }
    
}
extension Double {
    typealias Degree = Double
    var toDegree: Double {
        return 180.0 / Double.pi * self
    }
}
