//
//  CharacterDetailView.swift
//  Ricky&Morty
//
//  Created by Ibrahim El-geddawy on 23/10/2024.
//

import SwiftUI


struct CharacterDetailView: View {
    let character: CharacterModel
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                AsyncImage(url: URL(string: character.imageUrl)) { image in
                    image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                } placeholder: {
                    ProgressView()
                }
                
                VStack(alignment: .leading, spacing: 8) {
                    Text(character.name)
                        .font(.title)
                    
                    Text("Status: \(character.name)")
                    Text("Species: \(character.species)")
                }
                .padding()
            }
        }
        .navigationBarTitleDisplayMode(.inline)
    }
}


#Preview {
    CharacterDetailView(character: CharacterModel(id: 1, name: "Sayed", status: .alive, species: "Homan", gender: "Male", imageUrl: ""))
}
