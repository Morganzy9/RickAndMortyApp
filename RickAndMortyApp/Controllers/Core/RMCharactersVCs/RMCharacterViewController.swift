//
//  RMCharacterViewControllerViewController.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 10/26/23.
//

import UIKit

/// Controller to show and search Characters
final class RMCharacterViewController: UIViewController {
    
    private let characterListView = RMCharacteListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    private func setViews() {
        setController()
        setDelegates()
        addSubViews()
        setConstrains()
    }

}

extension RMCharacterViewController {
    
    private func setController() {
        title = "Characters"
        view.backgroundColor = .systemBackground
    }
    
    private func setDelegates() {
        characterListView.delegate = self
    }
    
    private func addSubViews() {
        view.addSubview(characterListView)
    }
    
    private func setConstrains() {
        NSLayoutConstraint.activate([
        
            characterListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            characterListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            characterListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            characterListView.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor)
        ])
    }
    
}

//  MARK: - Extension RMCharacterListViewDelegate

extension RMCharacterViewController: RMCharacterListViewDelegate {
    
    func rmCharacterListView(_ characterListView: RMCharacteListView, didSelectCharacter character: RMCharacter) {
        let viewModel = RMCharacterDetailViewViewModel(character: character)
        let detailVC = RMCharacterDetailViewController(viewModel: viewModel)
        detailVC.navigationItem.largeTitleDisplayMode = .never
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
}
