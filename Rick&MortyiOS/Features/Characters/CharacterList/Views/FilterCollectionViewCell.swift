//
//  FilterCollectionViewCell.swift
//  Ricky&Morty
//
//  Created by Ibrahim El-geddawy on 23/10/2024.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    static let ID = "FilterCollectionViewCell"
    
    @IBOutlet weak var filterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func bind(text: String){
        filterLabel.text = text
    }

}
