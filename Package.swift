// swift-tools-version: 5.9
// The swift-tools-version declares the minimum version of Swift required to build this package.

import PackageDescription

let package = Package(
    name: "AcuantiOSSDKV11",
    platforms: [
        .iOS(.v15)
    ],
    products: [
        .library(name: "AcuantCommon", targets: ["AcuantCommon"]),
        .library(name: "AcuantImagePreparation", targets: ["AcuantImagePreparation"]),
        .library(name: "AcuantHGLiveness", targets: ["AcuantHGLiveness"]),
        .library(name: "AcuantFaceCapture", targets: ["AcuantFaceCapture"]),
        .library(name: "AcuantCamera", targets: ["AcuantCamera"]),
    ],
    targets: [
        /* START_ACUANT */
        .binaryTarget(
            name: "AcuantCommon",
            path: "EmbeddedFrameworks/AcuantCommon.xcframework"
        ),
        .binaryTarget(
            name: "AcuantImagePreparation",
            path: "EmbeddedFrameworks/AcuantImagePreparation.xcframework"
        ),
        .binaryTarget(
            name: "AcuantDocumentProcessing",
            path: "EmbeddedFrameworks/AcuantDocumentProcessing.xcframework"
        ),
        .binaryTarget(
            name: "AcuantHGLiveness",
            path: "EmbeddedFrameworks/AcuantHGLiveness.xcframework"
        ),
        .target(
            name: "AcuantFaceCapture",
            dependencies: [
                .target(name: "AcuantCommon"),
                .target(name: "AcuantImagePreparation")
            ],
            path: "AcuantFaceCapture/AcuantFaceCapture",
            publicHeadersPath: "AcuantFaceCapture.h",
            cSettings: [
                .headerSearchPath("AcuantFaceCapture/AcuantFaceCapture/AcuantFaceCapture.h")
            ],
            swiftSettings: [
                .unsafeFlags([
                    "-enable-library-evolution",
                    "-emit-module-interface"
                ])
            ]
        ),
        .target(
            name: "AcuantCamera",
            dependencies: [
                .target(name: "AcuantCommon"),
                .target(name: "AcuantImagePreparation"),
            ],
            path: "AcuantCamera/AcuantCamera",
            resources: [.process("Media.xcassets")],
            publicHeadersPath: "include",
            cSettings: [
                .headerSearchPath(".")
            ],
            swiftSettings: [
                .unsafeFlags([
                    "-enable-library-evolution",
                    "-emit-module-interface"
                ])
            ],
            linkerSettings: [
                .linkedLibrary("c++"),
                .linkedLibrary("z"),
                .linkedFramework("CoreImage"),
                .linkedFramework("CoreGraphics"),
                .linkedFramework("CoreFoundation"),
                .linkedFramework("AVFoundation"),
                .linkedFramework("Foundation"),
                .linkedFramework("UIKit")
            ]
        ),
        /* END_ACUANT */
    ]
)
