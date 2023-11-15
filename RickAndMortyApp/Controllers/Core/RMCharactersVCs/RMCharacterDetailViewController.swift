//
//  RMCharacterDetailViewController.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/9/23.
//

import UIKit

final class RMCharacterDetailViewController: UIViewController {

    //  MARK: - Privaate Variables
    
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
    }
    
}

extension RMCharacterDetailViewController {
    
    //  MARK: - Private Funcstions
    
    private func setController() {
        view.backgroundColor = .systemBackground
        title = viewModel.title
    }
    
    private func addSubViews() {
        
    }
    
    private func setConstrains() {
        
    }
    
}
