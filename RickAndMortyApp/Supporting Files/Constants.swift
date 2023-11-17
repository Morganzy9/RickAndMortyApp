//
//  Constants.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/1/23.
//

import Foundation
import UIKit.UIScreen

struct Constants {
    
    struct Identifiers {
        static let charactersCollectionViewCell = "RMCharacterCollectionViewCell"
        static let footerLoadingCollectionReusableViewID = "RMFooterLoadingCollectionReusableView"
        static let detailCharacterCollectionViewCell = "RMDetailCharacterCollectionViewCell"
    }
    
    struct DeviceSizes {
        static let currentHeight = UIScreen.main.bounds.height
        static let currentWidth = UIScreen.main.bounds.width
    }
    
}

