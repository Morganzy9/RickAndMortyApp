//
//  CharactesListView.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 10/31/23.
//

import UIKit

protocol RMCharacterListViewDelegate: AnyObject {
    func rmCharacterListView(_ characterListView: RMCharacteListView, didSelectCharacter character: RMCharacter)
}

// View handle showing list of Characters, loader
final class RMCharacteListView: UIView {
    
    //  MARK: - Public
    
    public weak var delegate: RMCharacterListViewDelegate?
    
    //  MARK: - Private Constants
    
    private let viewModel = RMCharactersListViewViewModel()
    
    //  MARK: - UI Elements
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    private let charactersCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 10, right: 10)
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.isHidden = true
        collectionView.alpha = 0
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        collectionView.register(RMCharacterCollectionViewCell.self, forCellWithReuseIdentifier: Constants.CellID.charactersCollectionViewCell)
        return collectionView
    }()
    
    //  MARK: - Init
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setView() {
        setNavigation()
        setDelegates()
        addSubViews()
        setConstrains()
    }
}

extension RMCharacteListView {
    
    //  MARK: - Private Functions
    
    private func setNavigation() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        spinner.startAnimating()
        viewModel.fetchCharacters()
    }
    
    private func setDelegates() {
        charactersCollectionView.dataSource = viewModel
        charactersCollectionView.delegate = viewModel
        viewModel.delegate = self
    }
    
    private func addSubViews() {
        addSubViews(charactersCollectionView, spinner)
    }
    
    private func setConstrains() {
        
        NSLayoutConstraint.activate([
        
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            charactersCollectionView.topAnchor.constraint(equalTo: topAnchor),
            charactersCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            charactersCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            charactersCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
        
        ])
        
    }
}

extension RMCharacteListView: RMCharactersListViewViewModelDelegate {
    
    func didLoadInitialCharacters() {
        spinner.stopAnimating()
        charactersCollectionView.isHidden = false
        charactersCollectionView.reloadData()
        UIView.animate(withDuration: 0.4) {
            self.charactersCollectionView.alpha = 1
        }
    }
    
    func didSelectCharacter(_ character: RMCharacter) {
        delegate?.rmCharacterListView(self, didSelectCharacter: character)
    }
}
