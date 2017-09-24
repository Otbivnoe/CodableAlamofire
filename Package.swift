// swift-tools-version:4.0

import PackageDescription

let package = Package(
    name: "CodableAlamofire",
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