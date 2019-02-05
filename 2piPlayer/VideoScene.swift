//
//  VideoScene.swift
//  2piPlayer
//
//  Created by Anirudha Tolambia on 05/02/19.
//  Copyright © 2019 Anirudha Tolambia. All rights reserved.
//

import SpriteKit

class VideoScene: SKView {

    override init(frame: CGRect) {
        super.init(frame: frame)
        commonInit()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
        commonInit()
    }
    
    private func commonInit() {
        let scene = SKScene(size: self.bounds.size)
        self.presentScene(scene)
        let url = URL(string: "https://bitmovin-a.akamaihd.net/content/playhouse-vr/m3u8s/105560.m3u8")!
        let vidScene = SKVideoNode(url: url)
        vidScene.position = CGPoint.zero
        vidScene.anchorPoint = CGPoint.zero
        vidScene.size = self.bounds.size
        self.scene?.addChild(vidScene)
        vidScene.play()
        
        
        
        
    }
}
