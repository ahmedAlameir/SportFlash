//
//  TeamViewController.swift
//  SportFlash
//
//  Created by ahmed osama on 29/05/2023.
//

import UIKit
import Kingfisher
class TeamViewController: UIViewController {
    var team:Team?
    
    @IBOutlet weak var playersTable: UITableView!
    @IBOutlet weak var teamName: UILabel!
    @IBOutlet weak var teamLogoImageView: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        teamName.text = team?.teamName
        if let teamLogo = team?.teamLogo{
            teamLogoImageView.kf.setImage(with: URL(string: teamLogo))

        }

        // Do any additional setup after loading the view.
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
