//
//  RMEpisodeDeailViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 12/5/23.
//

import UIKit

final class RMEpisodeDetailViewViewModel {

    private let endPointURL: URL?
    
    init(endPointURL: URL?) {
        self.endPointURL = endPointURL
        fetchEpisodeData()
    }
    
}

extension RMEpisodeDetailViewViewModel {
    
    private func fetchEpisodeData() {
        guard let url = endPointURL, let request = RMRequest(url: url) else { return }
    
        RMService.shared.execute(request, expecting: RMEpisode.self) { result in
            
            switch result {
            case .success(let success):
                print("DEBUG CONSOLE: \(String(describing: success))")
            case .failure(_):
                break
            }
            
        }
    }
    
}
