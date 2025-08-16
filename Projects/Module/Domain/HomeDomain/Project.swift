//
//  Project.swift
//  HomeDomain
//
//  Created by Claude on 8/16/25.
//

@preconcurrency import ProjectDescription

import ProjectDescriptionHelpers

let project = Project(
    name: "HomeDomain",
    targets: [
        .target(
            name: "HomeDomain",
            destinations: [.iPhone],
            product: .staticFramework,
            bundleId: "com.organization.domain.home",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: [],
            dependencies: [
                .project(target: "Shared", path: "../../Shared"),
            ]
        ),
        .target(
            name: "HomeDomainTests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "com.organization.domain.home.tests",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [
                .target(name: "HomeDomain"),
                .xctest
            ]
        )
    ]
)