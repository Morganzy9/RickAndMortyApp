//
//  RMEpisodeViewController.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 10/26/23.
//

import UIKit

///  Controller to show   Episodes
final class RMEpisodeViewController: UIViewController {

    private let episodeListView = RMEpisodeListView()

    override func viewDidLoad() {
        super.viewDidLoad()
        setViews()
    }
    
    private func setViews() {
        setController()
        setDelegates()
        addSubViews()
        setConstrains()
    }

}

extension RMEpisodeViewController {
    
    private func setController() {
        title = "Episode"
        view.backgroundColor = .systemBackground
    }
    
    private func setDelegates() {
        episodeListView.delegate = self
    }
    
    private func addSubViews() {
        view.addSubview(episodeListView)
    }
    
    private func setConstrains() {
        NSLayoutConstraint.activate([
        
            episodeListView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            episodeListView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            episodeListView.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            episodeListView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

//  MARK: - Extension RMEpisodeListViewDelegate

extension RMEpisodeViewController: RMEpisodeListViewDelegate {
    func rmEpisodeListView(_ characterListView: RMEpisodeListView, didSelectEpisode character: RMEpisode) {
        let detailVC = RMEpisodeDetailViewController(url: URL(string: character.url))
        detailVC.navigationItem.largeTitleDisplayMode = .never
        
        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    
}

