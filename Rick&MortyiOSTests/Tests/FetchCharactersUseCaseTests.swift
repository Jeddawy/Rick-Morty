//
//  FetchCharactersUseCaseTests.swift
//  Rick&MortyiOSTests
//
//  Created by Ibrahim El-geddawy on 28/10/2024.
//

import XCTest
@testable import Rick_MortyiOS

final class FetchCharactersUseCaseTests: XCTestCase {
    private var sut: FetchCharactersUseCase!
    private var repository: MockCharacterRepository!
    
    override func setUp() {
        super.setUp()
        repository = MockCharacterRepository()
        sut = FetchCharactersUseCase(repository: repository)
    }
    
    override func tearDown() {
        sut = nil
        repository = nil
        super.tearDown()
    }
    
    func test_execute_whenSuccessful_shouldReturnCharactersAndHasNextPage() async throws {
        // Given
        let expectedCharacters = [
            CharacterModel(id: 1, name: "Rick", status: .alive, species: "Human", gender: "Male", imageUrl: "", location: LocationModel(name: "Earth", url: "")),
            CharacterModel(id: 2, name: "Morty", status: .alive, species: "Human", gender: "Male", imageUrl: "", location: LocationModel(name: "Earth", url: ""))
        ]
        let expectedHasNextPage = true
        repository.mockResult = (expectedCharacters, expectedHasNextPage)
        
        // When
        let result = try await sut.execute(page: 1, status: .alive)
        
        // Then
        XCTAssertEqual(result.characters, expectedCharacters)
        XCTAssertEqual(result.hasNextPage, expectedHasNextPage)
        XCTAssertEqual(repository.receivedPage, 1)
        XCTAssertEqual(repository.receivedStatus, .alive)
    }
    
    func test_execute_whenRepositoryFails_shouldPropagateError() async {
        // Given
        let expectedError = NSError(domain: "test", code: 0)
        repository.mockError = expectedError
        
        // When/Then
        do {
            _ = try await sut.execute(page: 1, status: nil)
            XCTFail("Expected error to be thrown")
        } catch {
            XCTAssertEqual(error as NSError, expectedError)
        }
    }
    
    func test_execute_withDifferentParameters_shouldPassThemToRepository() async throws {
        // Given
        repository.mockResult = ([], false)
        
        // When
        _ = try await sut.execute(page: 2, status: .dead)
        
        // Then
        XCTAssertEqual(repository.receivedPage, 2)
        XCTAssertEqual(repository.receivedStatus, .dead)
    }
}
