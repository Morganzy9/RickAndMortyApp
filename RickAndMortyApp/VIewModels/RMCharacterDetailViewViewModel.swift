//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/9/23.
//

import UIKit

final class RMCharacterDetailViewViewModel {
    
    //  MARK: - Enum SectionType
    
    enum SectionType: CaseIterable {
        case characterPhoto
        case characterInfo
        case characterEpisodes
    }
    
    //  MARK: - Private Consts
    
    private let character: RMCharacter
    
    //  MARK: - Consts
    
    public let sections = SectionType.allCases
    
    //  MARK: - Init
    
    init(character: RMCharacter) {
        self.character = character
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
    
    //  MARK: - Layout Sections
    
    private func createSectionLayout(with itemLayOutDimension: NSCollectionLayoutSize,
                                     itemContentInsects: NSDirectionalEdgeInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 0),
                                     groupDirection: NSCollectionLayoutGroup.Type,
                                     groupLayOutSize: NSCollectionLayoutSize
                                     
    ) -> NSCollectionLayoutSection {
        let item = NSCollectionLayoutItem(layoutSize: NSCollectionLayoutSize(
            widthDimension: itemLayOutDimension.widthDimension,
            heightDimension: itemLayOutDimension.heightDimension)
        )
        item.contentInsets = itemContentInsects
        
        let group = NSCollectionLayoutGroup.vertical(
            layoutSize: NSCollectionLayoutSize(
                widthDimension: .fractionalWidth(1.0),
                heightDimension: .fractionalHeight(0.5)),
            subitems: [item]
        )
        let section = NSCollectionLayoutSection(group: group)
        
        return section
    }
    
    
    
    func createPhotoSectionLayOut() -> NSCollectionLayoutSection {
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
    
    func createInfoSectionLayOut() -> NSCollectionLayoutSection {
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
    
    func createEpisodesSectionLayOut() -> NSCollectionLayoutSection {
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

