//
//  DI.swift
//  Shared
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

import Swinject

public enum DI: Sendable {

    public static let container = Container()

    public static func register(assemblies: [Assembly]) {
        assemblies.forEach { $0.assemble(container: container) }
    }
}
