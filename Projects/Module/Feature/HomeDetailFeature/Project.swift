//
//  Project.swift
//  HomeDetailFeature
//
//  Created by Claude on 8/16/25.
//

@preconcurrency import ProjectDescription

import ProjectDescriptionHelpers

let project = Project(
    name: "HomeDetailFeature",
    targets: [
        .target(
            name: "HomeDetailFeature",
            destinations: [.iPhone],
            product: .staticFramework,
            bundleId: "com.organization.feature.homedetail",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: [],
            dependencies: [
                .project(target: "HomeData", path: "../../Data/HomeData"),
            ]
        ),
        .target(
            name: "HomeDetailFeatureTests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "com.organization.feature.homedetail.tests",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [
                .target(name: "HomeDetailFeature"),
                .xctest
            ]
        )
    ]
)
