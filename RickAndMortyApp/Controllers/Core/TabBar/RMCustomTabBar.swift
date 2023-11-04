//
//  RMCustomTabBar.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/4/23.
//

import UIKit

class RMCustomTabBar: UITabBar {
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setSubViews()
    }
    
    private func setSubViews() {
        let maskLayer = CAShapeLayer()
        let cornerRadius: CGFloat = frame.height / 2
        let maskPath = UIBezierPath(roundedRect: bounds, byRoundingCorners: [.topLeft, .topRight], cornerRadii: CGSize(width: cornerRadius, height: cornerRadius))
        
        maskLayer.path = maskPath.cgPath
        layer.mask = maskLayer
    }
    
}
