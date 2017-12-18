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

struct Project: Codable {
    let name: String
    let imageLinks: ImageWrapper
    let fields: [String]
    let owners: [OwnerWrapper]
    
    enum CodingKeys: String, CodingKey {
        case name, fields, owners
        case imageLinks = "covers"
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
