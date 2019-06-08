// swift-tools-version:5.1

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
    .target(
      name: "OmniTreeCodecs",
      dependencies: ["OmniTreeSchema"]
    ),
    .testTarget(
      name: "OmniTreeCodecsTests",
      dependencies: ["OmniTreeCodecs"]
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
