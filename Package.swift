// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "CodableAlamofire",
    platforms: [
        .iOS(.v8),
        .tvOS(.v9),
        .watchOS(.v2),
        .macOS(.v10_10)
    ],
    products: [
        .library(name: "CodableAlamofire", targets: ["CodableAlamofire"]),
    ],
    dependencies: [
   		.package(url: "https://github.com/Alamofire/Alamofire", from: "4.5.0")
    ],	
    targets: [
    	.target(
			name: "CodableAlamofire", 
    		dependencies: ["Alamofire"]
    	),
    	.testTarget(
	    	name: "CodableAlamofireTests", 
	    	dependencies: ["CodableAlamofire"]
	    )
  	],
    swiftLanguageVersions: [.v4, .v5]
)
