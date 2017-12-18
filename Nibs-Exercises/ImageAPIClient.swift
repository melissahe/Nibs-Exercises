//
//  ImageAPIClient.swift
//  Nibs-Exercises
//
//  Created by C4Q on 12/18/17.
//  Copyright © 2017 Melissa He @ C4Q. All rights reserved.
//

import UIKit

class ImageAPIClient {
    private init() {}
    static let manager = ImageAPIClient()
    func getImage(from urlString: String, completionHandler: @escaping (UIImage) -> Void, errorHandler: @escaping (Error) -> Void) {
        guard let url = URL(string: urlString) else {
            print("bad image url: \(urlString)")
            return
        }
        
        NetworkHelper.manager.performDataTask(with: url, completionHandler: { (data) in
            guard let image = UIImage(data: data) else {
                print("bad data for image")
                return
            }
            
            completionHandler(image)
        }, errorHandler: errorHandler)
    }
}
