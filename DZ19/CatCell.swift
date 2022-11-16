//
//  CatCell.swift
//  DZ19
//
//  Created by Dmitriy on 11/16/22.
//

import UIKit

class CatCell: UICollectionViewCell {
    @IBOutlet weak var catImage: UIImageView!
    @IBOutlet weak var catLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        self.contentView.layer.borderWidth = 3
        self.contentView.layer.borderColor = UIColor.purple.cgColor
    }
    
    func update(with cat: Cat){
        self.catLabel.text = cat.name
        self.catImage.image = UIImage(named: cat.imageName)
    }
}
