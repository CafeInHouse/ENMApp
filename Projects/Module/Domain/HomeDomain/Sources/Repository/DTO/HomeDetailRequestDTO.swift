//
//  HomeDetailRequestDTO.swift
//  HomeDomain
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

public struct HomeDetailRequestDTO: Codable, Sendable, Hashable {
    public let id: String
    
    public init(id: String) {
        self.id = id
    }
}
