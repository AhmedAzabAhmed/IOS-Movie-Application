//
//  ReviewsPresenter.swift
//  MovieApp
//
//  Created by azab on 3/12/20.
//  Copyright © 2020 azab. All rights reserved.
//

import Foundation

class ReviewsPresenter: IReviewsPresenter {
    
    //Object of Model
    var model : ReviewsModel?
    
    //reference of Home view delegate
    var reviewsView : IReviewsView?
    
    var myArray : [Reviews]?
    
    init(reviewsView : IReviewsView?) {
        self.reviewsView = reviewsView
        model = ReviewsModel(reviewsPresenter: self)
        myArray = [Reviews]()
    }
    
    
    func setReviews(reviews: [Reviews]) {
        
        myArray = reviews
                
                if myArray!.count == 0 {
                    
                    onFail(errorMessgae: "Fail to Retrieve Data")
                    
                } else {
                   onSuccess(reviews: myArray!)
               }
    }
    
    func getReviews(id: Int) {
        model?.showReviews(id: id)
    }
    
    func onSuccess(reviews: [Reviews]) {
        reviewsView?.renderReviews(reviews: reviews)
    }
    
    func onFail(errorMessgae: String) {
        
    }
    
    
}
