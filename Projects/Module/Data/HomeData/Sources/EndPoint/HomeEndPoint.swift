//
//  HomeEndPoint.swift
//  HomeData
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

import HomeDomain

public protocol EndpointType: Sendable {}

public enum HomeEndPoint: EndpointType {
    case home(request: HomeRequestDTO)
}
