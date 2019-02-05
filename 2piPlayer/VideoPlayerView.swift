//
//  VideoPlayerView.swift
//  2piPlayer
//
//  Created by Anirudha Tolambia on 05/02/19.
//  Copyright © 2019 Anirudha Tolambia. All rights reserved.
//

import UIKit
import AVKit
import SceneKit
import SpriteKit


class VideoPlayerView: UIView {
    
    private var player: AVPlayer?
    private var videoNode: SKVideoNode?
    
    private lazy var sphereSceneView: SphereSceneView = {
        let s = SphereSceneView(frame: self.bounds)
        s.delegate = self
        return s
    }()
    
    private lazy var videoScene: SKScene = {
        // nice large values
        let s = SKScene(size: CGSize(width: 2500, height: 2500))
        s.scaleMode = .aspectFit
        return s
    }()
    
    var isMotionControlsEnabled = true {
        didSet {
            if (isMotionControlsEnabled) {
                MotionManager.shared.startMonitoringDeviceMotion()
            } else {
                MotionManager.shared.stopMonitoringDeviceMotion()
            }
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        commonInit()
    }
    
    private func commonInit() {
//        sphereSceneView.fill(in: self)
        self.addSubview(sphereSceneView)
        isMotionControlsEnabled = true
    }
    
    func play(url: URL?) {
        guard let url = url else {
            return
        }
        if (player == nil) {
            player = AVPlayer(url: url)
        } else {
            let newItem = AVPlayerItem(url: url)
            player?.replaceCurrentItem(with: newItem)
        }
        if (videoNode == nil) {
            videoNode = SKVideoNode(avPlayer: player!)
            videoNode?.position = CGPoint(x: videoScene.size.width/2, y: videoScene.size.height/2)
            videoNode?.size = videoScene.size
            videoScene.addChild(videoNode!)
            sphereSceneView.set(contents: videoScene)
        }
        
        player?.play()
    }
    
    func set(roll: Float, pitch: Float, yaw: Float) {
        sphereSceneView.set(roll: roll, pitch: pitch, yaw: yaw)
    }
}

extension VideoPlayerView: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard (isMotionControlsEnabled),
            (MotionManager.shared.isAvailable),
            let motion = MotionManager.shared.currentMotionData else {
                return
        }
        DispatchQueue.main.async {
            self.sphereSceneView.update(with: motion)
        }
    }
}
