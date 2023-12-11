//
//  RMAlert.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 12/9/23.
//

import UIKit

final class RMAlertChoosenCharacter: UIView {
    
    private let alertTitleLabel: UILabel = {
        let titleLabel = UILabel()
        titleLabel.textAlignment = .center
        return titleLabel
    }()
    
    private let alertMessageLabel: UILabel = {
        let messageLabel = UILabel()
        messageLabel.textAlignment = .center
        messageLabel.numberOfLines = 0
        return messageLabel
    }()
    
    private let alertImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        return imageView
    }()
    
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
    
    private var myRagetView: UIView?
    
    func showAlert(title: String, message: String, image: Data, viewController: UIViewController) {
        guard let targetView = viewController.view else { return }
        
        myRagetView = targetView
        
        alertBackGroundView.frame = targetView.bounds
        targetView.addSubview(alertBackGroundView)
        targetView.addSubview(alertView)
        
        alertView.frame = CGRect(x: 40, y: -300, width: targetView.frame.size.width - 80, height: 400)
        
        alertTitleLabel.frame = CGRect(x: 0, y: 0, width: alertView.frame.width, height: 80)
        alertTitleLabel.text = title
        
        alertMessageLabel.frame = CGRect(x: 0, y: 30, width: alertView.frame.width, height: 120)
        alertMessageLabel.text = message
        
        alertImageView.frame = CGRect(x: 0, y: 120, width: alertView.frame.width, height: 315)
        alertImageView.image = UIImage(data: image)
        
        alertView.addSubview(alertTitleLabel)
        alertView.addSubview(alertMessageLabel)
        alertView.addSubview(alertImageView)
        
        UIView.animate(withDuration: 0.25) {
            self.alertBackGroundView.alpha = 0.6
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.25) {
                    self.alertView.center = targetView.center
                } completion: { done in
                    // Scale the Alert
                    UIView.animate(withDuration: 0.5, animations: {
                        self.alertView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
                    }) { done in
                    // Moving the alert Up
                        guard done else { return }
                        UIView.animate(withDuration: 0.5) {
                            self.alertView.center = CGPoint(x: self.alertView.center.x, y: self.alertView.center.y - 125)
                        } completion: { done in
                            // Scale
                            guard done else { return }
                            UIView.animate(withDuration: 0.5) {
                                self.alertView.transform = CGAffineTransform(scaleX: 2.5, y: 2.5)
                            } completion: { done in
                                // Dismiss
                                guard done else { return }
                                self.dissmissAlert()
                            }
                        }
                    }
                }
            }
        }
    }
    
    func dissmissAlert() {
        guard let targetView = myRagetView else { return }
        
        UIView.animate(withDuration: 0.15) {
            self.alertView.frame = CGRect(x: 40,
                                          y: targetView.frame.size.height,
                                          width: targetView.frame.size.width - 80,
                                          height: 300)
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.15) {
                    self.alertBackGroundView.alpha = 0
                } completion: { done in
                    guard done else { return }
                    self.alertView.removeFromSuperview()
                    self.alertBackGroundView.removeFromSuperview()
                }
            }
        }
    }
    
}
/*
 UIView.animate(withDuration: 1.0, animations: {
 // Set the scale transform to scale up (2x) in both width and height
 self.alertImageView.transform = CGAffineTransform(scaleX: 2.0, y: 2.0)
 }) { (_) in
 // Optionally, you can add a completion block to execute code when the animation finishes
 print("Animation finished")
 }
 */

