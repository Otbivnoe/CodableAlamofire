//
//  MainTests.swift
//  CodableAlamofire
//
//  Created by Nikita Ermolenko on 11/06/2017.
//

import XCTest
import Alamofire
import CodableAlamofire

private struct Repo: Decodable {
    let name: String
    let stars: Int
    let url: URL
    let randomDateCommit: Date
    
    private enum CodingKeys: String, CodingKey {
        case name
        case stars
        case url
        case randomDateCommit = "random_date_commit"
    }
}

final class MainTests: XCTestCase {
    
    static var allTests = [
        ("testResponseSimpleObject", testResponseSimpleObject),
        ("testResponseArrayOfObjects", testResponseArrayOfObjects),
        ("testResponseArrayOfObjectsByKeypath", testResponseArrayOfObjectsByKeypath)
    ]
    
    func testResponseSimpleObject() {
        let url = URL(string: "https://raw.githubusercontent.com/otbivnoe/CodableAlamofire/master/object.json")!
        let expectation = self.expectation(description: "Reponse from \(url.absoluteString)")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        Alamofire.request(url).responseDecodableObject(decoder: decoder) { (response: DataResponse<Repo>) in
            let repo = response.result.value
            
            XCTAssertNotNil(repo, "Result should not be nil")
            XCTAssertEqual(repo?.name, "Alamofire")
            XCTAssertEqual(repo?.stars, 23857)
            XCTAssertEqual(repo?.url.absoluteString, "https://github.com/Alamofire/Alamofire")
            XCTAssertEqual(repo?.randomDateCommit.timeIntervalSince1970, 1489276800)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
        }
    }
    
    func testResponseArrayOfObjects() {
        let url = URL(string: "https://raw.githubusercontent.com/otbivnoe/CodableAlamofire/master/array.json")!
        let expectation = self.expectation(description: "Reponse from \(url.absoluteString)")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        Alamofire.request(url).responseDecodableObject(decoder: decoder) { (response: DataResponse<[Repo]>) in
            let repos = response.result.value
            
            XCTAssertNotNil(repos, "Result should not be nil")
            
            XCTAssertEqual(repos?.first?.name, "Alamofire")
            XCTAssertEqual(repos?.first?.stars, 23857)
            XCTAssertEqual(repos?.first?.url.absoluteString, "https://github.com/Alamofire/Alamofire")
            XCTAssertEqual(repos?.first?.randomDateCommit.timeIntervalSince1970, 1489276800)
            
            XCTAssertEqual(repos?.last?.name, "RxSwift")
            XCTAssertEqual(repos?.last?.stars, 9600)
            XCTAssertEqual(repos?.last?.url.absoluteString, "https://github.com/ReactiveX/RxSwift")
            XCTAssertEqual(repos?.last?.randomDateCommit.timeIntervalSince1970, 1494547200)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
        }
    }
    func testResponseArrayOfObjectsByKeypath() {
        let url = URL(string: "https://raw.githubusercontent.com/otbivnoe/CodableAlamofire/master/keypath.json")!
        let expectation = self.expectation(description: "Reponse from \(url.absoluteString)")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        Alamofire.request(url).responseDecodableObject(keyPath: "result.libraries", decoder: decoder) { (response: DataResponse<[Repo]>) in
            let repos = response.result.value
            
            XCTAssertNotNil(repos, "Result should not be nil")
            
            XCTAssertEqual(repos?.first?.name, "Alamofire")
            XCTAssertEqual(repos?.first?.stars, 23857)
            XCTAssertEqual(repos?.first?.url.absoluteString, "https://github.com/Alamofire/Alamofire")
            XCTAssertEqual(repos?.first?.randomDateCommit.timeIntervalSince1970, 1489276800)
            
            XCTAssertEqual(repos?.last?.name, "RxSwift")
            XCTAssertEqual(repos?.last?.stars, 9600)
            XCTAssertEqual(repos?.last?.url.absoluteString, "https://github.com/ReactiveX/RxSwift")
            XCTAssertEqual(repos?.last?.randomDateCommit.timeIntervalSince1970, 1494547200)
            
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
        }
    }
}
