//
//  RMCharacterCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/4/23.
//

import UIKit

final class RMCharacterCollectionViewCellViewModel {
    
    let characterName: String
    private let characterStatus: RMCharacterStatus
    private let characterImageURL: URL?
    
    //  MARK: - Init
    
    init(characterName: String, characterStatus: RMCharacterStatus, characterImageURL: URL?) {
        self.characterName = characterName
        self.characterImageURL = characterImageURL
        self.characterStatus = characterStatus
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
        let urlRequest = URLRequest(url: characterUrl)
        
        let task = URLSession.shared.dataTask(with: urlRequest) { data, _, error in
            guard let data = data, error == nil else {
                completion(.failure(error ?? URLError(.badServerResponse)))
                return
            }
            completion(.success(data))
        }
        task.resume()
    }
    
}
