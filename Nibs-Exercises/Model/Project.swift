//
//  Project.swift
//  Nibs-Exercises
//
//  Created by C4Q on 12/18/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import Foundation

struct ProjectResults: Codable {
    let projects: [Project]
}

struct Project: Codable, Equatable {
    let id: Int
    let name: String
    let imageLinks: ImageWrapper
    let fields: [String]
    let owners: [OwnerWrapper]
    
    enum CodingKeys: String, CodingKey {
        case id, name, fields, owners
        case imageLinks = "covers"
    }
    
    static func ==(lhs: Project, rhs: Project) -> Bool {
        return lhs.id == rhs.id
    }
}

struct ImageWrapper: Codable {
    let thumbnail: String
    
    enum CodingKeys: String, CodingKey {
        case thumbnail = "404"
    }
}

struct OwnerWrapper: Codable {
    let firstName: String
    let lastName: String
    
    enum CodingKeys: String, CodingKey {
        case firstName = "first_name"
        case lastName = "last_name"
    }
}
