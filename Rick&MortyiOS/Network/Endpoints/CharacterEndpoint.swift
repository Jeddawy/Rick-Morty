//
//  CharacterEndpoint.swift
//  Ricky&Morty
//
//  Created by Ibrahim El-geddawy on 24/10/2024.
//

import Foundation

enum CharacterEndpoint: APIEndpoint {
    
    case characters(page: Int, status: CharacterStatus?)
    case character(id: Int)
    
    var baseURL: URL {
        URL(string: "https://rickandmortyapi.com")!
    }
    
    var path: String {
        switch self {
        case .characters:
            return "/api/character"
        case .character(let id):
            return "/api/character/\(id)"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .character, .characters:
            return .get
        }
    }
    
    var headers: [String: String]? {
        switch self {
        default:
            return ["Content-Type": "application/json"]
        }
    }
    
    var parameters: [String: Any?]? {
        switch self {
        case .characters(page: let page, status: let characterStatus):
            var items : [String: Any] = ["page" : page]
            if characterStatus != nil {
                items["status"] = characterStatus?.rawValue.lowercased()
            }
            return items
        default:
            return nil
        }
    }
}
