//
//  ReviewsModel.swift
//  MovieApp
//
//  Created by azab on 3/11/20.
//  Copyright © 2020 azab. All rights reserved.
//

import Foundation
import Network
import Alamofire
import SwiftyJSON

class ReviewsModel {
    
    // POJOs Object to hold data
    var myReviews:Reviews?
    
    //Array to Hold POJOs Oblects
    var reviewsArr:[Reviews]?
    
    var arrRes = [[String:AnyObject]]()
    
    //reference to presenter
    var reviewsPresenter : IReviewsPresenter?
    
    init(reviewsPresenter : IReviewsPresenter?) {
        self.reviewsPresenter = reviewsPresenter
    }
    
    //check internet Connection
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")
    
    func showReviews(id : Int) {
        
        //check internet Connection
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
                
                self.retrieveReviews(id: id)
            } else {
                print("There's no internet connection.")
            }
        }
        
        monitor.start(queue: queue)
    }
    
    func retrieveReviews(id : Int) {
        
        reviewsArr = [Reviews]()
        
        let url : MyURLs = MyURLs()
        let s : String = url.reviewsUrl(id: id)
        Alamofire.request(s).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                if let resData = swiftyJsonVar["results"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                    
                    for i in self.arrRes {
                        self.myReviews = Reviews(author: (i["author"] as! String), content: (i["content"] as! String) )
                        self.reviewsArr?.append(self.myReviews!)
                    }
                    //set Delegate
                    self.reviewsPresenter?.setReviews(reviews: self.reviewsArr!)
                }
            }
        }
    }
    
}
