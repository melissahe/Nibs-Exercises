//
//  FavoriteProjectsViewController.swift
//  Nibs-Exercises
//
//  Created by C4Q on 12/18/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class FavoriteProjectsViewController: UIViewController {

    @IBOutlet weak var favoritesCollectionView: UICollectionView!
    
    var favoriteProjects: [Project] = PersistentData.manager.getProjects() {
        didSet {
            favoritesCollectionView.reloadData()
        }
    }
    
    var cellSpacing: CGFloat = UIScreen.main.bounds.width * 0.05
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ProjectCollectionViewCell", bundle: nil)
        self.favoritesCollectionView.register(nib, forCellWithReuseIdentifier: "projectCell")
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.favoriteProjects = PersistentData.manager.getProjects()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let cell = sender as? ProjectCollectionViewCell,
            let indexPath = favoritesCollectionView.indexPath(for: cell),
            let destinationVC = segue.destination as? ProjectDetailViewController {
            destinationVC.project = favoriteProjects[indexPath.row]
            destinationVC.image = cell.projectImageView.image
        }
    }

}

extension FavoriteProjectsViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCells: CGFloat = 1
        let numberOfSpacings: CGFloat = numberOfCells + 1
        let width = (collectionView.bounds.width - (numberOfSpacings * cellSpacing)) / numberOfCells
        let height = collectionView.bounds.height - (cellSpacing * 2)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
}

extension FavoriteProjectsViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailedSegue", sender: collectionView.cellForItem(at: indexPath))
    }
}

extension FavoriteProjectsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return favoriteProjects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "projectCell", for: indexPath)
        let currentProject = favoriteProjects[indexPath.row]
        
        guard let projectCell = cell as? ProjectCollectionViewCell else {
            return cell
        }
        
        projectCell.configureViews(from: currentProject)
        
        return projectCell
    }
}
