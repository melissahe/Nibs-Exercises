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
        
        let favoriteProjects = PersistentData.manager.getProjects()
        
        if favoriteProjects.contains(project) {
            let imageFilePath = PersistentData.manager.dataFilePath(filePathName: project.id.description)
            
            do {
                let data = try Data.init(contentsOf: imageFilePath)
                guard let image = UIImage(data: data) else {
                    print("error getting image from data")
                    return
                }
                projectImageView.image = image
            } catch let error {
                print("image initialization error: \(error)")
            }
        } else {
            ImageAPIClient.manager.getImage(from: project.imageLinks.thumbnail, completionHandler: { (onlineImage) in
                self.projectImageView.image = onlineImage
                self.projectImageView.setNeedsLayout()
            }, errorHandler: {print($0)})
        }
    }

}
