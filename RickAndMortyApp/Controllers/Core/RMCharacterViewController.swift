//
//  RMCharacterViewControllerViewController.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 10/26/23.
//

import UIKit

/// Controller to show and search Characters
final class RMCharacterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Characters"
        view.backgroundColor = .systemBackground
        
        RMService.shared.execute(.listCharactersRequest, expecting: RMGetAllCharacterResponse.self) { result in
            switch result {
            case .success(let success):
                print(String(describing: success))
            case .failure(let failure):
                print(String(describing: failure))
            }
            
        }
        
    }

}
