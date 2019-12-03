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

private struct NotMappableRepo: Decodable {
    let commit: String
}

final class MainTests: XCTestCase {
    
    static var allTests = [
        ("testResponseSimpleObject", testResponseSimpleObject),
        ("testResponseArrayOfObjects", testResponseArrayOfObjects),
        ("testResponseArrayOfObjectsByKeypath", testResponseArrayOfObjectsByKeyPath),
        ("testResponseWithEmptyKeyPath", testResponseWithEmptyKeyPath),
        ("testResponseWithInvalidKeyPath", testResponseWithInvalidKeyPath),
        ("testResponseWithWrongPropertyKeyObject", testResponseWithWrongPropertyKeyObject),
        ("testResponseWithWrongPropertyKeyObjectByKeyPath", testResponseWithWrongPropertyKeyObjectByKeyPath)
    ]
    
    func testResponseSimpleObject() {
        let url = URL(string: "https://raw.githubusercontent.com/otbivnoe/CodableAlamofire/master/Tests/Mock/object.json")!
        let expectation = self.expectation(description: "Reponse from \(url.absoluteString)")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970

        AF.request(url).responseDecodableObject(decoder: decoder) { (response: AFDataResponse<Repo>) in
            let repo = response.value
            
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
        let url = URL(string: "https://raw.githubusercontent.com/otbivnoe/CodableAlamofire/master/Tests/Mock/array.json")!
        let expectation = self.expectation(description: "Reponse from \(url.absoluteString)")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        AF.request(url).responseDecodableObject(decoder: decoder) { (response: AFDataResponse<[Repo]>) in
            let repos = response.value
            
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
    
    func testResponseArrayOfObjectsByKeyPath() {
        let url = URL(string: "https://raw.githubusercontent.com/otbivnoe/CodableAlamofire/master/Tests/Mock/keypathArray.json")!
        let expectation = self.expectation(description: "Reponse from \(url.absoluteString)")
        
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .secondsSince1970
        
        AF.request(url).responseDecodableObject(keyPath: "result.libraries", decoder: decoder) { (response: AFDataResponse<[Repo]>) in
            let repos = response.value
            
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
    
    func testResponseWithEmptyKeyPath() {
        let url = URL(string: "https://raw.githubusercontent.com/otbivnoe/CodableAlamofire/master/Tests/Mock/keypathArray.json")!
        let expectation = self.expectation(description: "Reponse from \(url.absoluteString)")
        
        AF.request(url).responseDecodableObject(keyPath: "") { (response: AFDataResponse<[Repo]>) in
            XCTAssertNotNil(response.error)
            if case AFError.responseSerializationFailed(reason: .decodingFailed(error: AlamofireDecodableError.emptyKeyPath)) = response.error! {
                XCTAssertTrue(true)
            }
            else {
                XCTAssertTrue(false)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
        }
    }
    
    func testResponseWithInvalidKeyPath() {
        let url = URL(string: "https://raw.githubusercontent.com/otbivnoe/CodableAlamofire/master/Tests/Mock/keypathArray.json")!
        let expectation = self.expectation(description: "Reponse from \(url.absoluteString)")
        
        AF.request(url).responseDecodableObject(keyPath: "keypath") { (response: AFDataResponse<[Repo]>) in
            XCTAssertNotNil(response.error)
            if case AFError.responseSerializationFailed(reason: .decodingFailed(error: AlamofireDecodableError.invalidKeyPath)) = response.error! {
                XCTAssertTrue(true)
            }
            else {
                XCTAssertTrue(false)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
        }
    }
    
    func testResponseWithWrongPropertyKeyObject() {
        let url = URL(string: "https://raw.githubusercontent.com/otbivnoe/CodableAlamofire/master/Tests/Mock/object.json")!
        let expectation = self.expectation(description: "Reponse from \(url.absoluteString)")
        
        AF.request(url).responseDecodableObject { (response: AFDataResponse<NotMappableRepo>) in
            XCTAssertNotNil(response.error)
            if case AFError.responseSerializationFailed(reason: .customSerializationFailed(error: DecodingError.keyNotFound)) = response.error! {
                XCTAssertTrue(true)
            }
            else {
                XCTAssertTrue(false)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
        }
    }
    
    func testResponseWithWrongPropertyKeyObjectByKeyPath() {
        let url = URL(string: "https://raw.githubusercontent.com/otbivnoe/CodableAlamofire/master/Tests/Mock/keypathObject.json")!
        let expectation = self.expectation(description: "Reponse from \(url.absoluteString)")
        
        AF.request(url).responseDecodableObject(keyPath: "result.library") { (response: AFDataResponse<NotMappableRepo>) in
            XCTAssertNotNil(response.error)
            if case AFError.responseSerializationFailed(reason: .customSerializationFailed(error: DecodingError.keyNotFound)) = response.error! {
                XCTAssertTrue(true)
            }
            else {
                XCTAssertTrue(false)
            }
            expectation.fulfill()
        }
        
        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
        }
    }

    func testResponseWithInvalidNestedJSONByKeypath() {
        let url = URL(string: "https://raw.githubusercontent.com/Otbivnoe/CodableAlamofire/master/Tests/Mock/emptyKeypath.json")!
        let expectation = self.expectation(description: "Reponse from \(url.absoluteString)")

        AF.request(url).responseDecodableObject(keyPath: "data") { (response: AFDataResponse<NotMappableRepo>) in
            XCTAssertNotNil(response.error)
            if case AFError.responseSerializationFailed(reason: .decodingFailed(error: AlamofireDecodableError.invalidJSON)) = response.error! {
                XCTAssertTrue(true)
            }
            else {
                XCTAssertTrue(false)
            }
            expectation.fulfill()
        }

        waitForExpectations(timeout: 10) { error in
            XCTAssertNil(error)
        }
    }
}
