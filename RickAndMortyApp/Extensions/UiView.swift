//
//  UiView.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 10/31/23.
//

import UIKit

extension UIView {
    
    func addSubViews(_ views: UIView...) {
        views.forEach({ addSubview($0) })
    }
    
}
