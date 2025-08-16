//
//  Project.swift
//  ENMUI
//
//  Created by Claude on 8/16/25.
//

@preconcurrency import ProjectDescription

import ProjectDescriptionHelpers

let project = Project(
    name: "ENMUI",
    targets: [
        .target(
            name: "ENMUI",
            destinations: [.iPhone],
            product: .framework,
            bundleId: "com.organization.enmui",
            deploymentTargets: .iOS("17.0"),
            infoPlist: .extendingDefault(with: InfoPlist.common),
            sources: ["Sources/**"],
            resources: ["Resources/**"],
            dependencies: [
                .sdk(name: "UIKit", type: .framework),
                .sdk(name: "SwiftUI", type: .framework)
            ]
        )
    ]
)
