//
//  Project.swift
//  HomeFeature
//
//  Created by Claude on 8/16/25.
//

@preconcurrency import ProjectDescription

import ProjectDescriptionHelpers

let project = Project(
    name: "HomeFeature",
    targets: [
        .target(
            name: "HomeFeature",
            destinations: [.iPhone],
            product: .staticFramework,
            bundleId: "com.organization.feature.home",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: [],
            dependencies: [
                .project(target: "HomeData", path: "../../Data/HomeData"),
            ]
        ),
        .target(
            name: "HomeFeatureTests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "com.organization.feature.home.tests",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [
                .target(name: "HomeFeature"),
                .xctest
            ]
        )
    ]
)