//
//  DynamicJSON.swift
//  DynamicJSON
//
//  Created by Saoud Rizwan on 1/1/19.
//

import Foundation

@dynamicMemberLookup
public enum JSON {
	
	// MARK: Error
	
	public enum Error: Swift.Error {
		case invalidObject
	}
	
	// MARK: Cases
	
	case dictionary(Dictionary<String, JSON>)
	case array(Array<JSON>)
	case string(String)
	case number(NSNumber)
	case bool(Bool)
	case null
	
	// MARK: Dynamic Member Lookup
	
	public subscript(index: Int) -> JSON? {
		if case .array(let arr) = self {
			return index < arr.count ? arr[index] : nil
		}
		return nil
	}
	
	public subscript(key: String) -> JSON? {
		if case .dictionary(let dict) = self {
			return dict[key]
		}
		return nil
	}
	
	public subscript(dynamicMember member: String) -> JSON? {
		if case .dictionary(let dict) = self {
			return dict[member]
		}
		return nil
	}
	
	// MARK: Initializers
	
	public init(data: Data, options: JSONSerialization.ReadingOptions = []) throws {
		do {
			let object = try JSONSerialization.jsonObject(with: data, options: options)
			self = try JSON(object)
		} catch {
			throw error
		}
	}
	
	public init(_ object: Any) throws {
		if let data = object as? Data {
			try self.init(data: data)
		} else if let dictionary = object as? [String: Any] {
			var result = [String: JSON]()
			for (key, value) in dictionary {
				do {
					let json = try JSON(value)
					result[key] = json
				} catch {
					throw error
				}
			}
			self = JSON.dictionary(result)
		} else if let array = object as? [Any] {
			var result = [JSON]()
			for element in array {
				do {
					let json = try JSON(element)
					result.append(json)
				} catch {
					throw error
				}
			}
			self = JSON.array(result)
		} else if let string = object as? String {
			self = JSON.string(string)
		} else if let number = object as? NSNumber {
			self = JSON.number(number)
		} else if let bool = object as? Bool {
			self = JSON.bool(bool)
		} else if object is NSNull {
			self = JSON.null
		} else {
			throw Error.invalidObject
		}
		
	}
	
	// MARK: Accessors
	
	public var dictionary: Dictionary<String, JSON>? {
		if case .dictionary(let value) = self {
			return value
		}
		return nil
	}
	
	public var array: Array<JSON>? {
		if case .array(let value) = self {
			return value
		}
		return nil
	}
	
	public var string: String? {
		if case .string(let value) = self {
			return value
		}
		return nil
	}
	
	public var number: NSNumber? {
		if case .number(let value) = self {
			return value
		} else if case .bool(let value) = self {
			return NSNumber(value: value)
		} else if case .string(let value) = self, let doubleValue = Double(value) {
			return NSNumber(value: doubleValue)
		}
		return nil
	}
	
	public var double: Double? {
		if case .number(let value) = self {
			return value.doubleValue
		} else if case .string(let value) = self, let doubleValue = Double(value) {
			return doubleValue
		}
		return nil
	}
	
	public var int: Int? {
		if case .number(let value) = self {
			return value.intValue
		} else if case .string(let value) = self, let intValue = Int(value) {
			return intValue
		}
		return nil
	}
	
	public var bool: Bool? {
		if case .bool(let value) = self {
			return value
		} else if case .number(let value) = self {
			return value.boolValue
		} else if case .string(let value) = self {
			return ["true", "y", "t", "yes", "1"].contains { value.caseInsensitiveCompare($0) == .orderedSame }
		}
		return nil
	}
	
	// MARK: Helpers
	
	public var object: Any {
		get {
			switch self {
			case .dictionary(let value): return value.mapValues { $0.object }
			case .array(let value): return value.map { $0.object }
			case .string(let value): return value
			case .number(let value): return value
			case .bool(let value): return value
			case .null: return NSNull()
			}
		}
	}
	
	public func data(options: JSONSerialization.WritingOptions = []) throws -> Data {
		return try JSONSerialization.data(withJSONObject: self.object, options: options)
	}
	
}

// MARK: - Comparable

extension JSON: Comparable {
	
	public static func == (lhs: JSON, rhs: JSON) -> Bool {
		switch (lhs, rhs) {
		case (.dictionary, .dictionary): return lhs.dictionary == rhs.dictionary
		case (.array, .array): return lhs.array == rhs.array
		case (.string, .string): return lhs.string == rhs.string
		case (.number, .number): return lhs.number == rhs.number
		case (.bool, .bool): return lhs.bool == rhs.bool
		case (.null, .null): return true
		default: return false
		}
	}
	
	public static func < (lhs: JSON, rhs: JSON) -> Bool {
		switch (lhs, rhs) {
		case (.string, .string):
			if let lhsString = lhs.string, let rhsString = rhs.string {
				return lhsString < rhsString
			}
			return false
		case (.number, .number):
			if let lhsNumber = lhs.number, let rhsNumber = rhs.number {
				return lhsNumber.doubleValue < rhsNumber.doubleValue
			}
			return false
		default: return false
		}
	}
}

// MARK: - Pretty Print

extension JSON: Swift.CustomStringConvertible, Swift.CustomDebugStringConvertible {
	
	public var description: String {
		if let data = try? data(options: .prettyPrinted), let jsonObject = try? JSONSerialization.jsonObject(with: data, options: []) {
			return String(describing: jsonObject)
		}
		return "nil"
	}
	
	public var debugDescription: String {
		return description
	}
}
