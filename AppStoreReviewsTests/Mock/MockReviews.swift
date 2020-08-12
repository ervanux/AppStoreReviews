//
//  RandomReviewsForTest.swift
//  AppStoreReviewsTests
//
//  Created by Erkan Ugurlu on 9.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import Foundation
import Core
@testable import AppStoreReviews

struct MockReviewProvider: ReviewProvider {
    
    func startFetching<ModelType: RootModelType>(destination: Destionation, modelType: ModelType.Type, completion: @escaping Completion) {
        
        var reviews: [Review] = []
        for _ in 1...10 {
            reviews.append(Review.dummyReview(with: 1))
            reviews.append(Review.dummyReview(with: 2))
            reviews.append(Review.dummyReview(with: 3))
            reviews.append(Review.dummyReview(with: 4))
            reviews.append(Review.dummyReview(with: 5))
        }
        
        completion(.success(reviews))
    }
}
