//
//  RMCharacterDetailViewController.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/9/23.
//

import UIKit

final class RMCharacterDetailViewController: UIViewController {

    //  MARK: - Privaate Variables
    
    private let detailView: RMCharacterDetailView
    private let viewModel: RMCharacterDetailViewViewModel
    
    //  MARK: - Init
    
    init(viewModel: RMCharacterDetailViewViewModel) {
        self.viewModel = viewModel
        self.detailView = RMCharacterDetailView(frame: .zero, viewModel: viewModel)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("Unsoported")
    }
    
    //  MARK: - UI LifeCycle
    override func viewDidLoad() {
        super.viewDidLoad()
        setView()
    }
 
    private func setView() {
        setController()
        addSubViews()
        setConstrains()
        setDelegates()
    }
    
}

extension RMCharacterDetailViewController: UICollectionViewDataSource ,UICollectionViewDelegate {
    
    //  MARK: - Private Funcstions
    
    private func setController() {
        view.backgroundColor = .systemBackground
        title = viewModel.title
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .action,
                                                            target: self, action: #selector(didTapShare))
    }
    
    private func setDelegates() {
        detailView.detailCharacterCollectionView?.delegate = self
        detailView.detailCharacterCollectionView?.dataSource = self
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
    
    @objc
    private func didTapShare() {
        print("DidTapShare Tapped")
    }
    
    
    //  MARK: - UICollectionView DataSource, Delegate
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return viewModel.sections.count
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let sectionType = viewModel.sections[section]
        switch sectionType {
        case .characterPhoto:
            return 1
        case .characterInfo(viewModels: let viewModel):
            return viewModel.count
        case .characterEpisodes(viewModels: let viewModel):
            return viewModel.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let sections = viewModel.sections[indexPath.section]
        
        switch  sections {
        case .characterPhoto(viewModel: let viewModel):
            guard let characterPhotoCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.characterPhotoCollectionViewCell, for: indexPath) as? RMCharacterPhotoCollectionViewCell else { fatalError("Can not dequeue characterPhotoCollectionViewCell") }
            
            characterPhotoCell.configure(with: viewModel)
            
            return characterPhotoCell
        case .characterInfo(viewModels: let viewModel):
            guard let characterInfoCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.characterInfoCollectionVIewCell, for: indexPath) as? RMCharacterInfoCollectionViewCell else { fatalError("Can not dequeue characterInfoCell") }
            
            characterInfoCell.configure(with: viewModel[indexPath.row])
            
            return characterInfoCell
        case .characterEpisodes(viewModels: let viewModel):
            guard let characterEpisodesCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.characterEpisodesCollectionViewCell, for: indexPath) as? RMCharacterEpisodesCollectionViewCell else { fatalError("Can not dequeue characterEpisodesCell") }
            
            characterEpisodesCell.configure(with: viewModel[indexPath.row])
            
            return characterEpisodesCell
        }
    }
    
}
