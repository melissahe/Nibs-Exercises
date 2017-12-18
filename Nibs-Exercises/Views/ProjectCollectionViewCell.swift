//
//  ProjectCollectionViewCell.swift
//  Nibs-Exercises
//
//  Created by C4Q on 12/18/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class ProjectCollectionViewCell: UICollectionViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var projectImageView: UIImageView!
    @IBOutlet weak var fieldsLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func configureViews(from project: Project) {
        self.titleLabel.text = project.name
        self.fieldsLabel.text = project.fields.joined(separator: ", ")
        ImageAPIClient.manager.getImage(from: project.imageLinks.thumbnail, completionHandler: { (onlineImage) in
            self.projectImageView.image = onlineImage
            self.projectImageView.setNeedsLayout()
        }, errorHandler: {print($0)})
    }

}
