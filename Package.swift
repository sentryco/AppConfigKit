// swift-tools-version:5.9
import PackageDescription

let package = Package(
   name: "AppConfigKit",
   platforms: [
      .macOS(.v14), // macOS 14 and later
      .iOS(.v17) // iOS 17 and later
   ],
   products: [
      .library(
         name: "AppConfigKit",
         targets: ["AppConfigKit"])
   ],
   dependencies: [
      .package(url: "https://github.com/eonist/UserDefaultSugar", branch: "master"), // UserDefaultSugar package from GitHub
      .package(url: "https://github.com/sentryco/SDUtil", branch: "main"),
      .package(url: "https://github.com/sentryco/Key", branch: "main")
//      .package(url: "https://github.com/sentryco/PersistenceKit", branch: "main"),
//      .package(url: "https://github.com/sentryco/SecUserStore", branch: "main"),
   ],
   targets: [
      .target(
         name: "AppConfigKit",
         dependencies: [ "SDUtil", "UserDefaultSugar", /*"PersistenceKit",*/ /*"SecUserStore",*/ "Key"]), // Defines the Auth target with dependencies on DatabaseLib and UserDefaultSugar
      .testTarget(
         name: "AppConfigKitTests",
         dependencies: ["AppConfigKit"]) // Defines the AuthTests target with a dependency on Auth
   ]
)
