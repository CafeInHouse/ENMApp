//
//  Project.swift
//  ENMFoundation
//
//  Created by Claude on 8/16/25.
//

@preconcurrency import ProjectDescription

import ProjectDescriptionHelpers

let project = Project(
    name: "ENMFoundation",
    targets: [
        .target(
            name: "ENMFoundation",
            destinations: [.iPhone],
            product: .staticFramework,
            bundleId: "com.organization.foundation",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: []
        ),
        .target(
            name: "ENMFoundationTests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "com.organization.foundation.tests",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [
                .target(name: "ENMFoundation"),
                .xctest
            ]
        )
    ]
)