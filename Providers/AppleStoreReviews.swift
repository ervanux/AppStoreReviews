//
//  OnlineReviewProvider.swift
//  AppStoreReviews
//
//  Created by Erkan Ugurlu on 9.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import Foundation
import Core

struct AppleStoreReviews: ReviewProvider {
    
    func startFetching<ModelType: RootModelType>(destination: Destionation, modelType: ModelType.Type, completion: @escaping Completion) {
        URLSession.shared.fetch(url: destination) { (result: Result<ModelType?, FetchError>) in
            switch result {
            case .failure(let error) :
                completion(.failure(error))
            case .success(let model) :
                completion(.success(model!.reviews))
            }
        }
    }
}
