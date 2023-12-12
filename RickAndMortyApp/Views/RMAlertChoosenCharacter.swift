//
//  RMAlert.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 12/9/23.
//

import UIKit

final class RMAlertChoosenCharacter: UIView {
    
    private let alertImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFill
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
        alertView.backgroundColor = .black
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
        
        alertView.frame = CGRect(x: 40, y: -300, width: targetView.frame.size.width - 80, height: 350)
        
        alertImageView.frame = CGRect(x: 0, y: 0, width: targetView.frame.size.width - 80, height: 350)
        alertImageView.image = UIImage(data: image)
        
        alertView.addSubview(alertImageView)
        
        UIView.animate(withDuration: 0.25) {
            self.alertBackGroundView.alpha = 0.6
        } completion: { done in
            if done {
                self.selecationAnimation()
            }
        }
    }
    
    private func selecationAnimation() {
        guard let targetView = myRagetView else { return }
        
        UIView.animate(withDuration: 0.25) {
            self.alertView.center = targetView.center
        } completion: { done in
            // Calculate the maximum scale factor to fit within the target view
            let maxScaleFactorX = targetView.bounds.width / self.alertView.bounds.width
            let maxScaleFactorY = targetView.bounds.height / self.alertView.bounds.height
            let maxScaleFactor = min(maxScaleFactorX, maxScaleFactorY)
            
            UIView.animate(withDuration: 0.5, animations: {
                self.alertView.transform = CGAffineTransform(scaleX: maxScaleFactor, y: maxScaleFactor)
            }) { done in
                guard done else { return }
                self.dismissAlert()
            }
        }
    }

    
    private func dismissAlert() {
        guard let targetView = myRagetView else { return }
        
        UIView.animate(withDuration: 0.1) {
            self.alertView.frame = CGRect(x: 40,
                                          y: targetView.frame.size.height,
                                          width: targetView.frame.size.width - 80,
                                          height: 350)
        } completion: { done in
            if done {
                UIView.animate(withDuration: 0.01) {
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

