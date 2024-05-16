// swift-tools-version: 5.9
// This is a Skip (https://skip.tools) package,
// containing a Swift Package Manager project
// that will use the Skip build plugin to transpile the
// Swift Package, Sources, and Tests into an
// Android Gradle Project with Kotlin sources and JUnit tests.
import PackageDescription
import Foundation

// Set SKIP_ZERO=1 to build without Skip libraries
let zero = ProcessInfo.processInfo.environment["SKIP_ZERO"] != nil
let skipstone = !zero ? [Target.PluginUsage.plugin(name: "skipstone", package: "skip")] : []

let package = Package(
    name: "the-shop-skip",
    defaultLocalization: "en",
    platforms: [.iOS(.v16), .macOS(.v13), .tvOS(.v16), .watchOS(.v9), .macCatalyst(.v16)],
    products: [
        .library(name: "TheShopApp", type: .dynamic, targets: ["TheShop"]),
        .library(name: "TheShopModel", targets: ["TheShopModel"]),
        .library(name: "TheShopCore", targets: ["TheShopCore"]),
    ],
    dependencies: [
        .package(url: "https://source.skip.tools/skip.git", from: "0.8.44"),
        .package(url: "https://source.skip.tools/skip-ui.git", from: "0.0.0"),
        .package(url: "https://source.skip.tools/skip-model.git", from: "0.0.0"),
        .package(url: "https://source.skip.tools/skip-foundation.git", from: "0.0.0")
    ],
    targets: [
        .target(name: "TheShop", dependencies: ["TheShopModel"] + (zero ? [] : [.product(name: "SkipUI", package: "skip-ui")]), resources: [.process("Resources")], plugins: skipstone),
        .testTarget(name: "TheShopTests", dependencies: ["TheShop"] + (zero ? [] : [.product(name: "SkipTest", package: "skip")]), resources: [.process("Resources")], plugins: skipstone),
        .target(name: "TheShopModel", dependencies: ["TheShopCore"] + (zero ? [] : [.product(name: "SkipModel", package: "skip-model")]), resources: [.process("Resources")], plugins: skipstone),
        .testTarget(name: "TheShopModelTests", dependencies: ["TheShopModel"] + (zero ? [] : [.product(name: "SkipTest", package: "skip")]), resources: [.process("Resources")], plugins: skipstone),
        .target(name: "TheShopCore", dependencies: (zero ? [] : [.product(name: "SkipFoundation", package: "skip-foundation")]), resources: [.process("Resources")], plugins: skipstone),
        .testTarget(name: "TheShopCoreTests", dependencies: ["TheShopCore"] + (zero ? [] : [.product(name: "SkipTest", package: "skip")]), resources: [.process("Resources")], plugins: skipstone),
    ]
)
