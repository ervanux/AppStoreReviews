//
//  ReviewForTest.swift
//  AppStoreReviewsTests
//
//  Created by Erkan Ugurlu on 9.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import Foundation
@testable import AppStoreReviews

extension Review {
    
   static func dummyReview(with rating: Int = Int.random(in: 1...5)) -> Review {
        let author = ["Dan Auerbach", "Bo Diddley", "Otis Rush", "Jimi Hendrix", "Albert King", "Buddy Guy", "Muddy Waters", "Eric Clapton"].randomElement()!
        let version = ["3.11", "3.12"].randomElement()!
        let rating = rating
        let title = ["Awesome app", "Could be better", "Gimme my money back!!", "Lemme tell you a story..."].randomElement()!
        let id = UUID().uuidString
        let content = "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum."
        return Review(author: author,
                      version: version,
                      rating: rating,
                      title: title,
                      id: id,
                      content: content)
    }
}
