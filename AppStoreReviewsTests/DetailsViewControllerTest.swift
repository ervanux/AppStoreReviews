//
//  TestDetailsViewController.swift
//  AppStoreReviewsTests
//
//  Created by Erkan Ugurlu on 9.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import XCTest
@testable import AppStoreReviews

class DetailsViewControllerTest: XCTestCase {

    var detailVC: DetailsViewController!
    let review = Review(author: "author", version: "1.0", rating: 5, title: "Cool!", id: "1", content: "go on!")

    override func setUp() {
        detailVC = DetailsViewController(review: review)
        _ = detailVC.view
    }

    func testTitle() throws {
        XCTAssertEqual(detailVC.titleLabel.text, review.title)
    }

    func testAuthor() throws {
        XCTAssertEqual(detailVC.authorLabel.text, review.author)
    }

    func testContent() throws {
        XCTAssertEqual(detailVC.contentLabel.text, review.content)
    }
    func testRating() throws {
        XCTAssertEqual(detailVC.ratingVersionLabel.text, review.ratingVersionText())
    }
}
