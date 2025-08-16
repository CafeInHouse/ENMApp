//
//  Project.swift
//  HomeData
//
//  Created by Claude on 8/16/25.
//

@preconcurrency import ProjectDescription

import ProjectDescriptionHelpers

let project = Project(
    name: "HomeData",
    targets: [
        .target(
            name: "HomeData",
            destinations: [.iPhone],
            product: .staticFramework,
            bundleId: "com.organization.data.home",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "HomeDomain", path: "../../Domain/HomeDomain"),
            ]
        ),
        .target(
            name: "HomeDataTests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "com.organization.data.home.tests",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [
                .target(name: "HomeData"),
                .xctest
            ]
        )
    ]
)