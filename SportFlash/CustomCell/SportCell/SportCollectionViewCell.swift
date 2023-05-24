//
//  SportCollectionViewCell.swift
//  SportFlash
//
//  Created by ahmed osama on 22/05/2023.
//

import UIKit

class SportCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var sportImage: UIImageView!
    @IBOutlet weak var sportName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderWidth = 2.0
        layer.borderColor = UIColor.green.cgColor
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = sportName.bounds
        
        let startColor = UIColor.clear.cgColor
        let endColor = UIColor.black.cgColor
        
        gradientLayer.colors = [startColor, endColor]

        gradientLayer.startPoint = CGPoint(x: 0.5, y: 0.3)
        gradientLayer.endPoint = CGPoint(x: 0.5, y: 1)
        sportName.layer.insertSublayer(gradientLayer, at: 0)

    }

}
