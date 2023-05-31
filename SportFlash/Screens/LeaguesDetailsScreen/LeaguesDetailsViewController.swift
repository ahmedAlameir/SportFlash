//
//  LeaguesDetailsViewController.swift
//  SportFlash
//
//  Created by ahmed osama on 24/05/2023.
//

import UIKit
import Kingfisher

private let evenCellReuseIdentifier = "EventCollectionViewCell"
private let teamReuseIdentifier = "TeamCollectionViewCell"

class LeaguesDetailsViewController: UIViewController {
    private var viewModel:LeaguesDetailsViewModel!
    var leaguseID:Int!
    var sport:Sport!

    
    
    @IBOutlet weak var upComingEventCollectionView: UICollectionView!
    @IBOutlet weak var latestEventCollectionView: UICollectionView!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel = LeaguesDetailsViewModel(sportsRepository: SportsRepositoryImpl(api: SportsAPI(),sportdb: DatabaseManager.shared),leagueId: leaguseID ,sport: sport)
        viewModel.upComingEventsUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.upComingEventCollectionView.reloadData()
            }
        }
        viewModel.latestEventsUpdated = { [weak self] in
            DispatchQueue.main.async {
            self?.latestEventCollectionView.reloadData()
            }
        }
        viewModel.teamsUpdated = { [weak self] in
            DispatchQueue.main.async {
            self?.teamsCollectionView.reloadData()
            }
        }
        
        upComingEventCollectionView.register(UINib(nibName: "EventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: evenCellReuseIdentifier)
        upComingEventCollectionView.setCollectionViewLayout(UICollectionViewCompositionalLayout(section: upComingEventSection()), animated: true)
        latestEventCollectionView.register(UINib(nibName: "EventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: evenCellReuseIdentifier)
        let latestEventlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        latestEventlayout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        latestEventlayout.itemSize = CGSize(width: self.view.frame.width-40, height: 150)
        
        latestEventCollectionView.collectionViewLayout = latestEventlayout
        teamsCollectionView.register(UINib(nibName: "TeamsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: teamReuseIdentifier)
        let teamsEventlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        teamsEventlayout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        teamsEventlayout.itemSize = CGSize(width: self.view.frame.width/3, height:  self.view.frame.width/3)
        teamsEventlayout.scrollDirection = .horizontal
        teamsCollectionView.collectionViewLayout = teamsEventlayout
        
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
extension LeaguesDetailsViewController : UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        switch collectionView{
        case upComingEventCollectionView:
            return viewModel.upComingEvents.count
        case latestEventCollectionView:
            return viewModel.latestEvents.count
        case teamsCollectionView:
            return viewModel.teams.count
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
        case upComingEventCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: evenCellReuseIdentifier, for: indexPath) as! EventCollectionViewCell
            cell.hideScore()
            cell.configure(with: viewModel.upComingEvents[indexPath.row], sport: sport)
            
            return cell
        case latestEventCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: evenCellReuseIdentifier, for: indexPath) as! EventCollectionViewCell
            cell.configure(with: viewModel.latestEvents[indexPath.row], sport: sport)
                
            return cell
        case teamsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamReuseIdentifier, for: indexPath) as! TeamsCollectionViewCell
            if let teamLogo =  viewModel.teams[indexPath.row].teamLogo {
                cell.teamsImage.kf.setImage(with:URL(string:teamLogo))
            }else{
                cell.teamsImage.image = UIImage(named: sport.logo)
            }
            return cell
        default:
            return  UICollectionViewCell()
        }
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        
        if collectionView == teamsCollectionView {
            let teamVC = storyboard?.instantiateViewController(withIdentifier: "TeamViewController") as! TeamViewController
            teamVC.team = viewModel.teams[indexPath.row]
            navigationController?.pushViewController(teamVC, animated: true)
        }
        
    }
    func upComingEventSection()-> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .fractionalHeight(1))
        let item = NSCollectionLayoutItem(layoutSize: itemSize)
        
        let groupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(0.9), heightDimension: .fractionalHeight(0.9))
        let group = NSCollectionLayoutGroup.horizontal(layoutSize: groupSize, subitems: [item])
        group.contentInsets = NSDirectionalEdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 15)

        let section = NSCollectionLayoutSection(group: group)
        section.contentInsets = NSDirectionalEdgeInsets(top: 10, leading: 0, bottom: 10, trailing: 0)
        section.orthogonalScrollingBehavior = .groupPagingCentered
        
        section.visibleItemsInvalidationHandler = { (items, offset, environment) in
            items.forEach { item in
                let distanceFromCenter = abs((item.frame.midX - offset.x) - environment.container.contentSize.width / 2.0)
                let minScale: CGFloat = 0.8
                let maxScale: CGFloat = 1.0
                let scale = max(maxScale - (distanceFromCenter / environment.container.contentSize.width), minScale)
                item.transform = CGAffineTransform(scaleX: scale, y: scale)
            }
        }

        
        return section
    }
    
}
