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
		let json = JSON(usersData)
		XCTAssert(json[0].id.int == 1)
		XCTAssert(json[0].username.string == "Bret")
		XCTAssert(json[0].address.street.string == "Kulas Light")
		XCTAssert(json[0].address.geo.lat.double == -37.3159)
	}
	
	func test_convert_json_to_data_and_compare() {
		let usersData = loadMockUsersData()
		let json = JSON(usersData)
		let backToData = json.data()
		let backToJson = JSON(backToData)
		
		XCTAssert(json == backToJson)
	}
	
	func test_comparable() {
		let usersData = loadMockUsersData()
		let postsData = loadMockPostsData()
		
		// Data
		
		let users = JSON(usersData)
		let users2 = JSON(usersData)
		let posts = JSON(postsData)
		let posts2 = JSON(postsData)
		
		XCTAssert(users == users2)
		XCTAssert(posts == posts2)
		XCTAssert(users != posts)
		
		let backToData = users.data()
		let backToJson = JSON(backToData)
		
		XCTAssert(backToJson == users)
		XCTAssert(backToJson != posts)
		
		// String
		
		let string1 = JSON("string 1")
		let string2 = JSON("string 2")
		let string1copy = JSON("string 1")
		XCTAssert(string1 != string2)
		XCTAssert(string1 == string1copy)
		
		// Bool
		
		let bool1 = JSON(true)
		let bool2 = JSON(false)
		let bool1copy = JSON(true)
		XCTAssert(bool1 != bool2)
		XCTAssert(bool1 == bool1copy)
		
		// Number
		
		let number1 = JSON(1)
		let number2 = JSON(2)
		let number1copy = JSON(1)
		XCTAssert(number1 != number2)
		XCTAssert(number1 == number1copy)
		
		// Dictionary
		
		let dict1 = JSON(["key1": "val1", "key2": 2])
		let dict2 = JSON(["im": "different"])
		let dict1copy = JSON(["key1": "val1", "key2": 2])
		XCTAssert(dict1 != dict2)
		XCTAssert(dict1 == dict1copy)
		
		// Array
		
		let arr1 = JSON(["1", "2", "3", 4])
		let arr2 = JSON(["im", "different"])
		let arr1copy = JSON(["1", "2", "3", 4])
		XCTAssert(arr1 != arr2)
		XCTAssert(arr1 == arr1copy)
	}
	
	func test_string_conversion() {
		XCTAssert(JSON("Hello").string == "Hello")
		XCTAssert(JSON(true).string == "true")
		XCTAssert(JSON(false).string == "false")
		XCTAssert(JSON(1).string == "1")
		XCTAssert(JSON(10.123).string == "10.123")
		XCTAssert(JSON(2.1).string == "2.1")
		XCTAssert(JSON([1, 2, 3]).string == nil)
		XCTAssert(JSON(["key": "val"]).string == nil)
	}
	
	func test_number_conversion() {
		XCTAssert(JSON(1).number == 1)
		XCTAssert(JSON(1).int == 1)
		XCTAssert(JSON(1).double == 1)
		XCTAssert(JSON("1").number == 1)
		XCTAssert(JSON("1").int == 1)
		XCTAssert(JSON("1").double == 1)
		
		XCTAssert(JSON(1.25).number == 1.25)
		XCTAssert(JSON(1.25).int == 1)
		XCTAssert(JSON(1.25).double == 1.25)
		XCTAssert(JSON("1.25").number == 1.25)
		XCTAssert(JSON("1.25").int == 1)
		XCTAssert(JSON("1.25").double == 1.25)
		
		XCTAssert(JSON(true).number == 1)
		XCTAssert(JSON(false).number == 0)
	}
	
	func test_bool_conversion() {
		XCTAssert(JSON(true).bool == true)
		XCTAssert(JSON(false).bool == false)
		XCTAssert(JSON(1).bool == true)
		XCTAssert(JSON(0).bool == false)
		
		XCTAssert(JSON("true").bool == true)
		XCTAssert(JSON("false").bool == false)
		XCTAssert(JSON("y").bool == true)
		XCTAssert(JSON("n").bool == false)
		XCTAssert(JSON("t").bool == true)
		XCTAssert(JSON("f").bool == false)
		XCTAssert(JSON("yes").bool == true)
		XCTAssert(JSON("no").bool == false)
		XCTAssert(JSON("1").bool == true)
		XCTAssert(JSON("0").bool == false)
		
		XCTAssert(JSON("Y").bool == true)
		XCTAssert(JSON("N").bool == false)
		XCTAssert(JSON("T").bool == true)
		XCTAssert(JSON("F").bool == false)
		XCTAssert(JSON("True").bool == true)
		XCTAssert(JSON("FaLsE").bool == false)
		XCTAssert(JSON("YeS").bool == true)
		XCTAssert(JSON("nO").bool == false)
		
		XCTAssert(JSON("sure").bool == nil)
	}
	
	func test_string_subscript_accessor() {
		let usersData = loadMockUsersData()
		let json = JSON(usersData)
		XCTAssert(json[0]["id"].int == 1)
		XCTAssert(json[0]["username"].string == "Bret")
		XCTAssert(json[0].address["street"].string == "Kulas Light")
		XCTAssert(json[0].address["geo"].lat.double == -37.3159)
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
