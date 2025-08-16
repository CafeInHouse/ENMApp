//
//  Project.swift
//  ENMApp
//
//  Created by Claude on 8/16/25.
//

@preconcurrency import ProjectDescription

import ProjectDescriptionHelpers

let project = Project(
    name: "ENMApp",
    targets: [
        .target(
            name: "ENMApp",
            destinations: [.iPhone],
            product: .app,
            bundleId: "com.organization.linsaeng.enmapp",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .extendingDefault(with: InfoPlist.common),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .project(target: "HomeService", path: "../Module/Service/HomeService")
            ]
        ),
        .target(
            name: "ENMAppTests",
            destinations: [.iPhone],
            product: .unitTests,
            bundleId: "com.organization.linsaeng.enmapp.tests",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .default,
            sources: ["Tests/**"],
            resources: [],
            dependencies: [
                .target(name: "ENMApp"),
                .xctest
            ]
        )
    ]
)