//
//  RMEpisodeDetailViewController.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/30/23.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {
    
    private let url: URL?

    init(url: URL?) {
        self.url = url
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemBlue
    }

}
