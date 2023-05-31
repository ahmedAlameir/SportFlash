//
//  TeamViewController.swift
//  SportFlash
//
//  Created by ahmed osama on 29/05/2023.
//

import UIKit
import Kingfisher
class TeamViewController: UIViewController {
    var team:Team!
    var teamViewModel:TeamViewModel!

    @IBOutlet weak var playersTable: UITableView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamLogoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        teamViewModel = TeamViewModel(databaseManager: DatabaseManager.shared)
        teamName.text = team?.teamName
        if let teamLogo = team?.teamLogo{
            teamLogoImageView.kf.setImage(with: URL(string: teamLogo))
            customizeNavigationItem()

        }

        // Do any additional setup after loading the view.
    }
    func customizeNavigationItem() {
        let teamId = team.teamKey
        // Check if the team exists in the database
        let teamExists = teamViewModel.teamExists(teamId: teamId)
        
        // Create an empty heart and filled heart image
        let emptyHeartImage = UIImage(named: "emptyHeartIcon")
        let filledHeartImage = UIImage(named: "filledHeartIcon")
        
        // Create a UIButton with the appropriate heart image
        let heartButton = UIButton(type: .custom)
        heartButton.setImage(teamExists ? filledHeartImage : emptyHeartImage, for: .normal)
        heartButton.addTarget(self, action: #selector(heartButtonTapped(isTeamExists:)), for: .touchUpInside)
        heartButton.sizeToFit()
        
        // Create a UIBarButtonItem with the heart button as a custom view
        let heartBarButtonItem = UIBarButtonItem(customView: heartButton)
        
        // Set the heart button as the right bar button item
        navigationItem.rightBarButtonItem = heartBarButtonItem
    }
    
    @objc func heartButtonTapped(isTeamExists: Bool) {
        if isTeamExists {
            teamViewModel.deleteTeam(teamId: team.teamKey)
            
        }else{
            teamViewModel.insertTeam(team: team)

        }
        customizeNavigationItem()
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
extension TeamViewController:UITableViewDelegate,UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
     return team?.players?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PlayerCell", for: indexPath)
        if let playerImage = team?.players?[indexPath.row].playerImage {
            cell.imageView?.kf.setImage(with: URL(string: playerImage))

        }
        if let playerName = team?.players?[indexPath.row].playerName {
            cell.textLabel?.text = playerName

        }
        return cell
    }
    
    
}
