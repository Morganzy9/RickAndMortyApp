//
//  RMCharacterPhotoCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/23/23.
//

import Foundation

final class RMCharacterPhotoCollectionViewCellViewModel {
    
    //  MARK: - Private Constants
    
    private let imageURL: URL?
    
    //  MARK: - Init
    
    init(imageURL: URL?) {
        self.imageURL = imageURL
    }
    
    //  MARK: - Methods
    
    func fetchImage(completion: @escaping (Result<Data,Error>) -> Void) {
        guard let imageURL = imageURL else { return completion(.failure(URLError(.badURL))) }
        RMImageLoader.shared.downloadImage(imageURL, completion: completion)
    }
}

