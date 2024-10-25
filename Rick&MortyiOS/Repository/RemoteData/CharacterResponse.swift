//
//  CharacterResponse.swift
//  Ricky&Morty
//
//  Created by Ibrahim El-geddawy on 24/10/2024.
//

import Foundation

struct CharacterResponse: Codable {
    let id: Int?
    let name: String?
    let status: String?
    let species: String?
    let gender: String?
    let image: String?
    let location: LocationResponse?
}

struct LocationResponse: Codable {
    let name: String?
    let url: String?
}

struct PaginatedResponse<T: Codable>: Codable {
    let info: PageInfoResponse?
    let results: [T]?
}

struct PageInfoResponse: Codable {
    let count: Int
    let pages: Int
    let next: String?
    let prev: String?
}
