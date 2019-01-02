//
//  DynamicJSONTests.swift
//  DynamicJSONTests
//
//  Created by Saoud Rizwan on 1/1/19.
//

import XCTest
import DynamicJSON

class DynamicJSONTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
	
	// MARK: Tests
	
	func test_data_initializer() {
		let usersData = loadMockUsersData()
		do {
			let json = try JSON(usersData)
			XCTAssert(json[0]?.id?.int == 1)
			XCTAssert(json[0]?.username?.string == "Bret")
			XCTAssert(json[0]?.address?.street?.string == "Kulas Light")
			XCTAssert(json[0]?.address?.geo?.lat?.double == -37.3159)
		} catch {
			XCTFail(stringify(error))
		}
	}
	
	func test_convert_json_to_data_and_compare() {
		let usersData = loadMockUsersData()
		do {
			let json = try JSON(usersData)
			let backToData = try json.data()
			let backToJson = try JSON(backToData)
			
			XCTAssert(json == backToJson)
		} catch {
			XCTFail(stringify(error))
		}
	}
	
	func test_comparable() {
		let usersData = loadMockUsersData()
		let postsData = loadMockPostsData()
		do {
			
			// Data
			
			let users = try JSON(usersData)
			let users2 = try JSON(usersData)
			let posts = try JSON(postsData)
			let posts2 = try JSON(postsData)
			
			XCTAssert(users == users2)
			XCTAssert(posts == posts2)
			XCTAssert(users != posts)
			
			let backToData = try users.data()
			let backToJson = try JSON(backToData)
			
			XCTAssert(backToJson == users)
			XCTAssert(backToJson != posts)
			
			// String
			
			let string1 = try JSON("string 1")
			let string2 = try JSON("string 2")
			let string1copy = try JSON("string 1")
			XCTAssert(string1 != string2)
			XCTAssert(string1 == string1copy)
			
			// Bool
			
			let bool1 = try JSON(true)
			let bool2 = try JSON(false)
			let bool1copy = try JSON(true)
			XCTAssert(bool1 != bool2)
			XCTAssert(bool1 == bool1copy)
			
			// Number
			
			let number1 = try JSON(1)
			let number2 = try JSON(2)
			let number1copy = try JSON(1)
			XCTAssert(number1 != number2)
			XCTAssert(number1 == number1copy)
			
			// Dictionary
			
			let dict1 = try JSON(["key1": "val1", "key2": 2])
			let dict2 = try JSON(["im": "different"])
			let dict1copy = try JSON(["key1": "val1", "key2": 2])
			XCTAssert(dict1 != dict2)
			XCTAssert(dict1 == dict1copy)
			
			// Array
			
			let arr1 = try JSON(["1", "2", "3", 4])
			let arr2 = try JSON(["im", "different"])
			let arr1copy = try JSON(["1", "2", "3", 4])
			XCTAssert(arr1 != arr2)
			XCTAssert(arr1 == arr1copy)
		} catch {
			XCTFail(stringify(error))
		}
	}
	
	// MARK: Helpers
	
	func loadMockUsersData() -> Data {
		if let path = Bundle(for: DynamicJSONTests.self).path(forResource: "Users", ofType: "json") {
			do {
				let data = try Data(contentsOf: URL(fileURLWithPath: path), options: Data.ReadingOptions.mappedIfSafe)
				return data
			} catch {
				fatalError(stringify(error))
			}
		}
		fatalError("Users.json is missing")
	}
	
	func loadMockPostsData() -> Data {
		if let path = Bundle(for: DynamicJSONTests.self).path(forResource: "Posts", ofType: "json") {
			do {
				let data = try Data(contentsOf: URL(fileURLWithPath: path), options: Data.ReadingOptions.mappedIfSafe)
				return data
			} catch {
				fatalError(stringify(error))
			}
		}
		fatalError("Posts.json is missing")
	}
	
	func stringify(_ error: Error) -> String {
		var result = "localizedDescription: \(error.localizedDescription)"
		if let localizedFailureReason = (error as NSError).localizedFailureReason {
			result += "\nlocalizedFailureReason: \(localizedFailureReason)"
		}
		if let localizedRecoverySuggestion = (error as NSError).localizedRecoverySuggestion {
			result += "\nlocalizedRecoverySuggestion: \(localizedRecoverySuggestion)"
		}
		if let localizedRecoveryOptions = (error as NSError).localizedRecoveryOptions {
			result += "\nlocalizedRecoveryOptions:"
			for option in localizedRecoveryOptions {
				result += "\n-\(option)"
			}
		}
		return result
	}

}
