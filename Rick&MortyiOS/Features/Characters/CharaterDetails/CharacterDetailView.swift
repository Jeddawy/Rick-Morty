//
//  CharacterDetailView.swift
//  Ricky&Morty
//
//  Created by Ibrahim El-geddawy on 23/10/2024.
//

import SwiftUI

struct CharacterDetailView: View {
    let character: CharacterModel
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            imageCharacter
            charachterDetails
                .padding(.top, 10)
            Spacer()
        }
        .navigationBarBackButtonHidden(true)
        .toolbar {
            ToolbarItem(placement: .navigationBarLeading) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss()
                }) {
                    ZStack {
                        Circle()
                            .fill(Color.white)
                            .frame(width: 40, height: 40)
                            .shadow(radius: 3)
                        
                        Image(systemName: "arrow.left")
                            .foregroundColor(.black)
                            .font(.system(size: 18, weight: .bold))
                    }
                }
            }
        }
        .onAppear {
            let appearance = UINavigationBarAppearance()
            appearance.configureWithTransparentBackground()
            appearance.backgroundColor = .clear
            UINavigationBar.appearance().standardAppearance = appearance
            UINavigationBar.appearance().scrollEdgeAppearance = appearance
        }
        .ignoresSafeArea(edges: .top)
    }
    
    struct RoundedStatusView: View {
        let status: String
        
        var body: some View {
            Text(status)
                .font(.system(size: 18, weight: .medium))
                .foregroundColor(.black)
                .padding(.horizontal, 16)
                .padding(.vertical, 8)
                .background(Color.cyan)
                .clipShape(Capsule())
        }
    }
    
    var imageCharacter: some View {
        AsyncImage(url:URL(string: character.imageUrl)) { phase in
            if let image = phase.image {
                image
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
            } else if phase.error != nil {
                Image(systemName: "person.fill")
                    .resizable()
                    .scaledToFill()
                    .frame(height: 300)
            } else {
                ProgressView()
                    .frame(height: 300)
            }
        }
        .cornerRadius(20)
    }
    
    var charachterDetails: some View {
        VStack(alignment: .leading, spacing: 20) {
            HStack(alignment: .top) {
                VStack(alignment: .leading){
                    Text(character.name)
                        .bold()
                    HStack{
                        Text(character.species)
                        Text("•")
                        Text(character.gender)
                            .foregroundStyle(.gray)
                    }
                }
                Spacer()
                RoundedStatusView(status: character.status.rawValue)
            }
            
            HStack{
                Text("Location:")
                    .bold()
                Text(character.location.name)
                    .foregroundStyle(.gray)
            }
        }
        .padding(.horizontal)
    }
}

#Preview {
    CharacterDetailView(character: CharacterModel(id: 1, name: "Sayed", status: .alive, species: "Homan", gender: "Male", imageUrl: "", location: LocationModel(name: "earth", url: "")))
}
