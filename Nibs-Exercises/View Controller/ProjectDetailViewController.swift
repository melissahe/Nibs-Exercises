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
    
    var project: Project!
    var image: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureViews()
    }
    
    func configureViews() {
        self.titleLabel.text = project.name
        self.authorsLabel.text = project.owners.map{$0.firstName + " " + $0.lastName}.joined(separator: ", ")
        self.fieldsLabel.text = project.fields.joined(separator: ", ")
        self.projectImageView.image = image
    }

}
