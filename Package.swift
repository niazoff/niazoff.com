// swift-tools-version:5.2

import PackageDescription

let package = Package(
  name: "niazoff.com",
  platforms: [.macOS(.v10_15)],
  products: [
    .executable(
      name: "niazoff.com",
      targets: ["niazoff.com"]
    )
  ],
  dependencies: [
    .package(name: "Publish", url: "https://github.com/johnsundell/publish.git", from: "0.7.0"),
    .package(name: "SplashPublishPlugin", url: "https://github.com/johnsundell/splashpublishplugin.git", from: "0.1.0"),
    .package(url: "https://github.com/SwiftyGuerrero/CNAMEPublishPlugin", from: "0.1.0"),
    .package(url: "https://github.com/niazoff/SwiftExtensions.git", .branch("master"))
  ],
  targets: [
    .target(
      name: "niazoff.com",
      dependencies: [
        "Publish",
        "SplashPublishPlugin",
        "CNAMEPublishPlugin",
        "SwiftExtensions"
      ]
    )
  ]
)
