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
    
    //to do
    //    var favoriteProjects: [Project] = [] {
    //        didSet {
    //            projectCollectionView.reloadData()
    //        }
    //    }
    
    var cellSpacing: CGFloat = UIScreen.main.bounds.width * 0.05
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "ProjectCollectionViewCell", bundle: nil)
        self.favoritesCollectionView.register(nib, forCellWithReuseIdentifier: "projectCell")
        favoritesCollectionView.delegate = self
        favoritesCollectionView.dataSource = self
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
}

extension FavoriteProjectsViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 //to do
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "projectCell", for: indexPath)
        
        //to do
        
        return cell
    }
}
