//
//  TopWordCell.swift
//  AppStoreReviews
//
//  Created by Erkan Ugurlu on 10.08.2020.
//  Copyright © 2020 ING. All rights reserved.
//

import UIKit

class TopWordCell: UITableViewCell {

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .value1, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(item: (word: String, count: Int)) {
        textLabel?.text = item.word
        detailTextLabel?.text = "\(item.count) time" + (item.count > 1 ? "s" : "")
    }
}
