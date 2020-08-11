//
//  Entry.swift
//  AppStoreReviews
//
//  Created by Erkan Ugurlu on 8.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

struct Entry: Codable {
    let author: EntryAuthor
    let imVersion: Label
    let imRating: Label
    let id: Label
    let title: Label
    let content: Content
    
    private enum CodingKeys : String, CodingKey {
        case author,
        imVersion = "im:version",
        imRating = "im:rating",
        id,
        title,
        content
    }
}
