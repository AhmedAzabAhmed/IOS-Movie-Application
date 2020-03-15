//
//  MyURLs.swift
//  MovieApp
//
//  Created by azab on 2/27/20.
//  Copyright © 2020 azab. All rights reserved.
//



//api for videos

//urlString = "https://www.youtube.com/watch?v=\(key)\

//http://api.themoviedb.org/3/movie/157336/videos?api_key=5ed906f897b5d23b23265f5a66bfb616

//api for reviews
//http://api.themoviedb.org/3/movie/157336/reviews?api_key=5ed906f897b5d23b23265f5a66bfb616
// my Key : 5ed906f897b5d23b23265f5a66bfb616
//my youtube key : AIzaSyDUGkG1iCIWzRDaI38p1Oy06A-F5pNyaN4

import Foundation

class MyURLs {
    
    //make take parameter like popularity & review to sort movies
    func movieURLOrderBy(str : String) -> String {
        return "https://api.themoviedb.org/3/discover/movie?sort_by="+str+".desc&api_key=5ed906f897b5d23b23265f5a66bfb616"
    }
    
    func videosUrl(id : Int) -> String {
        return "https://api.themoviedb.org/3/movie/"+String(id)+"/videos?api_key=5ed906f897b5d23b23265f5a66bfb616"
    }
    
    func reviewsUrl(id : Int) -> String {
        return "https://api.themoviedb.org/3/movie/"+String(id)+"/reviews?api_key=5ed906f897b5d23b23265f5a66bfb616"
    }
}

