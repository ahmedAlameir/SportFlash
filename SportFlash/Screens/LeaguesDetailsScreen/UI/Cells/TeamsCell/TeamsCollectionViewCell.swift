//
//  TeamsCollectionViewCell.swift
//  SportFlash
//
//  Created by ahmed osama on 25/05/2023.
//

import UIKit

class TeamsCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var teamsImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        teamsImage.layer.cornerRadius = teamsImage.frame.height/2
        teamsImage.layer.masksToBounds = true
    }

}
