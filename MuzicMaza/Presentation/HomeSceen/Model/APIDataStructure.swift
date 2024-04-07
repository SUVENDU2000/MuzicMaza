//
//  APIDataStructure.swift
//  MuzicMaza
//
//  Created by Suvendu Kumar on 06/04/24.
//

import Foundation

struct AllSongsData: Codable {
    let data: [NameAndCover]
}

struct NameAndCover: Codable {
    let id: Int
    let status: Status
    let name, artist, accent, cover: String
    let topTrack: Bool
    let url: String

    enum CodingKeys: String, CodingKey {
        case id, status
        case name, artist, accent, cover
        case topTrack = "top_track"
        case url
    }
}

enum Status: String, Codable {
    case published = "published"
}


