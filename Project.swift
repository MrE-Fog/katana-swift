//
//  Project.swift
//  Katana
//
//  Copyright © 2021 Bending Spoons.
//  Distributed under the MIT License.
//  See the LICENSE file for more information.

import ProjectDescription

let iOSTargetVersion = "11.0"

// MARK: - Actions

let actions: [TargetAction] = [
  .pre(
    tool: "swiftlint",
    arguments: ["--lenient"],
    name: "SwiftLint"
  ),
  .pre(
    tool: "swiftformat",
    arguments: ["."],
    name: "SwiftFormat"
  ),
]

// MARK: - Main Target

let mainTarget = Target(
  name: "Katana",
  platform: .iOS,
  product: .framework,
  bundleId: "com.bendingspoonsapps.Katana",
  deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone, .ipad, .mac]),
  infoPlist: .default,
  sources: ["Sources/**"],
  actions: actions,
  dependencies: [
    .cocoapods(path: "."),
  ]
)

// MARK: - Tests Target

let testsTarget = Target(
  name: "KatanaTests",
  platform: .iOS,
  product: .unitTests,
  bundleId: "com.bendingspoonsapps.KatanaTests",
  deploymentTarget: .iOS(targetVersion: iOSTargetVersion, devices: [.iphone, .ipad, .mac]),
  infoPlist: .default,
  sources: ["Tests/**"],
  actions: actions,
  dependencies: [
    .target(name: mainTarget.name),
  ]
)

// MARK: - Project Definition

let project = Project(
  name: "Katana",
  organizationName: "BendingSpoons",
  targets: [
    mainTarget,
    testsTarget,
  ],
  schemes: [
    .init(
      name: "Katana",
      buildAction: .init(targets: [.init(stringLiteral: mainTarget.name)]),
      testAction: .init(targets: [.init(stringLiteral: testsTarget.name)])
    ),
  ]
)
