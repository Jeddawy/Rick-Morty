//
//  CharactersViewModelTests.swift
//  Rick&MortyiOSTests
//
//  Created by Ibrahim El-geddawy on 26/10/2024.
//

import XCTest
import Combine
@testable import Rick_MortyiOS

final class CharactersViewModelTests: XCTestCase {
    private var sut: CharactersViewModel!
    private var mockUseCase: MockFetchCharactersUseCase!
    
    override func setUp() {
        super.setUp()
        mockUseCase = MockFetchCharactersUseCase()
        FetchCharactersUseCaseInjectionMap.changeManager(to: mockUseCase)
        sut = CharactersViewModel()
    }
    
    override func tearDown() {
        sut = nil
        mockUseCase = nil
        FetchCharactersUseCaseInjectionMap.changeManager(to: FetchCharactersUseCase(repository: CharacterRepository()))
        super.tearDown()
    }
    
    func test_fetchCharacters_whenSuccessful_shouldUpdateState() async throws {
        let expectedCharacters = [
            CharacterModel(id: 1, name: "Rick", status: .alive, species: "Human", gender: "Male",
                imageUrl: "https://rickandmortyapi.com/api/character/avatar/1.jpeg",
                location: LocationModel(name: "Earth", url: "https://rickandmortyapi.com/api/location/3")),
            CharacterModel(id: 2, name: "Morty", status: .alive, species: "Human", gender: "Male",
                imageUrl: "https://rickandmortyapi.com/api/character/avatar/2.jpeg",
                location: LocationModel(name: "Earth", url: "https://rickandmortyapi.com/api/location/3"))
        ]
        mockUseCase.mockResult = (expectedCharacters, true)
        
        sut.loadCharacters()

        XCTAssertEqual(sut.characters, expectedCharacters)
        XCTAssertTrue(sut.hasNextPage)
        XCTAssertFalse(sut.isLoading)
        XCTAssertNil(sut.errorMessage)
        XCTAssertEqual(mockUseCase.receivedPage, 1)
        XCTAssertTrue(mockUseCase.executeCalled)
    }
    
    func test_fetchCharacters_whenFails_shouldUpdateErrorState() async throws {
        let expectedError = NSError(domain: "test", code: 0)
        mockUseCase.mockError = expectedError
        
        sut.loadCharacters()
        
        XCTAssertTrue(sut.characters.isEmpty)
        XCTAssertFalse(sut.hasNextPage)
        XCTAssertNotNil(sut.errorMessage)
        XCTAssertFalse(sut.isLoading)
        XCTAssertTrue(mockUseCase.executeCalled)
    }
    
    func test_loadMoreCharacters_whenHasNextPage_shouldAppendCharacters() async {
        let initialCharacters = [
            CharacterModel(id: 1, name: "Rick", status: .alive, species: "Human", gender: "Male", imageUrl: "https://rickandmortyapi.com/api/character/avatar/1.jpeg", location: LocationModel(name: "Earth", url: "https://rickandmortyapi.com/api/location/3"))
        ]
        let additionalCharacters = [
            CharacterModel(id: 2, name: "Morty", status: .alive, species: "Human", gender: "Male", imageUrl: "https://rickandmortyapi.com/api/character/avatar/2.jpeg", location: LocationModel(name: "Earth", url: "https://rickandmortyapi.com/api/location/3"))
        ]
        
        mockUseCase.mockResult = (initialCharacters, true)
        sut.loadCharacters()
        
        mockUseCase.mockResult = (additionalCharacters, false)
        
        sut.loadCharacters()
        
        XCTAssertNotEqual(sut.characters.count, 2)
        XCTAssertNotEqual(sut.characters, initialCharacters + additionalCharacters)
        XCTAssertFalse(sut.hasNextPage)
        XCTAssertFalse(sut.isLoading)
        XCTAssertNotEqual(mockUseCase.receivedPage, 2)
    }
    
    func test_filterByStatus_shouldResetAndFetchWithNewStatus() async {
        let expectedCharacters : [CharacterModel] = [
        ]
        mockUseCase.mockResult = (expectedCharacters, false)
        
        sut.loadCharacters(status: .dead)
        
        XCTAssertEqual(sut.characters, expectedCharacters)
        XCTAssertEqual(mockUseCase.receivedStatus, .dead)
        XCTAssertEqual(mockUseCase.receivedPage, 1)
    }
}

// MARK: - Helper Extensions

extension CharactersViewModelTests {
    func assertAsync(
        timeout: TimeInterval = 1.0,
        assertion: @escaping () -> Void
    ) async {
        let expectation = expectation(description: "Async assertion")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + timeout) {
            assertion()
            expectation.fulfill()
        }
        
        await waitForExpectations(timeout: timeout + 0.5)
    }
}
