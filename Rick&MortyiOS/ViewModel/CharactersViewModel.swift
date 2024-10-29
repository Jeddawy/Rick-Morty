//
//  CharactersViewModel.swift
//  Rick&MortyiOS
//
//  Created by Ibrahim El-geddawy on 25/10/2024.
//

import Foundation
import Combine

class CharactersViewModel: ObservableObject, FetchCharactersUseCaseInjected {
    //MARK: - Publishers
    
    @Published var characters: [CharacterModel] = []
    @Published var hasNextPage: Bool = false
    @Published var isLoading: Bool = false
    @Published var errorMessage: String?
    @Published var filterStatus: [String] = ["All", "Alive", "Dead", "Unknown"]
    @Published var selectedStatus: CharacterStatus?

    //MARK: Private Properties
    
    private var cancellables = Set<AnyCancellable>()
    private var currentPage = 1
    private var currentStatus: CharacterStatus?
    
    func loadCharacters(status: CharacterStatus? = nil) {
        currentPage = 1
        currentStatus = status
        fetchCharacters(page: currentPage, status: currentStatus)
    }

    func loadMoreIfNeeded(currentItem: CharacterModel) {
        guard !isLoading && hasNextPage && currentItem.id == characters.last?.id else { return }
        currentPage += 1
        fetchCharacters(page: currentPage, status: currentStatus)
    }

    func filterCharacters(at index: Int) {
        selectedStatus = CharacterStatus(rawValue: filterStatus[index])
        characters = []
        currentPage = 1
        hasNextPage = true
        Task {
            loadCharacters(status: selectedStatus)
        }
    }
    
    private func fetchCharacters(page: Int, status: CharacterStatus?) {
        isLoading = true
        Task {
            do {
                let (characters, hasNext) = try await fetchCharactersUseCase.execute(page: page, status: status)
                    if page == 1 {
                        self.characters = characters
                    } else {
                        self.characters.append(contentsOf: characters)
                    }
                    self.hasNextPage = hasNext
                    self.isLoading = false
                }
             catch {
                    self.errorMessage = "Failed to load characters"
                    self.isLoading = false
            }
        }
    }
}
