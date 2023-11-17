//
//  RMCharacterDetailViewController.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/9/23.
//

import UIKit

final class RMCharacterDetailViewController: UIViewController {

    //  MARK: - Privaate Variables
    
    private let detailView = RMCharacterDetailView()
    private let viewModel: RMCharacterDetailViewViewModel
    
    //  MARK: - Init
    
    init(viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsoported")
    }
    
    //  MARK: - UI LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
 
    private func setViews() {
        setController()
        addSubViews()
        setConstrains()
    }
    
}

extension RMCharacterDetailViewController {
    
    //  MARK: - Private Funcstions
    
    private func setController() {
        view.backgroundColor = .systemBackground
        title = viewModel.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                            target: self, action: #selector(didTapShare))
    }
    
    private func addSubViews() {
        view.addSubview(detailView)
    }
    
    private func setConstrains() {
        
        NSLayoutConstraint.activate([
        
            detailView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            detailView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            detailView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            detailView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        
        ])
        
    }
    
    //  MARK: - Private @objc Functions
    
    @objc private func didTapShare() {
        
    }
    
}
