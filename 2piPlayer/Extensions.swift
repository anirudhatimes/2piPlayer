//
//  Extensions.swift
//  2piPlayer
//
//  Created by Anirudha Tolambia on 05/02/19.
//  Copyright © 2019 Anirudha Tolambia. All rights reserved.
//

import UIKit

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

extension UIView {
    func fill(in container: UIView, with insets: UIEdgeInsets = .zero) {
        self.translatesAutoresizingMaskIntoConstraints = false
        container.addSubview(self)
        NSLayoutConstraint.activate([
            topAnchor.constraint(equalTo: container.topAnchor, constant: insets.top),
            rightAnchor.constraint(equalTo: container.rightAnchor, constant: -insets.right),
            bottomAnchor.constraint(equalTo: container.bottomAnchor, constant: -insets.bottom),
            leftAnchor.constraint(equalTo: container.leftAnchor, constant: insets.left)
            ])
    }
}
