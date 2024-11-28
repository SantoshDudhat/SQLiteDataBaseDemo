//
//  GetAnimeListResponse.swift
//  DemoSQLiteDatabase
//
//  Created by DREAMWORLD on 22/11/24.
//

import Foundation

struct Anime {
    var malid: Int = 0
    
    init(malid: Int) {
        self.malid = malid
    }
}

// MARK: - GetAnimeListResponse
struct GetAnimeListResponse: Codable {
    var pagination: Pagination?
    var data: [Datum]?

    enum CodingKeys: String, CodingKey {
        case pagination = "pagination"
        case data = "data"
    }
}

// MARK: - Datum
struct Datum: Codable {
    var malid: Int?
    var url: String?
    var images: DatumImages?
    var trailer: Trailer?
    var approved: Bool?
    var titles: [Title]?
    var title: String?
    var titleEnglish: String?
    var titleJapanese: String?
    var titleSynonyms: [JSONAny]?
    var type: String?
    var source: String?
    var episodes: Int?
    var status: String?
    var airing: Bool?
    var aired: Aired?
    var duration: String?
    var rating: String?
    var score: Double?
    var scoredBy: Int?
    var rank: Int?
    var popularity: Int?
    var members: Int?
    var favorites: Int?
    var synopsis: String?
    var background: String?
    var season: String?
    var year: Int?
    var broadcast: Broadcast?
    var producers: [Genre]?
    var licensors: [Genre]?
    var studios: [Genre]?
    var genres: [Genre]?
    var explicitGenres: [JSONAny]?
    var themes: [Genre]?
    var demographics: [JSONAny]?
    var isFavourited: Bool = false

    enum CodingKeys: String, CodingKey {
        case malid = "mal_id"
        case url = "url"
        case images = "images"
        case trailer = "trailer"
        case approved = "approved"
        case titles = "titles"
        case title = "title"
        case titleEnglish = "title_english"
        case titleJapanese = "title_japanese"
        case titleSynonyms = "title_synonyms"
        case type = "type"
        case source = "source"
        case episodes = "episodes"
        case status = "status"
        case airing = "airing"
        case aired = "aired"
        case duration = "duration"
        case rating = "rating"
        case score = "score"
        case scoredBy = "scored_by"
        case rank = "rank"
        case popularity = "popularity"
        case members = "members"
        case favorites = "favorites"
        case synopsis = "synopsis"
        case background = "background"
        case season = "season"
        case year = "year"
        case broadcast = "broadcast"
        case producers = "producers"
        case licensors = "licensors"
        case studios = "studios"
        case genres = "genres"
        case explicitGenres = "explicit_genres"
        case themes = "themes"
        case demographics = "demographics"
    }
}

// MARK: - Aired
struct Aired: Codable {
    var from: String?
    var to: String?
    var prop: Prop?
    var string: String?

    enum CodingKeys: String, CodingKey {
        case from = "from"
        case to = "to"
        case prop = "prop"
        case string = "string"
    }
}

// MARK: - Prop
struct Prop: Codable {
    var from: From?
    var to: From?

    enum CodingKeys: String, CodingKey {
        case from = "from"
        case to = "to"
    }
}

// MARK: - From
struct From: Codable {
    var day: Int?
    var month: Int?
    var year: Int?

    enum CodingKeys: String, CodingKey {
        case day = "day"
        case month = "month"
        case year = "year"
    }
}

// MARK: - Broadcast
struct Broadcast: Codable {
    var day: String?
    var time: String?
    var timezone: String?
    var string: String?

    enum CodingKeys: String, CodingKey {
        case day = "day"
        case time = "time"
        case timezone = "timezone"
        case string = "string"
    }
}

// MARK: - Genre
struct Genre: Codable {
    var malid: Int?
    var type: String?
    var name: String?
    var url: String?

    enum CodingKeys: String, CodingKey {
        case malid = "mal_id"
        case type = "type"
        case name = "name"
        case url = "url"
    }
}

// MARK: - DatumImages
struct DatumImages: Codable {
    var jpg: Jpg?
    var webp: Jpg?

    enum CodingKeys: String, CodingKey {
        case jpg = "jpg"
        case webp = "webp"
    }
}

// MARK: - Jpg
struct Jpg: Codable {
    var imageurl: String?
    var smallImageurl: String?
    var largeImageurl: String?

    enum CodingKeys: String, CodingKey {
        case imageurl = "image_url"
        case smallImageurl = "small_image_url"
        case largeImageurl = "large_image_url"
    }
}

// MARK: - Title
struct Title: Codable {
    var type: String?
    var title: String?

    enum CodingKeys: String, CodingKey {
        case type = "type"
        case title = "title"
    }
}

// MARK: - Trailer
struct Trailer: Codable {
    var youtubeid: String?
    var url: String?
    var embedurl: String?
    var images: TrailerImages?

    enum CodingKeys: String, CodingKey {
        case youtubeid = "youtube_id"
        case url = "url"
        case embedurl = "embed_url"
        case images = "images"
    }
}

// MARK: - TrailerImages
struct TrailerImages: Codable {
    var imageurl: String?
    var smallImageurl: String?
    var mediumImageurl: String?
    var largeImageurl: String?
    var maximumImageurl: String?

    enum CodingKeys: String, CodingKey {
        case imageurl = "image_url"
        case smallImageurl = "small_image_url"
        case mediumImageurl = "medium_image_url"
        case largeImageurl = "large_image_url"
        case maximumImageurl = "maximum_image_url"
    }
}

// MARK: - Pagination
struct Pagination: Codable {
    var lastVisiblePage: Int?
    var hasNextPage: Bool?
    var currentPage: Int?
    var items: Items?

    enum CodingKeys: String, CodingKey {
        case lastVisiblePage = "last_visible_page"
        case hasNextPage = "has_next_page"
        case currentPage = "current_page"
        case items = "items"
    }
}

// MARK: - Items
struct Items: Codable {
    var count: Int?
    var total: Int?
    var perPage: Int?

    enum CodingKeys: String, CodingKey {
        case count = "count"
        case total = "total"
        case perPage = "per_page"
    }
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {

    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
            return true
    }

    public var hashValue: Int {
            return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
            let container = try decoder.singleValueContainer()
            if !container.decodeNil() {
                    throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
            }
    }

    public func encode(to encoder: Encoder) throws {
            var container = encoder.singleValueContainer()
            try container.encodeNil()
    }
}

class JSONCodingKey: CodingKey {
    let key: String

    required init?(intValue: Int) {
            return nil
    }

    required init?(stringValue: String) {
            key = stringValue
    }

    var intValue: Int? {
            return nil
    }

    var stringValue: String {
            return key
    }
}

class JSONAny: Codable {

    let value: Any

    static func decodingError(forCodingPath codingPath: [CodingKey]) -> DecodingError {
            let context = DecodingError.Context(codingPath: codingPath, debugDescription: "Cannot decode JSONAny")
            return DecodingError.typeMismatch(JSONAny.self, context)
    }

    static func encodingError(forValue value: Any, codingPath: [CodingKey]) -> EncodingError {
            let context = EncodingError.Context(codingPath: codingPath, debugDescription: "Cannot encode JSONAny")
            return EncodingError.invalidValue(value, context)
    }

    static func decode(from container: SingleValueDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if container.decodeNil() {
                    return JSONNull()
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout UnkeyedDecodingContainer) throws -> Any {
            if let value = try? container.decode(Bool.self) {
                    return value
            }
            if let value = try? container.decode(Int64.self) {
                    return value
            }
            if let value = try? container.decode(Double.self) {
                    return value
            }
            if let value = try? container.decode(String.self) {
                    return value
            }
            if let value = try? container.decodeNil() {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer() {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decode(from container: inout KeyedDecodingContainer<JSONCodingKey>, forKey key: JSONCodingKey) throws -> Any {
            if let value = try? container.decode(Bool.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Int64.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(Double.self, forKey: key) {
                    return value
            }
            if let value = try? container.decode(String.self, forKey: key) {
                    return value
            }
            if let value = try? container.decodeNil(forKey: key) {
                    if value {
                            return JSONNull()
                    }
            }
            if var container = try? container.nestedUnkeyedContainer(forKey: key) {
                    return try decodeArray(from: &container)
            }
            if var container = try? container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key) {
                    return try decodeDictionary(from: &container)
            }
            throw decodingError(forCodingPath: container.codingPath)
    }

    static func decodeArray(from container: inout UnkeyedDecodingContainer) throws -> [Any] {
            var arr: [Any] = []
            while !container.isAtEnd {
                    let value = try decode(from: &container)
                    arr.append(value)
            }
            return arr
    }

    static func decodeDictionary(from container: inout KeyedDecodingContainer<JSONCodingKey>) throws -> [String: Any] {
            var dict = [String: Any]()
            for key in container.allKeys {
                    let value = try decode(from: &container, forKey: key)
                    dict[key.stringValue] = value
            }
            return dict
    }

    static func encode(to container: inout UnkeyedEncodingContainer, array: [Any]) throws {
            for value in array {
                    if let value = value as? Bool {
                            try container.encode(value)
                    } else if let value = value as? Int64 {
                            try container.encode(value)
                    } else if let value = value as? Double {
                            try container.encode(value)
                    } else if let value = value as? String {
                            try container.encode(value)
                    } else if value is JSONNull {
                            try container.encodeNil()
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer()
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout KeyedEncodingContainer<JSONCodingKey>, dictionary: [String: Any]) throws {
            for (key, value) in dictionary {
                    let key = JSONCodingKey(stringValue: key)!
                    if let value = value as? Bool {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Int64 {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? Double {
                            try container.encode(value, forKey: key)
                    } else if let value = value as? String {
                            try container.encode(value, forKey: key)
                    } else if value is JSONNull {
                            try container.encodeNil(forKey: key)
                    } else if let value = value as? [Any] {
                            var container = container.nestedUnkeyedContainer(forKey: key)
                            try encode(to: &container, array: value)
                    } else if let value = value as? [String: Any] {
                            var container = container.nestedContainer(keyedBy: JSONCodingKey.self, forKey: key)
                            try encode(to: &container, dictionary: value)
                    } else {
                            throw encodingError(forValue: value, codingPath: container.codingPath)
                    }
            }
    }

    static func encode(to container: inout SingleValueEncodingContainer, value: Any) throws {
            if let value = value as? Bool {
                    try container.encode(value)
            } else if let value = value as? Int64 {
                    try container.encode(value)
            } else if let value = value as? Double {
                    try container.encode(value)
            } else if let value = value as? String {
                    try container.encode(value)
            } else if value is JSONNull {
                    try container.encodeNil()
            } else {
                    throw encodingError(forValue: value, codingPath: container.codingPath)
            }
    }

    public required init(from decoder: Decoder) throws {
            if var arrayContainer = try? decoder.unkeyedContainer() {
                    self.value = try JSONAny.decodeArray(from: &arrayContainer)
            } else if var container = try? decoder.container(keyedBy: JSONCodingKey.self) {
                    self.value = try JSONAny.decodeDictionary(from: &container)
            } else {
                    let container = try decoder.singleValueContainer()
                    self.value = try JSONAny.decode(from: container)
            }
    }

    public func encode(to encoder: Encoder) throws {
            if let arr = self.value as? [Any] {
                    var container = encoder.unkeyedContainer()
                    try JSONAny.encode(to: &container, array: arr)
            } else if let dict = self.value as? [String: Any] {
                    var container = encoder.container(keyedBy: JSONCodingKey.self)
                    try JSONAny.encode(to: &container, dictionary: dict)
            } else {
                    var container = encoder.singleValueContainer()
                    try JSONAny.encode(to: &container, value: self.value)
            }
    }
}

