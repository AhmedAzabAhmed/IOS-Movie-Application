//
//  HomePresenter.swift
//  MovieApp
//
//  Created by azab on 2/27/20.
//  Copyright © 2020 azab. All rights reserved.
//

import Foundation

class HomePresenter: IHomePresenter  {
    
    //Object of Model
    var model : HomeModel?
    
    //reference of Home view delegate
    var homeView : IHomeView?
    
    var myArray : [Movie]?
    
    init(homeView : IHomeView) {
         self.homeView = homeView
         model = HomeModel(homePresenter: self)
         myArray = [Movie]()
     }
    
    func setMovies(movies: [Movie]) {
        
        myArray = movies
        
        if myArray!.count == 0 {
            
            onFail(errorMessgae: "Fail to Retrieve Data")
            
        } else {
           onSuccess(movies: myArray!)
       }
    }
    
    func getMovies(orderBy : String) {
        model?.showMovies(orderBy: orderBy)
    }
    
    func onSuccess(movies: [Movie]) {
        homeView?.renderHomeWithMovies(movies: movies)
    }
    
    func onFail(errorMessgae: String) {
        
    }    
}
