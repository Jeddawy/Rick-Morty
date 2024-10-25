//
//  CharacterCollectionViewCell.swift
//  Ricky&Morty
//
//  Created by Ibrahim El-geddawy on 23/10/2024.
//

import UIKit

class CharacterCollectionViewCell: UICollectionViewCell {
    static let ID = "CharacterCollectionViewCell"
    
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bind(model: CharacterModel) {
        nameLabel.text = model.name
        typeLabel.text = model.species
    }
}

