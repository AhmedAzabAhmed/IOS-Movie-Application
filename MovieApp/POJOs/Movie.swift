//
//  Movie.swift
//  MovieApp
//
//  Created by azab on 2/27/20.
//  Copyright © 2020 azab. All rights reserved.
//

import Foundation

class Movie {
    
    var originalTitle : String?
    var posterPath : String?
    var overview : String?
    var releaseDate : String?
    var id : Int?
    //used to order Movies
    var voteAverage : Double?
    var popularity : Double?
    
    init(originalTitle : String, posterPath : String, overview : String, releaseDate : String, id : Int, voteAverage : Double, popularity : Double?) {
        
        self.originalTitle = originalTitle
        self.posterPath = posterPath
        self.overview = overview
        self.releaseDate = releaseDate
        self.id = id
        self.voteAverage = voteAverage
        self.popularity = popularity
    }
}
