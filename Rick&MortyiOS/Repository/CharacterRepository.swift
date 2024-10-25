//
//  CharacterRepository.swift
//  Rick&MortyiOS
//
//  Created by Ibrahim El-geddawy on 25/10/2024.
//

import Foundation


class CharacterRepository: CharacterRepositoryProtocol {
    
    private let apiClient = URLSessionAPIClient<CharacterEndpoint>()
    
    func fetchCharacters(page: Int, status: CharacterStatus?) async throws -> (characters: [CharacterModel], hasNextPage: Bool) {
         let response: PaginatedResponse<CharacterResponse> = try await apiClient.request(.characters(page: page, status: status))
         
         let characters = response.results?.map { dto in
             CharacterModel(
                 id: dto.id ?? 0,
                 name: dto.name ?? "",
                 status: CharacterStatus(rawValue: dto.status ?? "Unknown") ?? .unknown,
                 species: dto.species ?? "",
                 gender: dto.gender ?? "",
                 imageUrl: dto.image ?? ""
             )
         }
         
         return (characters: characters ?? [], hasNextPage: response.info?.next != nil)
      }
    
}
