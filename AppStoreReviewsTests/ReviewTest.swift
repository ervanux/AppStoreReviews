//
//  TestReview.swift
//  AppStoreReviewsTests
//
//  Created by Erkan Ugurlu on 9.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import XCTest
@testable import AppStoreReviews

class ReviewTest: XCTestCase {
    let review = Review(author: "author", version: "1.0", rating: 5, title: "Cool!", id: "1", content: "go on!")
    
    func testRatingStars(){
        XCTAssertEqual(review.ratingVersionText(), "⭐️⭐️⭐️⭐️⭐️ (ver: 1.0)")
    }
}
