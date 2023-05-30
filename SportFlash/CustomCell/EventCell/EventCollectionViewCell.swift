//
//  EventCollectionViewCell.swift
//  SportFlash
//
//  Created by ahmed osama on 23/05/2023.
//

import UIKit

class EventCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var homeTeamLabal: UILabel!
    @IBOutlet weak var awayTeamLabel: UILabel!
    @IBOutlet weak var timeLablel: UILabel!
    @IBOutlet weak var homeTeamScore: UILabel!
    @IBOutlet weak var awayTeamScore: UILabel!
    @IBOutlet weak var homeTeamImage: UIImageView!
    @IBOutlet weak var awayTeamImage: UIImageView!
    @IBOutlet weak var eventDate: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        layer.cornerRadius = 8
        layer.masksToBounds = true
        layer.borderWidth = 1
        layer.borderColor = UIColor.green.cgColor
        // Initialization code
    }
    func hideScore() {
        homeTeamScore.isHidden = true
        awayTeamScore.isHidden = true
    }
    func configure(with event: Event,sport:Sport) {
        switch sport{
        case .tennis:
            homeTeamLabal.text = event.eventFirstPlayer
            awayTeamLabel.text = event.eventSecondPlayer
            if let homeTeamLogo = event.eventFirstPlayerLogo {
                homeTeamImage.kf.setImage(with: URL(string: homeTeamLogo))
            } else {
                homeTeamImage.image = UIImage(named: sport.logo)
            }
            
            if let awayTeamLogo = event.eventSecondPlayerLogo {
                awayTeamImage.kf.setImage(with: URL(string: awayTeamLogo))
            } else {
                awayTeamImage.image = UIImage(named: sport.logo)
            }

        default:
            homeTeamLabal.text = event.eventHomeTeam
            awayTeamLabel.text = event.eventAwayTeam
            if let homeTeamLogo = event.homeTeamLogo {
                homeTeamImage.kf.setImage(with: URL(string: homeTeamLogo))
            } else {
                homeTeamImage.image = UIImage(named: sport.logo)
            }
            
            if let awayTeamLogo = event.awayTeamLogo {
                awayTeamImage.kf.setImage(with: URL(string: awayTeamLogo))
            } else {
                awayTeamImage.image = UIImage(named: sport.logo)
            }
        }
        timeLablel.text = event.eventDate
       
         
         
     }
}
