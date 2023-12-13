//
//  RMEpisodeDetailViewController.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/30/23.
//

import UIKit

final class RMEpisodeDetailViewController: UIViewController {
    
    private let viewModel: RMEpisodeDetailViewViewModel

    //  MARK: - Init
    
    init(url: URL?) {
        self.viewModel = .init(endPointURL: url)
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    //  MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Episode"
        view.backgroundColor = .systemBlue
    }

}
