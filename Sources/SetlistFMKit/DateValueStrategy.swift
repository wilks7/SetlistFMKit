
import Foundation

public protocol DateValueStrategy {
    associatedtype RawValue: Codable
    associatedtype Value: Codable

    static func decode(_ value: RawValue) throws -> Value
    static func encode(_ date: Value) -> RawValue
}

/// Uses a format to decode a date from Codable.
@propertyWrapper public struct DateFormatted<T: DateValueStrategy>: Codable {
    public let value: T.RawValue
    public var wrappedValue: T.Value
    
    public init(wrappedValue: T.Value) {
            self.wrappedValue = wrappedValue
            self.value = T.encode(wrappedValue)
        }
        
    public init(from decoder: Decoder) throws {
        self.value = try T.RawValue(from: decoder)
        self.wrappedValue = try T.decode(value)
    }
    
    public func encode(to encoder: Encoder) throws {
        try value.encode(to: encoder)
    }
    

}
public enum DateStrategyError: Swift.Error {
    case decode
}



