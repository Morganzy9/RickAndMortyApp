//
//  RMCharacterDetailViewViewModel.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/9/23.
//

import Foundation

final class RMCharacterDetailViewViewModel {
    
    //  MARK: - Private Consts
    
    private let character: RMCharacter
    
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
    
}

