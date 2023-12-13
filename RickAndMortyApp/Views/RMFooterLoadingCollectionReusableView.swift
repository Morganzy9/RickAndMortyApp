//
//  RMFooterLoadingCollectionReusableView.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/10/23.
//

import UIKit

final class RMFooterLoadingCollectionReusableView: UICollectionReusableView {
    
    //  MARK: - UI
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    //  MARK: - Init

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .systemBackground
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        addSubViews()
        setConstrains()
    }
}

extension RMFooterLoadingCollectionReusableView {
    
    //  MARK: - Functions

    func startAnimating() {
        spinner.startAnimating()
    }
    
    //  MARK: Private funcstions
    
    private func addSubViews() {
        addSubViews(spinner)
    }

    private func setConstrains() {
        
        NSLayoutConstraint.activate([
        
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
        
        ])
        
    }
    
}
