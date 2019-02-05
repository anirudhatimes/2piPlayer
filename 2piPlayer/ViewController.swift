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
import AVFoundation
import SceneKit

class ViewController: UIViewController {
    
    private let videoUrl = URL(string: "https://bitmovin-a.akamaihd.net/content/playhouse-vr/m3u8s/105560.m3u8")!
    
    private lazy var videoView = VideoScene(frame: view.bounds)
    private lazy var sphereView = SphereSceneView(frame: view.bounds.insetBy(dx: 50, dy: 50))
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
//        view.addSubview(videoView)
        
        MotionManager.shared.startMonitoringDeviceMotion()
        MotionManager.shared.delegate = self
        
        
        
        sphereView.delegate = self
        view.addSubview(sphereView)
        
//        let color = UIColor.red
//        sphereView.set(contents: color)
        let player = AVPlayer(url: videoUrl)
//        sphereView.set(contents: player)
//        player.play()
        
        let videoScene = SKScene(size: CGSize(width: 2500, height: 2500))
        videoScene.scaleMode = .aspectFit
//
        let videoNode = SKVideoNode(avPlayer: player)
//        let videoNode = SKVideoNode(url: videoUrl)
        videoNode.position = CGPoint(x: videoScene.size.width/2, y: videoScene.size.height/2)
        videoNode.size = videoScene.size
        videoScene.addChild(videoNode)
        sphereView.set(contents: videoScene)
//        videoNode.play()
        player.play()
        
        let panGesture = UIPanGestureRecognizer(target: self, action: #selector(self.viewPanned(_:)))
        sphereView.addGestureRecognizer(panGesture)
    }

    @objc private func viewPanned(_ gesture: UIPanGestureRecognizer) {
        switch gesture.state {
        case .began:
            break
        case .changed:
            
            let translation = gesture.translation(in: gesture.view)
            // roll - x dir swipes
            // pitch - y dir swipes
            
        default:
            break
        }
    }

}

extension ViewController: SCNSceneRendererDelegate {
    func renderer(_ renderer: SCNSceneRenderer, updateAtTime time: TimeInterval) {
        guard let motion = MotionManager.shared.currentMotionData else {
            return
        }
        DispatchQueue.main.async {
            self.sphereView.update(with: motion)
        }
    }
}
