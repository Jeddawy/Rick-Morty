//
//  MockCharacterRepository.swift
//  Rick&MortyiOSTests
//
//  Created by Ibrahim El-geddawy on 28/10/2024.
//

import Foundation
@testable import Rick_MortyiOS

final class MockCharacterRepository: CharacterRepositoryProtocol {
        var mockResult: (characters: [CharacterModel], hasNextPage: Bool)?
        var mockError: Error?
        var receivedPage: Int?
        var receivedStatus: CharacterStatus?
        var fetchCharactersCallCount = 0
    
        func fetchCharacters(page: Int, status: CharacterStatus?) async throws -> (characters: [CharacterModel], hasNextPage: Bool) {
            fetchCharactersCallCount += 1
            receivedPage = page
            receivedStatus = status
    
            if let error = mockError {
                throw error
            }
    
            return mockResult ?? ([], false)
        }
    }

class MockFetchCharactersUseCase: FetchCharactersUseCaseProtocol, FetchCharactersUseCaseInjected {
    var mockResult: (characters: [CharacterModel], hasNextPage: Bool)?
    var mockError: Error?
    var executeCalled = false
    var receivedPage: Int?
    var receivedStatus: CharacterStatus?
    
    func execute(page: Int, status: CharacterStatus?) async throws -> (characters: [CharacterModel], hasNextPage: Bool) {
        executeCalled = true
        receivedPage = page
        receivedStatus = status
        
        if let error = mockError {
            throw error
        }
        
        return mockResult ?? ([], false)
    }
}
