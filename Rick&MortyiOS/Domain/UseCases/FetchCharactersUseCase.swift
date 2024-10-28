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

class FetchCharactersUseCase: FetchCharactersUseCaseProtocol, FetchCharactersUseCaseInjected {
    private let repository: CharacterRepositoryProtocol
    
    init(repository: CharacterRepositoryProtocol) {
        self.repository = repository
    }
    
    func execute(page: Int, status: CharacterStatus?) async throws -> (characters: [CharacterModel], hasNextPage: Bool) {
        return try await repository.fetchCharacters(page: page, status: status)
    }
}
// MARK: - Injection Map

protocol FetchCharactersUseCaseInjected {}

extension FetchCharactersUseCaseInjected {
    var fetchCharactersUseCase: FetchCharactersUseCaseProtocol {
        FetchCharactersUseCaseInjectionMap.useCase
    }
}

/// Controlling the current allocated FetchCharactersUseCaseProtocol
/// Default value is FetchCharactersUseCase
/// You can use this injection map as needed to change which manager is allocated
/// You can switch between different managers as needed
enum FetchCharactersUseCaseInjectionMap {
    static private(set) var useCase: FetchCharactersUseCaseProtocol = defaultManager()
    
    static func changeManager(to manager: FetchCharactersUseCaseProtocol) {
        useCase = manager
    }
    
    static private func defaultManager() -> FetchCharactersUseCaseProtocol {
        FetchCharactersUseCase(repository: CharacterRepository())
    }
}
