// swift-tools-version:5.1

import PackageDescription

let package = Package(
    name: "CodableAlamofire",
    platforms: [
        .iOS(.v11),
        .tvOS(.v13),
        .watchOS(.v6)
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
  	]
)
