//
//  Project.swift
//  HomeService
//
//  Created by Claude on 8/16/25.
//

@preconcurrency import ProjectDescription

import ProjectDescriptionHelpers

let project = Project(
    name: "HomeService",
    targets: [
        .target(
            name: "HomeService",
            destinations: [.iPhone],
            product: .staticFramework,
            bundleId: "com.organization.service.home",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "HomeFeature", path: "../../Feature/HomeFeature"),
            ]
        ),
        .target(
            name: "HomeServiceTests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "com.organization.service.home.tests",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [
                .target(name: "HomeService"),
                .xctest
            ]
        )
    ]
)
