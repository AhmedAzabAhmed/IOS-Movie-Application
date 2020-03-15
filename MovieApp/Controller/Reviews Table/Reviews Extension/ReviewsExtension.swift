//
//  ReviewsExtension.swift
//  MovieApp
//
//  Created by azab on 3/12/20.
//  Copyright © 2020 azab. All rights reserved.
//

import Foundation
import UIKit

extension ReviewsTableView : IReviewsView {
    
    func renderReviews(reviews: [Reviews]) {
        
        DispatchQueue.main.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            self.myReviews = reviews
            self.tableView.reloadData()
        }
    }
    
    func showLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hideLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func showErrorMessage(errorMessage: String) {
        
    }
}
