//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/9/23.
//

import UIKit

final class RMCharacterDetailViewViewModel {
    
    //  MARK: - Enum SectionType
    
    enum SectionType {
        case characterPhoto(viewModel: RMCharacterPhotoCollectionViewCellViewModel)
        case characterInfo(viewModels: [RMCharacterInfoCollectionViewCellViewModel])
        case characterEpisodes(viewModels: [RMCharacterEpisodesCollectionViewCellViewModel])
    }
    
    //  MARK: - Consts and Variables
    
    private let character: RMCharacter
    
    var sections: [SectionType] = []
    var episodes: [String] { character.episode }
    
    //  MARK: - Init
    
    init(character: RMCharacter) {
        self.character = character
        setSections()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Character Closures
    
    private var requestURL: URL? {
        return URL(string: character.url)
    }
    
    var title: String {
        character.name.uppercased()
    }
    
    //  MARK: - Methods
    
    func createSection(_ section: SectionType) -> NSCollectionLayoutSection {
        switch section {
        case .characterPhoto:
            return createPhotoSectionLayOut()
        case .characterInfo:
            return createInfoSectionLayOut()
        case .characterEpisodes:
            return createEpisodesSectionLayOut()
        }
    }
    
    //  MARK: - Private Methods
    
    private func setSections() {
        sections = [
            .characterPhoto(viewModel: .init(imageURL: URL(string: character.image))),
            .characterInfo(viewModels: [
                .init(type: .status ,value: character.status.rawValue),
                .init(type: .gender ,value: character.gender.rawValue),
                .init(type: .type ,value: character.type),
                .init(type: .species ,value: character.species),
                .init(type: .origin, value: character.origin.name),
                .init(type: .location ,value: character.location.name),
                .init(type: .created ,value: character.created),
                .init(type: .episodeCount ,value: String(describing: character.episode.count))
            ]),
            .characterEpisodes(viewModels: character.episode.compactMap({
                return RMCharacterEpisodesCollectionViewCellViewModel(episodeDataURL: URL(string: $0))
            }))
            
        ]
    }
    
    private func createPhotoSectionLayOut() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        )
        item.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 10, trailing: 0)
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func createInfoSectionLayOut() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(0.5),
            heightDimension: .fractionalHeight(1.0))
        )
        
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 2,
            leading: 2,
            bottom: 2,
            trailing: 2
        )
        
        let group = NSCollectionLayoutGroup.horizontal(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .absolute(150)),
            subitems: [item, item]
        )
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    private func createEpisodesSectionLayOut() -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: .fractionalWidth(1.0),
            heightDimension: .fractionalHeight(1.0))
        )
        item.contentInsets = NSDirectionalEdgeInsets(
            top: 10,
            leading: 10,
            bottom: 30,
            trailing: 10
        )
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(0.8),
                heightDimension: .absolute(150)),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        section.orthogonalScrollingBehavior = .groupPaging
        
        return section
    }
    
}

