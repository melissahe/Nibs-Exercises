//
//  ProjectAPIClient.swift
//  Nibs-Exercises
//
//  Created by C4Q on 12/18/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

class ProjectAPIClient {
    private init() {}
    static let manager = ProjectAPIClient()
    private let apiKey = "2gsDZaygnPkNuEC8EBlgdsUcvnTPDQix"
    func getProjects(from searchTerm: String, completionHandler: @escaping ([Project]) -> Void, errorHandler: @escaping (Error) -> Void) {
        let urlString = "https://api.behance.net/v2/projects?api_key=\(apiKey)&q=\(searchTerm)"
        
        guard let url = URL(string: urlString) else {
            print("bad url: \(urlString)")
            return
        }
        
        NetworkHelper.manager.performDataTask(with: url, completionHandler: { (data) in
            do {
                let results = try JSONDecoder().decode(ProjectResults.self, from: data)
                completionHandler(results.projects)
            } catch let error {
                errorHandler(error)
            }
        }, errorHandler: errorHandler)
    }
}
