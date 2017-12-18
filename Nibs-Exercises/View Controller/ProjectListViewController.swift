//
//  ViewController.swift
//  Nibs-Exercises
//
//  Created by C4Q on 12/18/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class ProjectListViewController: UIViewController {

    @IBOutlet weak var projectCollectionView: UICollectionView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    //to do
//    var projects: [Project] = [] {
//        didSet {
//            projectCollectionView.reloadData()
//        }
//    }
    
    var cellSpacing: CGFloat = UIScreen.main.bounds.width * CGFloat(0.05)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        //the below must be called before you start dequeueing cells
        //1. instantiate nib
        let nib = UINib(nibName: "ProjectCollectionViewCell", bundle: nil)
        //2. register nib with collection view - tells the collection view to use this nib when creating new cells of the specified reuse identifier
        projectCollectionView.register(nib, forCellWithReuseIdentifier: "projectCell")
        
        projectCollectionView.delegate = self
        projectCollectionView.dataSource = self
        
    }

}

extension ProjectListViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let numberOfCells: CGFloat = 1
        let numberOfSpaces: CGFloat = numberOfCells + 1
        let width = (collectionView.bounds.width - (numberOfSpaces * cellSpacing)) / numberOfCells
        let height = collectionView.bounds.height - (cellSpacing * 2)
        return CGSize(width: width, height: height)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
    }
}

extension ProjectListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1 // to do
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "projectCell", for: indexPath)
        
        //to do
        
        return cell
    }
}

