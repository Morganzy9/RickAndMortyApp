//
//  RMCharacterInfoCollectionViewCellViewModel.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 11/23/23.
//

import UIKit

final class RMCharacterInfoCollectionViewCellViewModel {
    
    //  MARK: ENUM Type
    
    enum `Type`: String {
        case status
        case gender
        case type
        case species
        case origin
        case created
        case location
        case episodeCount
        
        var tintColor: UIColor {
            switch self {
                
            case .status:
                return .systemPurple
            case .gender:
                return .systemRed
            case .type:
                return .systemMint
            case .species:
                return .systemPink
            case .origin:
                return .systemTeal
            case .created:
                return .systemOrange
            case .location:
                return .systemIndigo
            case .episodeCount:
                return .systemGreen
            }
        }
        
        var iconImage: UIImage? {
            switch self {
                
            case .status:
                return UIImage(systemName: "globe.americas")
            case .gender:
                return UIImage(systemName: "globe.americas")
            case .type:
                return UIImage(systemName: "globe.americas")
            case .species:
                return UIImage(systemName: "globe.americas")
            case .origin:
                return UIImage(systemName: "globe.americas")
            case .created:
                return UIImage(systemName: "globe.americas")
            case .location:
                return UIImage(systemName: "globe.americas")
            case .episodeCount:
                return UIImage(systemName: "globe.americas")
            }
        }
        
        var displayTitle: String {
            switch self {
            case .status,
                 .gender,
                 .type,
                 .species,
                 .origin,
                 .created,
                 .location,
                 .episodeCount:
                return rawValue.uppercased()
            }
        }
    }
    
    //  MARK: - Variables And Constants
    
    private let type: `Type`
    private let value: String
    
    var title: String {
        type.displayTitle
    }
    
    var displayValue: String {
        if value.isEmpty { return "None"}
        
        if let date = Self.dataFormatter.date(from: value),
            type == .created {
            return Self.shortDateFormatter.string(from: date)
        }
        return value
    }
    
    var isconImage: UIImage? {
        return type.iconImage
    }
    
    var tintColor: UIColor {
        return type.tintColor
    }
    
    static let dataFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        formatter.timeZone = .current
        return formatter
    }()
    
    static let shortDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateStyle = .medium
        formatter.timeStyle = .short
        return formatter
    }()
    
    //  MARK: - init
    
    init(type: `Type`,value: String) {
        self.value = value
        self.type = type
    }
    
}
