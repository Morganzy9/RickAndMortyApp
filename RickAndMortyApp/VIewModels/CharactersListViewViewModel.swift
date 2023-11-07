//
//  CharactersListViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 10/31/23.
//

import UIKit

protocol CharactersListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
}

final class CharactersListViewViewModel: NSObject {
    
    weak var delegate: CharactersListViewViewModelDelegate?
    
    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                let viewModel = RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageURL: URL(string: character.image))
                cellViewModel.append(viewModel)
            }
        }
    }
    
    private var cellViewModel: [RMCharacterCollectionViewCellViewModel] = []
    
    func fetchCharacters() {
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharacterResponse.self) { [weak self] result in
            switch result {
            case .success(let model):
                let charactersResults = model.results
                self?.characters = charactersResults
                DispatchQueue.main.async {
                    self?.delegate?.didLoadInitialCharacters()
                }
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    
}

//  MARK: - Characters List UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension CharactersListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let charactersCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellID.charactersCollectionViewCell, for: indexPath) as? RMCharacterCollectionViewCell else {
            fatalError("Error during dequeue CharacterCell")
        }
        
        let viewModel = cellViewModel[indexPath.row]
        
        charactersCell.configureCell(with: viewModel)
        
        return charactersCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (Constants.DeviceSizes.currentWidth - 30) / 2
        return CGSize(width: width, height: width * 1.5)
    }
}
