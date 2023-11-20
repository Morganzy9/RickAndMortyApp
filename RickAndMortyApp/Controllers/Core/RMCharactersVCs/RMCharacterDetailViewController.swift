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
        switch section {
        case 0:
            return 1
        case 1:
            return 6
        case 2:
            return 8
        default:
            return 2 
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.detailCharacterCollectionViewCell , for: indexPath)
        
        if indexPath.section == 0 {
            cell.backgroundColor = .systemMint
        } else if indexPath.section == 1 {
            cell.backgroundColor = .systemCyan
        } else {
            cell.backgroundColor = .systemBrown
        }
        
        return cell
    }
    
}
