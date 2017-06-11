// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "CodableAlamofire",
    dependencies : [
   		.package(url: "https://github.com/Alamofire/Alamofire", .branch("swift4"))
    ]
)