//
//  TestFeedViewController.swift
//  AppStoreReviewsTests
//
//  Created by Erkan Ugurlu on 9.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import XCTest
@testable import AppStoreReviews

class FeedViewControllerTest: XCTestCase {
    var feedVC: FeedViewController!
    
    override func setUp() {
        feedVC = FeedViewController(reviewProvider: MockReviewProvider())
        _ = feedVC.view
    }
    
    func testNumberOfRows() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(feedVC.tableView.numberOfRows(inSection: 1), 50)
    }    
}
