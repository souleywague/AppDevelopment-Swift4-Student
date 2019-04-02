//
//  Helper+URL.swift
//  ItunesSearchApp
//
//  Created by Souley on 24/01/2019.
//  Copyright © 2019 Souley. All rights reserved.
//

import Foundation

extension URL {
    
    func withQueries(_ queries: [String: String]) -> URL? {
        
        var components = URLComponents(url: self, resolvingAgainstBaseURL: true)
        components?.queryItems = queries.compactMap { URLQueryItem(name: $0.0, value: $0.1) }
        return components?.url
    }
}
