//
//  CharacterRepositoryProtocol.swift
//  Ricky&Morty
//
//  Created by Ibrahim El-geddawy on 25/10/2024.
//

import Foundation

protocol CharacterRepositoryProtocol {
    func fetchCharacters(page: Int, status: CharacterStatus?) async throws -> (characters: [CharacterModel], hasNextPage: Bool)
}

