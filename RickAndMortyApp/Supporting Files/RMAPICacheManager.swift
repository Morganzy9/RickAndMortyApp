//
//  RMAPICacheManager.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 12/4/23.
//

import Foundation

/// Manages in memory session scoped API  cashes
final class RMAPICacheManager {
    
    private var cacheDictionary: [RMEndpoint: NSCache<NSString, NSData>] = [:]
    private var cashe = NSCache<NSString, NSData>()
    
    init() {
        setupCache()
    }
}

extension RMAPICacheManager {
    
    //  MARK: - Public Methods
    
    func cacheResponse(for endPoint: RMEndpoint, url: URL?) -> Data? {
        guard let targetCache = cacheDictionary[endPoint], let url = url else { return nil }
        let key = url.absoluteString as NSString
        
        return targetCache.object(forKey: key) as? Data
    }
    
    func setCache(for endPoint: RMEndpoint, data: Data ,url: URL?) {
        guard let targetCache = cacheDictionary[endPoint], let url = url else { return }
        let key = url.absoluteString as NSString
        
        targetCache.setObject(data as NSData, forKey: key)
    }
    
    //  MARK: - Private Methods
    
    private func setupCache() {
        RMEndpoint.allCases.forEach { endPoint in
            cacheDictionary[endPoint] = NSCache<NSString, NSData>()
        }
    }
    
}
