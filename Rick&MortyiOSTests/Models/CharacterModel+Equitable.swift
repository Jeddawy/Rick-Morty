//
//  CharacterModel+Equitable.swift
//  Rick&MortyiOSTests
//
//  Created by Ibrahim El-geddawy on 28/10/2024.
//

import Foundation
@testable import Rick_MortyiOS

extension CharacterModel: Equatable {
    public static func == (lhs: CharacterModel, rhs: CharacterModel) -> Bool {
        return lhs.id == rhs.id && lhs.name == rhs.name &&
        lhs.species == rhs.species && lhs.status == rhs.status &&
        lhs.imageUrl == rhs.imageUrl && lhs.gender == rhs.gender &&
        lhs.location == rhs.location
    }
}

extension LocationModel: Equatable {
    public static func == (lhs: LocationModel, rhs: LocationModel) -> Bool {
        return lhs.name == rhs.name && lhs.url == rhs.url
    }
}
extension CharacterStatus {
    init?(rawValue: String?) {
        guard let rawValue = rawValue else { return nil }
        switch rawValue {
        case "Alive": self = .alive
        case "Dead": self = .dead
        case "Unknown": self = .unknown
        default: return nil
        }
    }
}
