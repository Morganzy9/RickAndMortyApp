//
//  RMLocation.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 10/26/23.
//

import Foundation

struct RMLocation: Codable {
    let id: Int
    let name: String
    let type: String
    let dimension: String
    let residents: [String]
    let url: String
    let created: String
}
