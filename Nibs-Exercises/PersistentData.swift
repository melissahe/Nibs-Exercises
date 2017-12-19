//
//  PersistentDataManager.swift
//  Nibs-Exercises
//
//  Created by C4Q on 12/18/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class PersistentData {
    //singleton
    private init() {}
    static let manager = PersistentData()
    
    //plist name
    static let pListName = "FavoriteProjects.plist"
    
    private var favoriteProjects: [Project] = [] {
        didSet {
            saveProjects() //saves every times it changes
        }
    }
    
    //find document directory
    func documentDirectory() -> URL {
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        
        return paths[0]
    }
    
    //append plist to document directory
    func dataFilePath(filePathName: String) -> URL {
        return documentDirectory().appendingPathComponent(filePathName)
    }
    
    //save, load, get, add, delete
    
    //save
    func saveProjects() {
        //get file path of plist
        let plistFilePath = self.dataFilePath(filePathName: PersistentData.pListName)
        //instantiate encoder
        let encoder = PropertyListEncoder()
        
        do {
            //turn what you want to save into data
            let data = try encoder.encode(favoriteProjects)
            //write that data to the file path of plist
            try data.write(to: plistFilePath)
        } catch let error {
            print(error)
        }
    }
    
    //load
    func loadProjects() {
        //get file path of plist
        let plistFilePath = self.dataFilePath(filePathName: PersistentData.pListName)
        //instantiate decoder
        let decoder = PropertyListDecoder()
        
        do {
            let data = try Data.init(contentsOf: plistFilePath, options: [])
            let favoriteProjects = try decoder.decode([Project].self, from: data)
            self.favoriteProjects = favoriteProjects
        } catch let error {
            print(error)
        }
    }
    
    //get projects
    func getProjects() -> [Project] {
        return favoriteProjects
    }
    
    //add projects
    func addProject(newProject: Project, andImage image: UIImage) {
        //if project doesn't exist
        guard !favoriteProjects.contains(newProject) else {
            return
        }
        
        //add image
        guard let imageData = UIImagePNGRepresentation(image) else {
            return
        }
        
        let imageFilePath = dataFilePath(filePathName: newProject.id.description)
        
        do {
            try imageData.write(to: imageFilePath)
        } catch let error {
            print("Image saving error: \(error.localizedDescription)")
        }
        
        //add project
        favoriteProjects.append(newProject)
        
    }
    
    //delete projects
    func deleteProject(_ project: Project) {
        //make sure project exists
        guard let index = favoriteProjects.index(of: project) else {
            return
        }
        
        //remove image
        let imageFilePath = dataFilePath(filePathName: project.id.description)
        do {
            try FileManager.default.removeItem(at: imageFilePath)
        } catch let error {
            print("error removing image at: \(imageFilePath); error: \(error.localizedDescription)")
        }
        
        //remove project
        favoriteProjects.remove(at: index)
    }
}
