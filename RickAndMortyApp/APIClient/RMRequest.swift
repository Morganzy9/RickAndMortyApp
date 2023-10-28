//
//  RMRequest.swift
//  RickAndMortyApp
//
//  Created by Ислам Пулатов on 10/28/23.
//

import Foundation

///  Object that represents single API Call
final class RMRequest {
    
    /// API Constants
    private struct Constants {
        static let baseUrl = "https://rickandmortyapi.com/api"
    }
    
    /// Desired EndPoint
    private let endPoint: RMEndpoint
    
    /// Path Components for API, if needed
    private let pathComponents: Set<String>
    
    /// Query arguments for API, if any
    private let queryParameters: [URLQueryItem]
    
    /// Constructed url for the api request in string format
    private var urlString: String {
        var string = Constants.baseUrl
        
        string += "/"
        string += endPoint.rawValue
        
        if !pathComponents.isEmpty {
            pathComponents.forEach({ string += "/\($0)" })
        }
        
        if !queryParameters.isEmpty {
            
            string += "?"
            
            let argumentString = queryParameters.compactMap({
                guard let value = $0.value else { return nil }
                return "\($0.name)=\(value)"
            }).joined(separator: "&")
            
            string += argumentString
        }
        
        return string
    }
    
    /// Computed & Constructed Url
    public var url: URL? {
        return URL(string: urlString)
    }
    
    
    /// HTTP Method
    public let httpMethod = "GET"
    
    //  MARK: Public Init
    
    
    /// Construct Request
    /// - Parameters:
    ///   - endPoint: Target EndPoint
    ///   - pathComponents: Collection of path Components
    ///   - queryParameters: Collection of query parameters
    public init(endPoint: RMEndpoint, pathComponents: Set<String> = [], queryParameters: [URLQueryItem] = []) {
        self.endPoint = endPoint
        self.pathComponents = pathComponents
        self.queryParameters = queryParameters
    }
}
