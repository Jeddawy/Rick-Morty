//
//  FilterCollectionViewCell.swift
//  Ricky&Morty
//
//  Created by Ibrahim El-geddawy on 23/10/2024.
//

import UIKit

class FilterCollectionViewCell: UICollectionViewCell {
    static let ID = "FilterCollectionViewCell"
    
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var filterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        containerView.cornerStylish(color: UIColor.lightGray.withAlphaComponent(0.3), borderWidth: 1.0, cornerRadius: 10)
    }
    
    func bind(text: String){
        filterLabel.text = text
    }

}
