//
//  AppDelegate.swift
//  AppStoreReviews
//
//  Created by Dmitrii Ivanov on 21/07/2020.
//  Copyright © 2020 ING. All rights reserved.
//

import Foundation

struct Review: Codable {
    let author: String
    let version: String
    let rating: Int
    let title: String
    let id: String
    let content: String
    
    func ratingVersionText() -> String {
        return "\(String(repeating:"⭐️", count: rating)) (ver: \(version))"
    }
}

extension Review: CustomStringConvertible {
    
    var description: String {
        return title + " " + content
    }
}

extension Review {
    
    init(entry: Entry) {
        self.init(author: entry.author.name.label,
                  version: entry.imVersion.label,
                  rating: Int(entry.imRating.label)!,
                  title: entry.title.label,
                  id: entry.id.label,
                  content: entry.content.label)
    }
}
