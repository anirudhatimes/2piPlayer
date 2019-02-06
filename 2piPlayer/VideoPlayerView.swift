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
    
    private lazy var panGesture: UIPanGestureRecognizer = {
        let p = UIPanGestureRecognizer(target: self, action: #selector(self.viewPanned(_:)))
        self.addGestureRecognizer(p)
        return p
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
    
    var isGestureControlsEnabled = false {
        didSet {
            panGesture.isEnabled = isGestureControlsEnabled
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
    
    deinit {
        MotionManager.shared.stopMonitoringDeviceMotion()
    }
    
    private func commonInit() {
//        sphereSceneView.fill(in: self)
        self.addSubview(sphereSceneView)
        isMotionControlsEnabled = true
        isGestureControlsEnabled = true
        
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.viewTapped))
        self.addGestureRecognizer(tap)
    }
    var pauseFlag = false
    @objc private func viewTapped() {
        if (pauseFlag) {
            player?.play()
        } else {
            player?.pause()
        }
        pauseFlag.toggle()
    }
    
    @objc private func viewPanned(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            break
        case .changed:
            
            // Roll - along x axis
            // Pitch - along y axis
            // Yaw -
            
            let translation = gesture.translation(in: gesture.view)
            set(roll: translation.x/self.bounds.width, pitch: translation.y/self.bounds.height, yaw: 0)
            
            break
        default:
            break
        }
    }
}

extension VideoPlayerView {
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
    
    func set(roll: CGFloat, pitch: CGFloat, yaw: CGFloat) {
        set(roll: Float(roll), pitch: Float(pitch), yaw: Float(yaw))
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
