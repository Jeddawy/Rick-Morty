//
//  CharacterRepository.swift
//  Rick&MortyiOS
//
//  Created by Ibrahim El-geddawy on 25/10/2024.
//

import Foundation


class CharacterRepository: CharacterRepositoryProtocol, CharacterRepositoryInjected {
    
    private let apiClient = URLSessionAPIClient<CharacterEndpoint>()
    
    func fetchCharacters(page: Int, status: CharacterStatus?) async throws -> (characters: [CharacterModel], hasNextPage: Bool) {
         let response: PaginatedResponse<CharacterResponse> = try await apiClient.request(.characters(page: page, status: status))
         
         let characters = response.results?.map { character in
             CharacterModel(
                 id: character.id ?? 0,
                 name: character.name ?? "",
                 status: CharacterStatus(rawValue: character.status ?? "Unknown") ?? .unknown,
                 species: character.species ?? "",
                 gender: character.gender ?? "",
                 imageUrl: character.image ?? "",
                 location: LocationModel(name: character.location?.name ?? "", url: character.location?.url ?? "")
             )
         }
         
         return (characters: characters ?? [], hasNextPage: response.info?.next != nil)
      }
    
}

// MARK: - Injection Map

protocol CharacterRepositoryInjected {}

extension CharacterRepositoryInjected {
    var characterRepo: CharacterRepositoryProtocol {
        CharacterRepositoryInjectionMap.repo
    }
}

/// Controlling the current allocated CharacterRepositoryProtocol
/// Default value is CharacterRepository
/// You can use this injection map as needed to change which manager is allocated
/// You can switch between different managers as needed
enum CharacterRepositoryInjectionMap {
    static private(set) var repo: CharacterRepositoryProtocol = defaultManager()
    
    static func changeManager(to manager: CharacterRepositoryProtocol) {
        repo = manager
    }
    
    static private func defaultManager() -> CharacterRepositoryProtocol {
        CharacterRepository()
    }
}

