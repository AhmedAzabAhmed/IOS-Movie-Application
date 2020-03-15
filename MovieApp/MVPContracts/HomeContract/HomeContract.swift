//
//  HomeContract.swift
//  MovieApp
//
//  Created by azab on 2/27/20.
//  Copyright © 2020 azab. All rights reserved.
//

import Foundation

// for render Movies poster
protocol IHomeView : IBaseView {
    
    func renderHomeWithMovies(movies : [Movie]);
    
}
// for render videos
protocol IVideosView : IBaseView {
    
    func renderMovieVideos(videos : [Videos]);
    
}

// for render Reviews
protocol IReviewsView : IBaseView {
    
    func renderReviews(reviews : [Reviews]);
}

// for Home Presenter
protocol IHomePresenter {
    
    func setMovies(movies: [Movie])
    func getMovies(orderBy : String)
    func onSuccess(movies : [Movie])
    func onFail(errorMessgae : String)
}

// for videos presenter
protocol IVideoPresenter {
    
    func setVideos(videos: [Videos])
    func getVideos(id : Int)
    func onSuccess(videos : [Videos])
    func onFail(errorMessgae : String)
}


// for Reviews presenter
protocol IReviewsPresenter {
    
    func setReviews(reviews: [Reviews])
    func getReviews(id : Int)
    func onSuccess(reviews : [Reviews])
    func onFail(errorMessgae : String)
}
