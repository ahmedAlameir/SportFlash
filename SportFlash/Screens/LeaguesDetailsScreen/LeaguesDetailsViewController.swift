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
    var leagueID:Int!
    var sport:Sport!
    
    private var upComingEventActivityIndicator: UIActivityIndicatorView!
    private var latestEventActivityIndicator: UIActivityIndicatorView!
    private var teamsActivityIndicator: UIActivityIndicatorView!
    
    private var upComingEventNoDataLabel: UILabel!
    private var latestEventNoDataLabel: UILabel!
    private var teamsNoDataLabel: UILabel!
    
    @IBOutlet weak var upComingEventCollectionView: UICollectionView!
    @IBOutlet weak var latestEventCollectionView: UICollectionView!
    @IBOutlet weak var teamsCollectionView: UICollectionView!
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViewModel()
        setupCollectionView()
        fetchData()
        setupActivityIndicator()
        setupNoDataLabel()
                
    }
    private func setupNoDataLabel(){
        upComingEventNoDataLabel = addNoDataLabel(to: upComingEventCollectionView)
        latestEventNoDataLabel = addNoDataLabel(to: latestEventCollectionView)
        teamsNoDataLabel = addNoDataLabel(to: teamsCollectionView)
        
    }
    private func setupActivityIndicator(){
        upComingEventActivityIndicator = addActivityIndicator(to: upComingEventCollectionView)
        latestEventActivityIndicator = addActivityIndicator(to: latestEventCollectionView)
        teamsActivityIndicator = addActivityIndicator(to: teamsCollectionView)
    }
    private func fetchData() {
        viewModel.fetchData()
    }
    private func setupViewModel() {
         viewModel = LeaguesDetailsViewModel(
             sportsRepository: SportsRepositoryImpl(api: SportsAPI(), sportdb: DatabaseManager.shared),
             leagueId: leagueID,
             sport: sport
         )
         
         viewModel.onUpcomingEventsUpdated = { [weak self] in
             DispatchQueue.main.async {
                 self?.upComingEventCollectionView.reloadData()
                 self?.upComingEventActivityIndicator.stopAnimating()
             }
         }
         
         viewModel.onLatestEventsUpdated = { [weak self] in
             DispatchQueue.main.async {
                 self?.latestEventCollectionView.reloadData()
                 self?.latestEventActivityIndicator.stopAnimating()

             }
         }
         
         viewModel.onTeamsUpdated = { [weak self] in
             DispatchQueue.main.async {
                 self?.teamsCollectionView.reloadData()
                 self?.teamsActivityIndicator.stopAnimating()

             }
         }
        viewModel.onUpcomingError = { [weak self]  error in
            DispatchQueue.main.async {
                self?.upComingEventNoDataLabel.isHidden = false
                self?.upComingEventActivityIndicator.stopAnimating()

            }
        }
        viewModel.onLatestError = { [weak self]  error in
            DispatchQueue.main.async {
                self?.latestEventNoDataLabel.isHidden = false
                self?.latestEventActivityIndicator.stopAnimating()

            }
        }
        viewModel.onTeamsError = { [weak self]  error in
            DispatchQueue.main.async {
                self?.teamsNoDataLabel.isHidden = false
                self?.teamsActivityIndicator.stopAnimating()

            }
        }
    }
    private func addNoDataLabel(to collectionView: UICollectionView) -> UILabel {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textAlignment = .center
        label.textColor = .gray
        label.text = "No Data Available"
        label.isHidden = true
        collectionView.addSubview(label)
        NSLayoutConstraint.activate([
            label.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            label.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor)
        ])
        return label
    }
    private func setupCollectionView() {
        upComingEventCollectionView.register(UINib(nibName: "EventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: evenCellReuseIdentifier)
        upComingEventCollectionView.setCollectionViewLayout(UICollectionViewCompositionalLayout(section: upComingEventSection()), animated: true)
        
        latestEventCollectionView.register(UINib(nibName: "EventCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: evenCellReuseIdentifier)
        latestEventCollectionView.collectionViewLayout = latestEventFlowLayout()
        
        teamsCollectionView.register(UINib(nibName: "TeamsCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: teamReuseIdentifier)
        teamsCollectionView.collectionViewLayout = teamsFlowLayout()
    }

    private func addActivityIndicator(to collectionView: UICollectionView) -> UIActivityIndicatorView {
        let activityIndicator = UIActivityIndicatorView(style: .medium)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        collectionView.addSubview(activityIndicator)
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: collectionView.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: collectionView.centerYAnchor)
        ])
        activityIndicator.startAnimating()
        return activityIndicator
    }
    
    private func upComingEventSection()-> NSCollectionLayoutSection {
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
   private  func latestEventFlowLayout() -> UICollectionViewFlowLayout {
        let latestEventlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        latestEventlayout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        latestEventlayout.itemSize = CGSize(width: self.view.frame.width-40, height: 150)
        return latestEventlayout
    }
    
    private func teamsFlowLayout() -> UICollectionViewFlowLayout {
        let teamsEventlayout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        teamsEventlayout.sectionInset = UIEdgeInsets(top: 20, left: 0, bottom: 10, right: 0)
        teamsEventlayout.itemSize = CGSize(width: self.view.frame.width/3, height:  self.view.frame.width/3)
        teamsEventlayout.scrollDirection = .horizontal
        return teamsEventlayout
        
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
        switch collectionView {
        case upComingEventCollectionView:
            return viewModel.upComingEventsCount()
        case latestEventCollectionView:
            return viewModel.latestEventsCount()
        case teamsCollectionView:
            return viewModel.teamsCount()
        default:
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch collectionView{
        case upComingEventCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: evenCellReuseIdentifier, for: indexPath) as! EventCollectionViewCell
            cell.hideScore()
            cell.configure(with: viewModel.upComingEvent(at: indexPath.row), sport: sport)
            
            return cell
        case latestEventCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: evenCellReuseIdentifier, for: indexPath) as! EventCollectionViewCell
            cell.configure(with: viewModel.latestEvent(at: indexPath.row), sport: sport)
                
            return cell
        case teamsCollectionView:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: teamReuseIdentifier, for: indexPath) as! TeamsCollectionViewCell
            if let teamLogo =  viewModel.team(at: indexPath.row).teamLogo {
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
            teamVC.team = viewModel.team(at: indexPath.row)
            navigationController?.pushViewController(teamVC, animated: true)
        }
        
    }
 
    
}
