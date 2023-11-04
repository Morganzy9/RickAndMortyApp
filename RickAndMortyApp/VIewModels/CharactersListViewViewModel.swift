//
//  CharactersListViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 10/31/23.
//

import UIKit

final class CharactersListViewViewModel: NSObject {
    
    func fetchCharacters() {
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharacterResponse.self) { result in
            switch result {
            case .success(let success):
                print("DEBUG CONSOLE: SUCCESS")
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    
}

//  MARK: - Characters List UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension CharactersListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 20
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let charactersCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.CellID.charactersCollectionViewCell, for: indexPath) as? RMCharacterCollectionViewCell else {
            fatalError("Error during dequeue CharacterCell")
        }
        let viewModel = RMCharacterCollectionViewCellViewModel(characterName: "Rick", characterStatus: .alive, characterImageURL: URL(string: "https://rickandmortyapi.com/api/character/avatar/1.jpeg"))
        
        charactersCell.configureCell(with: viewModel)
        
        return charactersCell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (Constants.DeviceSizes.currentWidth - 30) / 2
        return CGSize(width: width, height: width * 1.5)
    }
}
