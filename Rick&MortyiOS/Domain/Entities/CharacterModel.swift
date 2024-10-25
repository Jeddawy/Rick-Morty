//
//  Charater.swift
//  Ricky&Morty
//
//  Created by Ibrahim El-geddawy on 24/10/2024.
//

import Foundation

struct CharacterModel {
    let id: Int
    let name: String
    let status: CharacterStatus
    let species: String
    let gender: String
    let imageUrl: String
    let location: LocationModel
}

struct LocationModel {
    var name: String
    var url: String
}

enum CharacterStatus: String {
    case alive = "Alive"
    case dead = "Dead"
    case unknown = "Unknown"
}
