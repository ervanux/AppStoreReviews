//
//  AppDelegate.swift
//  AppStoreReviews
//
//  Created by Dmitrii Ivanov on 21/07/2020.
//  Copyright © 2020 ING. All rights reserved.
//

import UIKit
import Core

final class FeedViewController: UITableViewController {
    private var viewModel: FeedViewModel!
    private var reviewProvider: ReviewProvider
    
    required init(reviewProvider: ReviewProvider) {
        self.reviewProvider = reviewProvider
        super.init(style: .plain)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.register(ReviewCell.self, forCellReuseIdentifier: tableView.cellIdentifier(section: .review))
        tableView.register(TopWordCell.self, forCellReuseIdentifier: tableView.cellIdentifier(section: .topWord))
        tableView.estimatedRowHeight = 60
        
        //TODO: There could be a better icon for filtering.
        let searchBtn = UIBarButtonItem(barButtonSystemItem: .search, target: self, action: #selector(pressedFilterBtn))
        let reloadBtn = UIBarButtonItem(barButtonSystemItem: .refresh, target: self, action: #selector(pressedReloadBtn))

        navigationItem.rightBarButtonItems = [searchBtn]
        navigationItem.leftBarButtonItems = [reloadBtn]
        
        setupViewModel(reviewProvider: reviewProvider)
    }
}

/// Datasource
extension FeedViewController {
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        Section.allCases.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch Section(rawValue: section)! {
        case .topWord:
            return viewModel.topWords?.count ?? 0
        case .review:
            return viewModel.filteredReviews?.count ?? 0
        }        
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = Section(rawValue: indexPath.section)!
        let cell = tableView.cell(for: section, indexPath: indexPath)
        switch section {
        case .topWord:
            (cell as! TopWordCell).update(item: viewModel.topWords![indexPath.row])
        case .review:
            (cell as! ReviewCell).update(item: viewModel.filteredReviews![indexPath.row])
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        switch Section(rawValue: section)! {
        case .topWord:
            if topWordRowExist {
                return "top_three_section_title".localized
            } else {
                return nil
            }
        case .review:
            return viewModel.filteredReviews?.count == viewModel.allReviews?.count ?
                "all_review_section_title".localized :
                "filtered_section_title".localized
        }
    }
}

/// Delegate
extension FeedViewController {
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        if indexPath.section == Section.review.rawValue {
            let vc = DetailsViewController(review: viewModel.filteredReviews![indexPath.row])
            navigationController!.pushViewController(vc, animated: true)
        }
    }
}

private extension FeedViewController {
    
    func setupViewModel(reviewProvider: ReviewProvider) {
        let updateCallback: FeedViewModel.UpdateCallback = { [weak self] in
            guard let self = self else { return }
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.tableView.scrollToRow(at: self.topIndexPath, at: .top, animated: true)
            }
        }
        
        let errorCallback: FeedViewModel.ErrorCallback = { [weak self] error in
            DispatchQueue.main.async {
                self?.showPopup(title: "connection_problem_title".localized, message: error.localizedDescription)
            }
        }
        
        viewModel = FeedViewModel(reviewProvider: reviewProvider, valuesChanged: updateCallback, errorOccured: errorCallback)
    }
    
    @objc func pressedReloadBtn() {
        viewModel.loadContent()
    }
    
    // Shows alertController for filtering
    @objc func pressedFilterBtn() {
        let alert = UIAlertController(title: "rating_title".localized , message: nil, preferredStyle: .actionSheet)
        
        let resetHandler: (UIAlertAction) -> Void = { [unowned self] _ in
            self.viewModel.resetFilter()
        }
        alert.addAction(UIAlertAction(title: "all".localized, style: .default, handler: resetHandler))
        
        let filterHandler: (UIAlertAction) -> Void = { [unowned self] action in
            self.viewModel.filter(by: action.title!.count)
        }
        
        Array(1...5).forEach {
            let title = String(repeating:"⭐️", count: $0)
            let action = UIAlertAction(title: title, style: .default, handler: filterHandler)
            alert.addAction(action)
        }
        
        alert.addAction(UIAlertAction(title: "cancel".localized, style: .cancel, handler: nil))
        alert.pruneNegativeWidthConstraints()
        present(alert, animated: true, completion: nil)
    }
    
    var topWordRowExist: Bool {
        if let count = viewModel.topWords?.count, count > 0 {
            return true
        }
        
        return false
    }
    
    var topIndexPath: IndexPath {
        IndexPath(row: 0, section: topWordRowExist ? Section.topWord.rawValue : Section.review.rawValue)
    }
}

private enum Section: Int, CaseIterable {
    case topWord, review
}

private extension UITableView {
    
    func cell(for section: Section, indexPath: IndexPath) -> UITableViewCell {
        return dequeueReusableCell(withIdentifier: cellIdentifier(section: section), for: indexPath)
    }
    
    func cellIdentifier(section: Section) -> String {
        switch section {
        case .topWord:
            return "topWordCell"
        case .review:
            return "reviewCell"
        }
    }
}
