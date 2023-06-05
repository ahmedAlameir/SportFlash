//
//  LeaguesViewController.swift
//  SportFlash
//
//  Created by ahmed osama on 01/06/2023.
//

import UIKit
private let reuseIdentifier = "LeaguesTableViewCell"

class LeaguesViewController: UIViewController {
    @IBOutlet weak var leaguesTableView: UITableView!
    private var viewModel: LeaguesViewModel!
    
    var sport: Sport!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
        setupViewModel()
    }
    
    private func setupUI() {
        leaguesTableView.register(UINib(nibName: "LeaguesTableViewCell", bundle: nil), forCellReuseIdentifier: reuseIdentifier)
        navigationItem.title = sport.path + " Leagues"
    }
    
    private func setupViewModel() {
        let sportsRepository = SportsRepositoryImpl(api: SportsAPI(), sportdb: DatabaseManager.shared)
        viewModel = LeaguesViewModel(sportsRepository: sportsRepository, sport: sport)
        
        viewModel.onDataUpdated = { [weak self] in
            self?.leaguesTableView.reloadData()
        }
        
        viewModel.onFetchError = { error in
            // Handle the fetch error
            print("Error: \(error)")
        }
        
        viewModel.fetchLeagues()
    }
}

extension LeaguesViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let selectedLeague = viewModel.league(at: indexPath.row) else {
            // Handle the case when league is nil
            print("League is nil")
            return
        }
        
        let leaguesDetailsVC = storyboard?.instantiateViewController(withIdentifier: "LeaguesDetailsViewController") as! LeaguesDetailsViewController
        leaguesDetailsVC.sport = sport
        leaguesDetailsVC.leagueID = Int(selectedLeague.leagueKey)
        navigationController?.pushViewController(leaguesDetailsVC, animated: true)
    }
}

extension LeaguesViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.numberOfLeagues()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as! LeaguesTableViewCell
        
        guard let league = viewModel.league(at: indexPath.row) else {
            // Handle the case when league is nil
            print("League is nil")
            return UITableViewCell()
        }
        
        cell.configureCell(with: league, for: sport)
        return cell
    }
}

extension LeaguesViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.filterLeagues(with: searchText)
    }
}
