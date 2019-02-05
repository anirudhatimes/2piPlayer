//
//  ViewController.swift
//  2piPlayer
//
//  Created by Anirudha Tolambia on 05/02/19.
//  Copyright © 2019 Anirudha Tolambia. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    private lazy var playerView = VideoPlayerView(frame: view.bounds)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        view.addSubview(playerView)
        playerView.play(url: Constants.URLs.Stream.test)

    }
}
