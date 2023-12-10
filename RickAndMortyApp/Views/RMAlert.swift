//
//  RMAlert.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 12/9/23.
//

import UIKit

final class RMAlert: UIView {
    
//    private let alertTitleLabel: UILabel = {
//        let titleLabel = UILabel()
//        titleLabel.textAlignment = .center
//        return titleLabel
//    }()
//    
//    private let alertMessageLabel: UILabel = {
//        let messageLabel = UILabel()
//        messageLabel.textAlignment = .left
//        messageLabel.numberOfLines = 0
//        return messageLabel
//    }()
//    
//    private let alertImageView: UIImageView = {
//        let imageView = UIImageView()
//        imageView.contentMode = .scaleAspectFit
//        return imageView
//    }()
//    
    private let alertBackGroundView: UIView = {
        let alertBackGroundView = UIView()
        alertBackGroundView.backgroundColor = UIColor.black
        alertBackGroundView.alpha = 0
        return alertBackGroundView
    }()
    
    private let alertView: UIView = {
        let alertView = UIView()
        alertView.backgroundColor = .systemBackground
        alertView.layer.masksToBounds = true
        alertView.layer.cornerRadius = 12
        return alertView
    }()
    
    func showAlert(title: String, message: String, image: Data, viewController: UIViewController) {
        guard let targetView = viewController.view else { return }

        alertBackGroundView.frame = targetView.bounds
        targetView.addSubview(alertBackGroundView)
        targetView.addSubview(alertView)
        
        alertView.frame = CGRect(x: 40, y: -300, width: targetView.frame.size.width - 80, height: 300)
        
        let titleLabel = UILabel(frame: CGRect(x: 0, y: 0, width: alertView.frame.width, height: 80))
        titleLabel.text = title
        titleLabel.textAlignment = .center
        alertView.addSubview(titleLabel)
        
        let messageLabel = UILabel(frame: CGRect(x: 0, y: 80, width: alertView.frame.width, height: 120))
        messageLabel.text = message
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        alertView.addSubview(messageLabel)
        
        UIView.animate(withDuration: 0.25) {
            self.alertBackGroundView.alpha = 0.6
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.25) {
                    self.alertView.center = targetView.center
                }
            }
        }
    }
    
    func dissmissAlert() {
        // Dismiss alert implementation
    }
    
    private func addImage(imageView: UIImageView) {
        imageView.frame = CGRect(x: 0, y: 0, width: alertView.frame.width, height: 150)
        alertView.addSubview(imageView)
    }
}


