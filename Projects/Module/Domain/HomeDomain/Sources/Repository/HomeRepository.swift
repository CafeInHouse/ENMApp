//
//  HomeRepository.swift
//  HomeDomain
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

public protocol HomeRepository: Sendable {
    func fetch() async throws -> [Product]
}
