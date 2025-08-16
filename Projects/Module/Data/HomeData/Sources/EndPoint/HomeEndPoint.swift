//
//  HomeEndPoint.swift
//  HomeData
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

import HomeDomain

public protocol EndpointType: Sendable {
    var baseURL: String { get }
    var path: String { get }
    var method: String { get }
    var encodable: Encodable? { get }
    var headers: [String: Any] { get }
}

public enum HomeEndPoint: EndpointType {
    case home(request: HomeRequestDTO)
    case detail(request: HomeDetailRequestDTO)
    

    public var baseURL: String {
        return ""
    }

    public var path: String {
        switch self {
        case .home:
            return "/home"
        case .detail(let request):
            return "\(request.id)"

        }
    }

    public var method: String {
        switch self {
        case .home:
            return "GET"

        case .detail:
            return "GET"

        }
    }

    public var encodable: (any Encodable)? {
        switch self {
        case .home(let request):
            return request

        case .detail(let request):
            return request
        }
    }

    public var headers: [String: Any] {
        return [:]
    }
    
}
