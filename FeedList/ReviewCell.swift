//
//  AppDelegate.swift
//  AppStoreReviews
//
//  Created by Dmitrii Ivanov on 21/07/2020.
//  Copyright © 2020 ING. All rights reserved.
//

import UIKit

final class ReviewCell: UITableViewCell {

    private var titleLabel = UILabel()
    private var authorLabel = UILabel()
    private var textPreviewLabel = UILabel()
    private var ratingVersionLabel = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        setupLabels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func update(item: Review) {
        ratingVersionLabel.text = item.ratingVersionText()
        authorLabel.text = "from: \(item.author)"
        titleLabel.text = "\(item.title)"
        textPreviewLabel.text = "\(item.content)"
    }
    
    private func setupLabels() {
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        authorLabel.translatesAutoresizingMaskIntoConstraints = false
        textPreviewLabel.translatesAutoresizingMaskIntoConstraints = false
        ratingVersionLabel.translatesAutoresizingMaskIntoConstraints = false
        
        titleLabel.font = UIFont.boldSystemFont(ofSize: 18)
        titleLabel.numberOfLines = 2
        ratingVersionLabel.font = UIFont.italicSystemFont(ofSize: 18)
        authorLabel.font = UIFont.italicSystemFont(ofSize: 18)
        textPreviewLabel.font = UIFont.systemFont(ofSize: 14)
        textPreviewLabel.numberOfLines = 3

        let stack = UIStackView()
        stack.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stack)
        stack.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 8).isActive = true
        stack.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -8).isActive = true
        stack.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 8).isActive = true
        stack.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -8).isActive = true

        stack.axis = .vertical
        stack.distribution = .equalSpacing
        stack.alignment = .leading
        stack.spacing = 5

        stack.addArrangedSubview(ratingVersionLabel)
        stack.addArrangedSubview(authorLabel)
        stack.addArrangedSubview(titleLabel)
        stack.addArrangedSubview(textPreviewLabel)
    }

}
