//
//  SphereSceneView.swift
//  2piPlayer
//
//  Created by Anirudha Tolambia on 05/02/19.
//  Copyright © 2019 Anirudha Tolambia. All rights reserved.
//

import UIKit
import SceneKit
import CoreMotion

class SphereSceneView: SCNView {
    
    private lazy var rollNode = SCNNode()
    private lazy var pitchNode = SCNNode()
    private lazy var yawNode = SCNNode()
    
    override init(frame: CGRect, options: [String : Any]? = nil) {
        super.init(frame: frame, options: options)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
        self.backgroundColor = .black
        self.scene = SCNScene()
        
        let camera = SCNCamera()
        camera.zFar = 50    // depth
        
        let cameraNode = SCNNode()
        cameraNode.camera = camera
        cameraNode.position = SCNVector3(0, 0, 0)
        cameraNode.eulerAngles = SCNVector3(x: -Float.pi / 2, y: 0, z: 0)   // reverse pov
        
        rollNode.addChildNode(cameraNode)
        pitchNode.addChildNode(rollNode)
        yawNode.addChildNode(pitchNode)
        self.scene?.rootNode.addChildNode(yawNode)
        
        self.pointOfView = cameraNode
        self.isPlaying = true
    }
    
    func update(with motion: CMDeviceMotion) {
        let attitude = motion.attitude
        let orientationFactor: Double = (UIApplication.shared.statusBarOrientation == .landscapeLeft) ? 1 : -1
        let roll = Float(attitude.roll * orientationFactor)
        let pitch = Float(attitude.pitch)
        let yaw = Float(attitude.yaw)
        set(roll: roll, pitch: pitch, yaw: yaw)
    }
    
    func set(roll: Float, pitch: Float, yaw: Float) {
        // https://developer.apple.com/documentation/coremotion/getting_processed_device-motion_data/understanding_reference_frames_and_device_attitude#2875084
        rollNode.eulerAngles.x = roll
        pitchNode.eulerAngles.z = pitch
        yawNode.eulerAngles.y = yaw
    }
    
    func set(contents: Any) {
        let sphereNode = SCNNode(geometry: SCNSphere(radius: 30))
        sphereNode.geometry?.firstMaterial?.diffuse.contents = contents
        sphereNode.geometry?.firstMaterial?.isDoubleSided = true
        
        var transform = SCNMatrix4MakeRotation(Float.pi, 0, 0, 1)
        transform = SCNMatrix4Translate(transform, 1, 1, 1)
        
        sphereNode.pivot = SCNMatrix4MakeRotation(Float.pi / 2, 0, -1, 0)
        sphereNode.geometry?.firstMaterial?.diffuse.contentsTransform = transform
        sphereNode.position = SCNVector3(x: 0, y: 0, z: 0)
        self.scene?.rootNode.addChildNode(sphereNode)
    }
}
