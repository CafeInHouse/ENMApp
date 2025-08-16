//
//  Project.swift
//  Shared
//
//  Created by Claude on 8/16/25.
//

@preconcurrency import ProjectDescription

import ProjectDescriptionHelpers

let project = Project(
    name: "Shared",
    targets: [
        .target(
            name: "Shared",
            destinations: [.iPhone],
            product: .staticFramework,
            bundleId: "com.organization.shared",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .extendingDefault(with: InfoPlist.common),
            sources: ["Sources/**"],
            resources: [],
            dependencies: [
                .external(name: "Swinject"),
                .project(target: "ENMFoundation", path: "../ENMFoundation"),
            ]
        ),
        .target(
            name: "SharedTests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "com.organization.shared.tests",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [
                .target(name: "Shared"),
                .xctest
            ]
        )
    ]
)