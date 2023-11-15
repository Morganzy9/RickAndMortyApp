//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/4/23.
//

import UIKit

final class RMCharacterCollectionViewCellViewModel: Hashable, Equatable {
    
    private let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageURL: URL?
    
    
    //  MARK: - Init
    
    init(characterName: String, characterStatus: RMCharacterStatus, characterImageURL: URL?) {
        self.characterName = characterName
        self.characterImageURL = characterImageURL
        self.characterStatus = characterStatus
    }
    
    var getCharacterNameString: String {
        return characterName
    }
    
    var getCharacterStatusString: String {
        return "Status: \(characterStatus.status)"
    }
    
    var getCharacterStatus: RMCharacterStatus {
        return characterStatus
    }
    
    func fetchImage(completion: @escaping (Result<Data, Error>) -> Void) {
        guard let characterUrl = characterImageURL else {
            completion(.failure(URLError(.badURL)))
            return
        }
        
        RMImageLoader.shared.downloadImage(characterUrl, completion: completion)
    }
    
    //  MARK: - Hash
    
    static func == (lhs: RMCharacterCollectionViewCellViewModel, rhs: RMCharacterCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(characterName)
        hasher.combine(characterStatus)
        hasher.combine(characterImageURL)
    }
    
}
