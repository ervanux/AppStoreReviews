//
//  TestFeedViewModel.swift
//  AppStoreReviewsTests
//
//  Created by Erkan Ugurlu on 9.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import XCTest
@testable import AppStoreReviews

class FeedViewModelTest: XCTestCase {
    var feedVM: FeedViewModel!
    
    override func setUp() {
        feedVM = FeedViewModel(reviewProvider: MockReviewProvider(), valuesChanged: nil, errorOccured: nil)
        feedVM.loadContent()
        feedVM.filter(by: 2)
    }

    func testReviewCountAfterFilterBy() {
        XCTAssertEqual(feedVM.filteredReviews?.count, 10)
    }

    func testResultAfterFilterBy() {
        XCTAssertEqual(feedVM.topWords?.map{ $0.0 }, ["dolor", "dolore", "mollit"])
    }
    
    func testResultCountsAfterFilterBy() {
        XCTAssertEqual(feedVM.topWords?.map{ $0.1 }, [20, 20, 10])
    }
    
    func testReset() {
        feedVM.resetFilter()
        XCTAssertEqual(feedVM.filteredReviews?.count, feedVM.allReviews?.count)
    }
}
