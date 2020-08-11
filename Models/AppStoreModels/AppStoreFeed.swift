//
//  AppStoreFeed.swift
//  AppStoreReviews
//
//  Created by Erkan Ugurlu on 8.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

struct AppStoreFeed: Codable {
    
    let feed: Feed
}

extension AppStoreFeed: ReviewConvertible {
    
    var reviews: [Review] {
        feed.entry.compactMap{ Review(entry: $0) }
    }
}
