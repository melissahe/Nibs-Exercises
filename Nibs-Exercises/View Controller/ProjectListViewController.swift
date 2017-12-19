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

    var projects: [Project] = [] {
        didSet {
            if projects.isEmpty {
                return
            }
            projectCollectionView.reloadData()
        }
    }
    
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
        searchBar.delegate = self
        
    }
    
    func loadProjects(searchTerm: String) {
        ProjectAPIClient.manager.getProjects(from: searchTerm, completionHandler: { (onlineProjects) in
            self.projects = onlineProjects
        }, errorHandler: {print($0)})
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if
            let cell = sender as? ProjectCollectionViewCell,
            let indexPath = projectCollectionView.indexPath(for: cell),
            let destinationVC = segue.destination as? ProjectDetailViewController {
            destinationVC.project = projects[indexPath.row]
            destinationVC.image = cell.projectImageView.image
        }
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
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return cellSpacing
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: cellSpacing, left: cellSpacing, bottom: cellSpacing, right: cellSpacing)
    }
}

extension ProjectListViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        performSegue(withIdentifier: "detailedSegue", sender: collectionView.cellForItem(at: indexPath))
    }
}

extension ProjectListViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return projects.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "projectCell", for: indexPath)
        let currentProject = projects[indexPath.row]
        
        guard let projectCell = cell as? ProjectCollectionViewCell else {
            return cell
        }
        
        projectCell.projectImageView.image = nil
        
        projectCell.configureViews(from: currentProject)
        
        return projectCell
    }
}

extension ProjectListViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text, let formattedText = searchText.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) else {
            print("bad search: \(String(describing: searchBar.text))")
            return
        }
        
        loadProjects(searchTerm: formattedText)
    }
}

