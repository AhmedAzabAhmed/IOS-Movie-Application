//
//  HomeModel.swift
//  MovieApp
//
//  Created by azab on 2/27/20.
//  Copyright © 2020 azab. All rights reserved.
//
import Foundation
import Network
import Alamofire
import SwiftyJSON

class HomeModel {
    
    // POJOs Object to hold data
    var myMovie:Movie?
    
    //Array to Hold POJOs Oblects
    var moviesArr:[Movie]?
    
    var arrRes = [[String:AnyObject]]()
    
    //reference to presenter
    var homePresenter : IHomePresenter?
    
    //core Data
    var coreDataObj : CoreDataORM?
    
    init(homePresenter : IHomePresenter?) {
        self.homePresenter = homePresenter
    
        //core Data obj
        coreDataObj = CoreDataORM()
    }
    
    //check internet Connection
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")
    
    func showMovies(orderBy : String) {
        
        //check internet Connection
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
                
                self.retrieveMovies(orderBy: orderBy)
                
            } else {
                print("There's no internet connection.")
                
                //fetch from Core Date
                self.moviesArr = self.coreDataObj?.fetchData(entity: "MovieEntity")
                self.homePresenter?.setMovies(movies: self.moviesArr!)
            }
        }
        
        monitor.start(queue: queue)
    }
    
    func retrieveMovies(orderBy : String) {
        
        // array to hold data
        moviesArr = [Movie]()
        
        let url : MyURLs = MyURLs()
        
        Alamofire.request(url.movieURLOrderBy(str: orderBy)).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                if let resData = swiftyJsonVar["results"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                    
                    for i in self.arrRes {
                        var poster : String
                        if( i["poster_path"] is NSNull){
                            poster = "a.jpg"
                        }else{
                            poster = i["poster_path"] as! String
                        }
                        self.myMovie = Movie(originalTitle: i["original_title"] as? String ?? "NO original title" , posterPath: "https://image.tmdb.org/t/p/w185"+poster, overview: i["overview"] as? String ?? "NO Overview", releaseDate: i["release_date"] as? String ?? "NO release date", id: i["id"] as? Int ?? 0, voteAverage: i["vote_average"] as? Double ?? 0.0, popularity: (i["popularity"] as? Double))
                        self.moviesArr?.append(self.myMovie!)
                    }
                    self.homePresenter?.setMovies(movies: self.moviesArr!)
                    self.coreDataObj?.deleteAllData()
                    self.coreDataObj?.insertInCoreData(data: self.moviesArr!)
                }
            }
        }
    }
}
