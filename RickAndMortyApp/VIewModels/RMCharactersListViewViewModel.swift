//
//  CharactersListViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 10/31/23.
//

import UIKit

protocol RMCharactersListViewViewModelDelegate: AnyObject {
    func didLoadInitialCharacters()
    func didLoadMoreCharacters(with newIndexPaths: [IndexPath])
    func didSelectCharacter(_ character: RMCharacter)
}

final class RMCharactersListViewViewModel: NSObject {
    
    weak var delegate: RMCharactersListViewViewModelDelegate?
    
    //  MARK: - Variables
    
    //  MARK: Private
    private var characters: [RMCharacter] = [] {
        didSet {
            for character in characters {
                let viewModel = RMCharacterCollectionViewCellViewModel(
                    characterName: character.name,
                    characterStatus: character.status,
                    characterImageURL: URL(string: character.image))
                
                if !cellViewModel.contains(viewModel) {
                    cellViewModel.append(viewModel)
                }
            }
        }
    }
    
    private var cellViewModel: [RMCharacterCollectionViewCellViewModel] = []
    
    private var apiInfo: RMGetAllCharacterResponse.Info? = nil
    
    private var isLoadingMoreCharacters = false
    
    //  MARK: Public
    
    var shouldShowLoadMoreIndicator: Bool {
        return apiInfo?.next != nil
    }
    
    
    //  MARK: - Functions
    
    func fetchCharacters() {
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharacterResponse.self) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let model):
                let charactersResults = model.results
                strongSelf.apiInfo =  model.info
                strongSelf.characters = charactersResults
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadInitialCharacters()
                }
            case .failure(let failure):
                print(String(describing: failure))
            }
        }
    }
    
    /// Fetch Additional Characters if needed
    func fetchAdditionalCharacters(with url: URL) {
        guard !isLoadingMoreCharacters else { return }
        isLoadingMoreCharacters = true
        guard let request = RMRequest(url: url) else { 
            isLoadingMoreCharacters = false
            return
        }
        
        RMService.shared.execute(request, expecting: RMGetAllCharacterResponse.self) { [weak self] result in
            guard let strongSelf = self else { return }
            switch result {
            case .success(let model):
                let moreResults = model.results
                strongSelf.apiInfo = model.info
                
                let newCount = moreResults.count
                let startingIndex = (strongSelf.characters.count + newCount) - newCount
                let indexPathsToAdd: [IndexPath] = Array(startingIndex ..< (startingIndex + newCount)).compactMap { return IndexPath(row: $0, section: 0)}
                
                strongSelf.characters.append(contentsOf: moreResults)
                DispatchQueue.main.async {
                    strongSelf.delegate?.didLoadMoreCharacters(with: indexPathsToAdd)
                    strongSelf.isLoadingMoreCharacters = false
                }
            case .failure(let failure):
                print(String(describing: failure))
                strongSelf.isLoadingMoreCharacters = false
            }
        }
    }
    
}

//  MARK: - Characters List UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout

extension RMCharactersListViewViewModel: UICollectionViewDataSource, UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return cellViewModel.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let charactersCell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Identifiers.charactersCollectionViewCell, for: indexPath) as? RMCharacterCollectionViewCell else {
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
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        
        guard kind == UICollectionView.elementKindSectionFooter,
              let footer = collectionView.dequeueReusableSupplementaryView(
                ofKind: kind,
                withReuseIdentifier: Constants.Identifiers.footerLoadingCollectionReusableViewID,
                for: indexPath) as? RMFooterLoadingCollectionReusableView else { fatalError("Unsupported") }
        
        footer.startAnimating()
        
        return footer
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForFooterInSection section: Int) -> CGSize {
        guard shouldShowLoadMoreIndicator else { return .zero}
        
        return CGSize(width: collectionView.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let character = characters[indexPath.row]
        delegate?.didSelectCharacter(character)
    }
}

//  MARK: Extension ScrollView

extension RMCharactersListViewViewModel: UIScrollViewDelegate {
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        guard shouldShowLoadMoreIndicator,
              !isLoadingMoreCharacters,
              !cellViewModel.isEmpty,
              let nextStringURL = apiInfo?.next,
              let nextURL = URL(string: nextStringURL) else { return }
        
        Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { [weak self] t in
            let offset = scrollView.contentOffset.y
            let totalContentHeight = scrollView.contentSize.height
            let totalScrollViewFixedHeight = scrollView.frame.size.height
            
            if offset >= (totalContentHeight - totalScrollViewFixedHeight - 120) {
                self?.fetchAdditionalCharacters(with: nextURL)
            }
            t.invalidate()
        }
        
    }
    
}
