import PackageDescription

let package = Package(
    name: "CodableAlamofire",
    dependencies : [
   		.Package(url: "https://github.com/Alamofire/Alamofire", majorVersion: 4)
    ],
    exclude: ["Tests"]
)