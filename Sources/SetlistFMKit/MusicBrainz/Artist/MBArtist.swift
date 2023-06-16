//
//  File.swift
//  
//
//  Created by Michael on 6/15/23.
//

import Foundation

public struct MBArtist: Decodable, Identifiable {
    public let id: String
    public let name: String
    public let sortName: String?
    public let type: String?
    public let disambiguation: String?
    public let gender: String?
    public let country: String?
    public let area: Area?
    public let beginArea: Area?
    public let endArea: Area?
    public let lifeSpan: LifeSpan?
    public let aliases: [Alias]?
    
    public enum CodingKeys: String, CodingKey {
        case id, name, type, disambiguation, gender, country, area
        case sortName = "sort-name"
        case beginArea = "begin-area" // map JSON's "begin-area" to "beginArea"
        case endArea = "end-area"     // map JSON's "end-area" to "endArea"
        case lifeSpan = "life-span"   // map JSON's "life-span" to "lifeSpan"
        case aliases
    }
    
    public struct Area: Decodable, Equatable {
        public let id: String
        public let name: String?
        public let sortName: String?
        public enum CodingKeys: String, CodingKey {
            case id, name
            case sortName = "sort-name"  // map JSON's "sort-name" to "sortName"
        }
    }
    
    public struct LifeSpan: Decodable {
        public let ended: Bool?
        @DateFormatted<MBArtistDateStrategy> public var begin: Date?
        @DateFormatted<MBArtistDateStrategy> public var end: Date?

//        public let begin: String?
//        public let end: String?
    }
    
    public struct Alias: Decodable {
        public let name: String?
        public let locale: String?
    }
}

public struct MBArtistDateStrategy: DateValueStrategy {
    public static var formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM"
        return formatter
    }()
    
    public static var dayFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    public static var yearFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy"
        return formatter
    }()
    
    public static func decode(_ value: String?) throws -> Date? {
        guard let value else {return nil}
        if let date = dayFormatter.date(from: value) {
            return date
        } else if let date = formatter.date(from: value) {
            return date
        } else if let date = yearFormatter.date(from: value) {
            return date
        }
        else {
            return nil
        }
    }
    
    public static func encode(_ date: Date?) -> String? {
        guard let date else {return nil}
        return formatter.string(from: date)
    }
}

public extension MBArtist {

    static var Nirvana: MBArtist {
        let json = """
        {
          "id": "5b11f4ce-a62d-471e-81fc-a69a8278c7da",
          "name": "Nirvana",
          "sort-name": "Nirvana",
          "type-id": "e431f5f6-b5d2-343d-8b36-72607fffb74b",
          "type": "Group",
          "disambiguation": "90s US grunge band",
          "gender": null,
          "gender-id": null,
          "country": "US",
          "area": {
            "disambiguation": "",
            "id": "489ce91b-6658-3307-9877-795b68554c98",
            "sort-name": "United States",
            "name": "United States",
            "iso-3166-1-codes": ["US"]
          },
          "begin-area": {
            "id": "a640b45c-c173-49b1-8030-973603e895b5",
            "disambiguation": "",
            "name": "Aberdeen",
            "sort-name": "Aberdeen"
          },
          "end-area": null,
          "life-span": {
            "ended": true,
            "begin": "1988-01",
            "end": "1994-04-05"
          },
          "isnis": ["0000000123486830", "0000000123487390"],
          "ipis": [ ],
          "aliases": [
            {
              "end": null,
              "begin": null,
              "sort-name": "Nirvana US",
              "name": "Nirvana US",
              "type-id": null,
              "primary": null,
              "locale": null,
              "type": null,
              "ended": false
            },
            {
              "primary": true,
              "type-id": "894afba6-2816-3c24-8072-eadb66bd04bc",
              "name": "ニルヴァーナ",
              "sort-name": "ニルヴァーナ",
              "begin": null,
              "end": null,
              "ended": false,
              "type": "Artist name",
              "locale": "ja"
            }
          ]
        }
        """.data(using: .utf8)!
        
        let decoder = JSONDecoder()
        return try! decoder.decode(MBArtist.self, from: json)

    }
}

