//
//  LeaguesTableViewController.swift
//  SportFlash
//
//  Created by ahmed osama on 22/05/2023.
//

import UIKit
import Kingfisher
private let reuseIdentifier = "LeaguesTableViewCell"

class LeaguesTableViewController: UITableViewController {
    private var viewModel: LeaguesViewModel!
    var sport:Sport!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        navigationItem.title = sport.path + " Leagues"

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        setupViewModel()
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func setupViewModel() {
        viewModel = LeaguesViewModel(sportsRepository: SportsRepositoryImpl(api: SportsAPI(), sportdb:  DatabaseManager.shared),sport: sport)
        
        viewModel.onDataUpdated = { [weak self] in
            self?.tableView.reloadData()
        }
        
        
        viewModel.fetchLeagues()
    }
  
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return viewModel.leagues.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LeaguesTableViewCell
        let league = viewModel.leagues[indexPath.row]
        cell.leagueName.text = league.leagueName
        if let leagueLogo =  league.leagueLogo{
            cell.leagueImage.kf.setImage(with:URL(string: leagueLogo)  ,placeholder: UIImage(named:sport.logo))
        }else{
            cell.leagueImage.image = UIImage(named: sport.logo)
        }
       
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let leaguesDetailsVC = storyboard?.instantiateViewController(withIdentifier: "LeaguesDetailsViewController") as! LeaguesDetailsViewController
        leaguesDetailsVC.sport = self.sport
        leaguesDetailsVC.leaguseID = Int(viewModel.leagues[indexPath.row].leagueKey)
        navigationController?.pushViewController(leaguesDetailsVC, animated: true)
    }
    
    
}
