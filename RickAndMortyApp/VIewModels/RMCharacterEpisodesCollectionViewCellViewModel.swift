//
//  RMCharacterEpisodesCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/23/23.
//

import Foundation

protocol RMEpisodeDataRender {
    var name: String { get }
    var air_date: String { get }
    var episode: String { get }
}

final class RMCharacterEpisodesCollectionViewCellViewModel: Hashable, Equatable {
    
    //  MARK: - Varibales and COnstants
    
    var episodeDatURL: URL?
    private var isFetching = false
    private var dataBlock: ((RMEpisodeDataRender) -> Void)?
    private var episode: RMEpisode? {
        didSet {
            guard let model = episode else { return }
            guard let dataBlock = dataBlock else { return }
            dataBlock(model)
        }
    }
    
    //  MARK: - Init
    
    init(episodeDataURL: URL?) {
        self.episodeDatURL = episodeDataURL
    }
    
    //  MARK: - HASH ans Equatable
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(self.episodeDatURL?.absoluteString ?? "")
    }
    
    static func == (lhs: RMCharacterEpisodesCollectionViewCellViewModel, rhs: RMCharacterEpisodesCollectionViewCellViewModel) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }

    //  MARK: - Methods
    
    func registerForData(_ block: @escaping (RMEpisodeDataRender) -> Void) {
        self.dataBlock = block
    }
    
    func fetchEpisodes() {
        guard !isFetching else { 
            if let model = episode, let dataBlock = dataBlock {
                dataBlock(model)
            }
            return
        }
        guard let url = episodeDatURL, let request = RMRequest(url: url) else { return }
        isFetching = true
        
        RMService.shared.execute(request, expecting: RMEpisode.self) { [weak self ] result in
            switch result {
            case .success(let model):
                DispatchQueue.main.async {
                    self?.episode = model
                }
            case .failure(let failure):
                print("DEBUG CONSOLE: \(failure.localizedDescription)")
            }
        }
        
    }
        
}

