//
//  CharacterCollectionViewCell.swift
//  Ricky&Morty
//
//  Created by Ibrahim El-geddawy on 23/10/2024.
//

import UIKit
import SDWebImage

class CharacterCollectionViewCell: UICollectionViewCell {
    static let ID = "CharacterCollectionViewCell"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var characterImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var typeLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.cornerStylish(color: UIColor.lightGray.withAlphaComponent(0.3), borderWidth: 1.0, cornerRadius: 12)
        characterImageView.cornerStylish(color: UIColor.lightGray.withAlphaComponent(0.3), borderWidth: 1.0, cornerRadius: 12)
    }
    
    func bind(model: CharacterModel) {
        setupBackgroundColor(status: model.status)
        nameLabel.text = model.name
        typeLabel.text = model.species
        characterImageView.sd_setImage(with: URL(string: model.imageUrl), placeholderImage: nil)
    }
    
    private func setupBackgroundColor(status: CharacterStatus) {
        switch status {
        case .alive:
            containerView.backgroundColor = .systemMint.withAlphaComponent(0.1)
        case .dead:
            containerView.backgroundColor = .systemPink.withAlphaComponent(0.1)
        case .unknown:
            containerView.backgroundColor = .white
        }
    }
}

