//
//  ReviewProvider.swift
//  AppStoreReviews
//
//  Created by Erkan Ugurlu on 9.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import Core

protocol ReviewProvider {
    typealias RootModelType = ReviewConvertible & Codable
    typealias Completion = (Result<[Review], Error>) ->()
    
    func startFetching<ModelType: RootModelType>(destination: Destionation, modelType: ModelType.Type, completion: @escaping Completion)
}
