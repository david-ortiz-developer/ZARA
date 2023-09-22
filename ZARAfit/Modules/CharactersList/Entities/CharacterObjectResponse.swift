//
//  CharacterObject.swift
//  ZARAfit
//
//  Created by Davit on 22/09/23.
//

import Foundation
struct CharacterObjectResponse: Decodable {
    var info: InformationObject
    var results: [CharacterObject]
}
struct InformationObject: Decodable {
    var count: Int
    var pages: Int
    var next: String?
    var prev: String?
}
struct CharacterObject: Decodable {
    var id: Int
    var name: String
    var status: String
    var species: String
    var type: String
    var gender: String
    var origin: CharacterOriginObject
    var location: CharacterLocationObject
    var image: String
    var episode: [String]
    var url: String
    var created: String
}
struct CharacterOriginObject: Decodable {
    var name: String
    var url: String
}
struct CharacterLocationObject: Decodable {
    var name: String
    var url: String
}
