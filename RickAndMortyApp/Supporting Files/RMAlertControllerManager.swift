//
//  RMAlertControllerManager.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 12/8/23.
//

import UIKit

protocol RMAlertControllerManagerProtocol: AnyObject {
    
    func showAlert(title: String, message: String) -> UIAlertController
    func showAlertQuestion(title: String, message: String, completionBlock: @escaping(Bool) -> Void) -> UIAlertController
    
}

class RMAlertControllerManager: RMAlertControllerManagerProtocol {
    
    static let shared = RMAlertControllerManager()
    
    private init() {}
    
    //MARK: - Alert message
    

    
//    func showSelectedCharacterAlert(title: String, message: String, url: String, vc: UIViewController) -> UIAlertController {
//        
//                guard let url = URL(string: url) else { return UIAlertController(title: title, message: message, preferredStyle: .alert) }
//        
//                let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
//        
//                RMImageLoader.shared.downloadImage(url) { result in
//                    switch result {
//                    case .success(let image):
//                        alert.addImage(image)
//                    case .failure(_):
//                        if let defaultImage = UIImage(systemName: "globe"),
//                           let defaultImageData = defaultImage.pngData() {
//                            alert.addImage(defaultImageData)
//                        }
//                    }
//                }
//                return alert
//    }
    
    func showSelectedCharacterAlert(title: String, message: String, url: String, vc: UIViewController) {
        
        guard let url = URL(string: url) else { return /*UIAlertController(title: title, message: message, preferredStyle: .alert)*/ }
        
        let alert = RMAlertChoosenCharacter()
        
        
        
        RMImageLoader.shared.downloadImage(url) { result in
            switch result {
            case .success(let image):
                alert.showAlert(title: title, message: message, image: image, viewController: vc)
            case .failure(_):
                if let defaultImage = UIImage(systemName: "globe"),
                   let defaultImageData = defaultImage.pngData() {
                    alert.showAlert(title: title, message: message, image: defaultImageData, viewController: vc)
                }
            }
        }
    }
    
    func showAlert(title: String, message: String) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let defaultAction = UIAlertAction(title: "OK", style: .default, handler: nil)
        alert.addAction(defaultAction)
        
        return alert
    }
    
    //MARK: - Alert question
    
    func showAlertQuestion(title: String, message: String, completionBlock: @escaping (Bool) -> Void) -> UIAlertController {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "OK", style: .default) { action in
            completionBlock(true)
        }
        let cancelAction = UIAlertAction(title: "Cancel", style: .default) { action in
            completionBlock(false)
        }
        alert.addAction(okAction)
        alert.addAction(cancelAction)
        return alert
        
    }
    
    
}
