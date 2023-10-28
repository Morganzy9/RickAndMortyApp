//
//  RMService.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 10/28/23.
//

import UIKit

///  Primary API service to get data
final class RMSeervice {
    
    /// Singleton pattern
    static let shared = RMSeervice()
    
    private init() {}
    
    
    ///   Send API Call
    /// - Parameters:
    ///   - request:  Request instance
    ///   - type: Type of object that returns
    ///   - completion:  Return Data or Error
    public func execute<T: Codable>(_ request: RMRequest, expecting type: T.Type, completion: @escaping (Result<T, Error>) -> Void) {
        
    }
}
