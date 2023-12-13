//
//  UIAlertController.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 12/8/23.
//

import UIKit

extension UIAlertController {
    
    
    /// Function to add image to Alert
    /// - Parameter imageURL: Accepts THE URL of image and downLoads it
    func addImage(_ imageData: Data) {
        
        let imageAction = UIAlertAction()
        imageAction.isEnabled = false
        imageAction.setValue(UIImage(data: imageData)?.withRenderingMode(.alwaysOriginal), forKey: "image")
        
        self.addAction(imageAction)
    }
    
}
