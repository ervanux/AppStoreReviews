//
//  TestArray.swift
//  AppStoreReviewsTests
//
//  Created by Erkan Ugurlu on 9.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import XCTest
@testable import AppStoreReviews

class CollectionTest: XCTestCase {

    func testPerformanceOfFindingTopWord() throws {
        var reviews: [Review] = []
        for _ in 1...1000 {
            reviews.append(Review.dummyReview())
        }

        self.measure {
            _ = reviews.wordsSortedByRepeatCount()
        }
    }
}
