//
//  RMCharacterStatus.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 10/28/23.
//

import Foundation

enum RMCharacterStatus: String, Codable {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "unknown"
    
    var status: String {
        switch self {
        case .alive, .dead:
            return rawValue
        case .unknown:
            return "Unknown"
        }
    }
    
}
