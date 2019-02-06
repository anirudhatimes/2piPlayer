//
//  SeekThumbModel.swift
//  2piPlayer
//
//  Created by Anirudha Tolambia on 05/02/19.
//  Copyright © 2019 Anirudha Tolambia. All rights reserved.
//

import UIKit

struct SeekThumbUtil {
    
    let seekThumbModel: SeekThumbnailModel
    let seekImage = UIImage(named: "TestSeekThumb")
    
    func seekImageAndPreferredSeekTime(forTime time: Float) -> (UIImage?, Float) {
        guard let image = seekImage else {
            return (nil, time)
        }
        let imageFrameSize = CGSize(width: seekThumbModel.width, height: seekThumbModel.height)
        let framesPerRow = Int(image.size.width/imageFrameSize.width)
        let frameNumberValue = time/Float(seekThumbModel.frameInterval)
        let roundRule = FloatingPointRoundingRule.toNearestOrAwayFromZero
        let frameNumber = Int(frameNumberValue.rounded(roundRule))
        
        let preferredSeekTime = Float(frameNumber * seekThumbModel.frameInterval)
        
        let xIndex = frameNumber % framesPerRow - 1
        let yIndex = frameNumber/framesPerRow
        
        let originX = CGFloat(xIndex) * imageFrameSize.width
        let originY = CGFloat(yIndex) * imageFrameSize.height
        let cropRect = CGRect(x: originX, y: originY, width: imageFrameSize.width, height: imageFrameSize.height)
        return (image.cropped(in: cropRect), preferredSeekTime)
    }
    
}

struct SeekThumbnailModel {
    let totalFrames: Int = 138
    let frameInterval: Int = 10
    let width: Int = 136
    let height: Int = 77
    let row: Int = 1
    let column: Int = 138
}

