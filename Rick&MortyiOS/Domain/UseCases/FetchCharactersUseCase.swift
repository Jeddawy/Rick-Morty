//
//  FetchCharactersUseCase.swift
//  Rick&MortyiOS
//
//  Created by Ibrahim El-geddawy on 25/10/2024.
//

import Foundation

protocol FetchCharactersUseCaseProtocol {
    func execute(page: Int, status: CharacterStatus?) async throws -> (characters: [CharacterModel], hasNextPage: Bool)
}

class FetchCharactersUseCase: FetchCharactersUseCaseProtocol {
    private let repository: CharacterRepositoryProtocol
    
    init(repository: CharacterRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(page: Int, status: CharacterStatus?) async throws -> (characters: [CharacterModel], hasNextPage: Bool) {
        return try await repository.fetchCharacters(page: page, status: status)
    }
}
