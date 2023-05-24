//
//  SportCollectionViewController.swift
//  SportFlash
//
//  Created by ahmed osama on 21/05/2023.
//

import UIKit

private let reuseIdentifier = "SportCollectionViewCell"

class SportCollectionViewController: UICollectionViewController {
    let sports = [Sport.football,Sport.basketball,Sport.football,Sport.basketball]

    override func viewDidLoad() {
        super.viewDidLoad()

        navigationController?.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]

        let layout: UICollectionViewFlowLayout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 10, right: 20)
        layout.itemSize =  CGSize(width: self.view.frame.width/2.4, height: self.view.frame.height/2.7)
        layout.minimumInteritemSpacing = 0
        layout.minimumLineSpacing = 20
        collectionView!.collectionViewLayout = layout
        collectionView.register(UINib(nibName: "SportCollectionViewCell", bundle: nil), forCellWithReuseIdentifier: reuseIdentifier)
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Register cell classes

        // Do any additional setup after loading the view.
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using [segue destinationViewController].
        // Pass the selected object to the new view controller.
    }
    */

    // MARK: UICollectionViewDataSource

    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }


    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return 4
    }

    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! SportCollectionViewCell
        var sportname=""
        switch sports[indexPath.row] {
        case .football:
            sportname = "FootBall"
        case .basketball:
            sportname = "BasketBall"
        }
        cell.sportName.text = sportname
        cell.sportImage.image = UIImage(named: sportname)
    
        // Configure the cell
    
        return cell
    }
  
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let leaguesVC = storyboard?.instantiateViewController(withIdentifier: "LeaguesTableViewController") as! LeaguesTableViewController
       
        leaguesVC.sport = sports[indexPath.row]
        navigationController?.pushViewController(leaguesVC, animated: true)
    }

}
