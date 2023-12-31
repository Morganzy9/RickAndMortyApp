//
//  RMEndpoint.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 10/28/23.
//

import Foundation

/// Represents unique API Endpoint
@frozen enum RMEndpoint: String, CaseIterable, Hashable {
    case character
    case location
    case episode
}
