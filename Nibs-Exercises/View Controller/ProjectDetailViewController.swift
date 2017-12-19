//
//  ProjectDetailViewController.swift
//  Nibs-Exercises
//
//  Created by C4Q on 12/18/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class ProjectDetailViewController: UIViewController {

    @IBOutlet weak var projectImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var authorsLabel: UILabel!
    @IBOutlet weak var fieldsLabel: UILabel!
    @IBOutlet weak var favoriteImageBarButtonItem: UIBarButtonItem!
    
    var project: Project!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    @IBAction func favoriteButtonPressed(_ sender: UIBarButtonItem) {
        let favoriteProjects = PersistentData.manager.getProjects()
        
        if !favoriteProjects.contains(project) {
            PersistentData.manager.addProject(newProject: project, andImage: image)
            favoriteButtonIsSelected()
        } else {
            PersistentData.manager.deleteProject(project)
            favoriteButtonIsNotSelected()
        }
    }
    
    
    func configureViews() {
        self.titleLabel.text = project.name
        self.authorsLabel.text = project.owners.map{$0.firstName + " " + $0.lastName}.joined(separator: ", ")
        self.fieldsLabel.text = project.fields.joined(separator: ", ")
        self.projectImageView.image = image
        configureFavoriteButton()
    }
    
    func configureFavoriteButton() {
        let favoriteProjects = PersistentData.manager.getProjects()
        
        if favoriteProjects.contains(project) {
            favoriteButtonIsSelected()
        } else {
            favoriteButtonIsNotSelected()
        }
    }
    
    func favoriteButtonIsSelected() {
        favoriteImageBarButtonItem.image = #imageLiteral(resourceName: "favorite-filled")
        favoriteImageBarButtonItem.tintColor = UIColor(red: 1, green: 0.414, blue: 0.515, alpha: 1)
    }
    
    func favoriteButtonIsNotSelected() {
        favoriteImageBarButtonItem.image = #imageLiteral(resourceName: "favorite-unfilled")
        favoriteImageBarButtonItem.tintColor = UIColor(red: 0.674, green: 0.686, blue: 0.741, alpha: 1)
    }

}
