//
//  FeedViewModel.swift
//  AppStoreReviews
//
//  Created by Erkan Ugurlu on 9.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import Foundation

final class FeedViewModel {
    
    //TODO: consider kvo instead of callbacks
    typealias UpdateCallback = ()->()
    typealias ErrorCallback = (Error)->()
    
    private var valuesChanged: UpdateCallback?
    private var errorOccured: ErrorCallback?
    
    private let reviewProvider: ReviewProvider
    
    var allReviews: [Review]? {
        didSet {
            filteredReviews = allReviews
        }
    }
    var filteredReviews: [Review]?
    var topWords: [(word: String, count: Int)]?
    
    init(reviewProvider: ReviewProvider, valuesChanged: UpdateCallback?, errorOccured: ErrorCallback?) {
        self.reviewProvider = reviewProvider
        self.valuesChanged = valuesChanged
        self.errorOccured = errorOccured
        
        loadContent()
    }
        
    func filter(by rating: Int) {
        filteredReviews = allReviews?.filter { $0.rating == rating }
        topWords = Array(filteredReviews!.wordsSortedByRepeatCount().prefix(3))
        
        valuesChanged?()
    }
    
    func resetFilter() {
        filteredReviews = allReviews
        topWords = nil
        valuesChanged?()
    }
    
    func loadContent() {
        topWords = nil
        
        reviewProvider.startFetching(destination: .appleStore, modelType: AppStoreFeed.self, completion: {[weak self] result in
            guard let self = self else {
                print("VC is already gone!")
                return
            }
            
            switch result {
            case .success(let reviews):
                self.allReviews = reviews
                self.valuesChanged?()
            case .failure(let error) :
                self.errorOccured?(error)
            }
        })
    }
}
