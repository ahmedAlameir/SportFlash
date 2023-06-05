//
//  LeaguesTableViewCell.swift
//  SportFlash
//
//  Created by ahmed osama on 22/05/2023.
//

import UIKit
import Kingfisher
class LeaguesTableViewCell: UITableViewCell {

    @IBOutlet weak var leagueImage: UIImageView!
    @IBOutlet weak var leagueName: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        leagueImage.layer.cornerRadius = 40.0
        leagueImage.layer.masksToBounds = true
    }
    func configureCell( with league: League , for sport:Sport) {
        self.leagueName.text = league.leagueName
        if let leagueLogo = league.leagueLogo {
            self.leagueImage.kf.setImage(with: URL(string: leagueLogo), placeholder: UIImage(named: sport.logo))
        } else {
            self.leagueImage.image = UIImage(named: sport.logo)
        }
    }
    func configureCell( with team: Team ) {
        self.leagueName.text = team.teamName
        if let leagueLogo = team.teamLogo {
            self.leagueImage.kf.setImage(with: URL(string: leagueLogo), placeholder: UIImage(named: "basketBall_logo"))
        } else {
            self.leagueImage.image = UIImage(named: "basketBall_logo")
        }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
