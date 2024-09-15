import Foundation

protocol DecodableDefaultSource {
    associatedtype Value: Decodable
    static var defaultValue: Value { get }
}

enum DecodableDefault {}

extension DecodableDefault {
    @propertyWrapper
    struct Wrapper<Source: DecodableDefaultSource> {
        typealias Value = Source.Value
        var wrappedValue = Source.defaultValue
    }
}

extension DecodableDefault.Wrapper: Decodable {
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        wrappedValue = try container.decode(Value.self)
    }
}

extension KeyedDecodingContainer {
    func decode<T>(
        _ type: DecodableDefault.Wrapper<T>.Type,
        forKey key: Key
    ) throws -> DecodableDefault.Wrapper<T> {
        try decodeIfPresent(type, forKey: key) ?? .init()
    }
}

extension DecodableDefault {
    typealias Source = DecodableDefaultSource
    typealias Array = Decodable & ExpressibleByArrayLiteral
    typealias Dictionary = Decodable & ExpressibleByDictionaryLiteral

    enum Sources {
        enum True: DecodableDefaultSource {
            static var defaultValue: Bool { true }
        }
        
        enum False: DecodableDefaultSource {
            static var defaultValue: Bool { false }
        }

        enum EmptyString: DecodableDefaultSource {
            static var defaultValue: String { "" }
        }

        enum EmptyArray<T: Array>: DecodableDefaultSource {
            static var defaultValue: T { [] }
        }

        enum EmptyDictionary<T: Dictionary>: DecodableDefaultSource {
            static var defaultValue: T { [:] }
        }
    }
}

extension DecodableDefault {
    typealias True = Wrapper<Sources.True>
    typealias False = Wrapper<Sources.False>
    typealias EmptyString = Wrapper<Sources.EmptyString>
    typealias EmptyArray<T: Array> = Wrapper<Sources.EmptyArray<T>>
    typealias EmptyDictionary<T: Dictionary> = Wrapper<Sources.EmptyDictionary<T>>
}
