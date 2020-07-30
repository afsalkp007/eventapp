//
//  UIView+Ext.swift
//  EventApp
//
//  Created by Afsal's Macbook Pro on 30/07/2020.
//  Copyright © 2020 Afsal. All rights reserved.
//

import UIKit

enum Edge {
    case left
    case top
    case right
    case bottom
}

extension UIView {
    func pinToSuperViewEdges(_ edges: [Edge] = [.left, .top, .right, .bottom], constant: CGFloat = 0) {
        guard let superView = superview else { return }
        edges.forEach {
            switch $0 {
            case .left:
                leftAnchor.constraint(equalTo: superView.leftAnchor, constant: constant).isActive = true
            case .top:
                topAnchor.constraint(equalTo: superView.topAnchor, constant: constant).isActive = true
            case .right:
                rightAnchor.constraint(equalTo: superView.rightAnchor, constant: -constant).isActive = true
            case .bottom:
                bottomAnchor.constraint(equalTo: superView.bottomAnchor, constant: -constant).isActive = true
            }
        }
    }
}
