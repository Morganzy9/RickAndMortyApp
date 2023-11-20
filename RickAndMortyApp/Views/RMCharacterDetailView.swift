//
//  RMCharacterDetailView.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/9/23.
//

import UIKit

/// View for Single Character
final class RMCharacterDetailView: UIView {
    
    //  MARK: - Private Consts
    
    private let viewModel: RMCharacterDetailViewViewModel
    
    //  MARK: - UI ELements
    
    var detailCharacterCollectionView: UICollectionView?
    
    private let spinner: UIActivityIndicatorView = {
        let spinner = UIActivityIndicatorView()
        spinner.hidesWhenStopped = true
        spinner.translatesAutoresizingMaskIntoConstraints = false
        return spinner
    }()
    
    //  MARK: - Init
    
    
    init(frame: CGRect, viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        super.init(frame: frame)
        setView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsupported")
    }
    
    private func setView() {
        setupCollectionView()
        addSubViews()
        setConstrains()
    }
}

extension RMCharacterDetailView {
    
    //  MARK: - Private Methods
    
    private func setupCollectionView() {
        translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = .systemBackground
        let collectionView = createCollectionView()
        detailCharacterCollectionView = collectionView
    }
    
    private func addSubViews() {
        addSubViews(detailCharacterCollectionView!, spinner)
    }
    
    private func setConstrains() {
        guard let detailCharacterCollectionView = detailCharacterCollectionView else { return }
        
        NSLayoutConstraint.activate([
            
            spinner.heightAnchor.constraint(equalToConstant: 100),
            spinner.widthAnchor.constraint(equalToConstant: 100),
            spinner.centerXAnchor.constraint(equalTo: centerXAnchor),
            spinner.centerYAnchor.constraint(equalTo: centerYAnchor),
            
            detailCharacterCollectionView.topAnchor.constraint(equalTo: topAnchor),
            detailCharacterCollectionView.leadingAnchor.constraint(equalTo: leadingAnchor),
            detailCharacterCollectionView.trailingAnchor.constraint(equalTo: trailingAnchor),
            detailCharacterCollectionView.bottomAnchor.constraint(equalTo: bottomAnchor)
            
        ])
        
    }
    
    private func createCollectionView() -> UICollectionView {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, _ in
            return self.createSection(for: sectionIndex)
        }
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self,
                                forCellWithReuseIdentifier: Constants.Identifiers.detailCharacterCollectionViewCell)
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }
    
    private func createSection(for sectionIndex: Int) -> NSCollectionLayoutSection {
        let sectionType = viewModel.sections
        
        switch sectionType[sectionIndex] {
        case .characterPhoto:
            return viewModel.createPhotoSectionLayOut()
        case .characterInfo:
            return viewModel.createInfoSectionLayOut()
        case .characterEpisodes:
            return viewModel.createEpisodesSectionLayOut()
        }
        
    }
    
}
