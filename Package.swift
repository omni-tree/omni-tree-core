// swift-tools-version:4.2

// Copyright 2018 The OmniTree Authors.

import PackageDescription

let package = Package(
  name: "OmniTreeCore",
  products: [
    .library(
      name: "OmniTreeSchema",
      targets: ["OmniTreeSchema"]
    ),
    .library(
      name: "OmniTreeCodecs",
      targets: ["OmniTreeCodecs"]
    ),
    .library(
      name: "OmniTreeData",
      targets: ["OmniTreeData"]
    ),
  ],
  dependencies: [
    // .package(url: /* package url */, from: "1.0.0"),
  ],
  targets: [
    .target(
      name: "OmniTreeSchema",
      dependencies: []
    ),
    .testTarget(
      name: "OmniTreeSchemaTests",
      dependencies: ["OmniTreeSchema"]
    ),
    .target(
      name: "OmniTreeCodecs",
      dependencies: ["OmniTreeSchema"]
    ),
    .target(
      name: "OmniTreeData",
      dependencies: ["OmniTreeSchema"]
    ),
    .testTarget(
      name: "OmniTreeDataTests",
      dependencies: ["OmniTreeData"]
    ),
  ]
)
