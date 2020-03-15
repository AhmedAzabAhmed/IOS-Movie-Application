//
//  VideoModel.swift
//  MovieApp
//
//  Created by azab on 3/10/20.
//  Copyright © 2020 azab. All rights reserved.
//

import Foundation
import Network
import Alamofire
import SwiftyJSON

class VideoModel {
    
    // POJOs Object to hold data
    var myVideo:Videos?
    
    //Array to Hold POJOs Oblects
    var videoArr:[Videos]?
    
    var arrRes = [[String:AnyObject]]()
    
    //reference to presenter
    var videoPresenter : IVideoPresenter?
    
    init(videoPresenter : IVideoPresenter?) {
        self.videoPresenter = videoPresenter
    }
    
    //check internet Connection
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "InternetConnectionMonitor")
    
    func showVideos(id : Int) {
        
        //check internet Connection
        monitor.pathUpdateHandler = { pathUpdateHandler in
            if pathUpdateHandler.status == .satisfied {
                print("Internet connection is on.")
                
                self.retrieveMovieVideos(id: id)
            } else {
                print("There's no internet connection.")
            }
        }
        
        monitor.start(queue: queue)
    }
    
    func retrieveMovieVideos(id : Int) {
        
        videoArr = [Videos]()
        
        let url : MyURLs = MyURLs()
        let s : String = url.videosUrl(id: id)
        Alamofire.request(s).responseJSON { (responseData) -> Void in
            if((responseData.result.value) != nil) {
                let swiftyJsonVar = JSON(responseData.result.value!)
                if let resData = swiftyJsonVar["results"].arrayObject {
                    self.arrRes = resData as! [[String:AnyObject]]
                    
                    for i in self.arrRes {
                        self.myVideo = Videos(key: i["key"] as! String, name: i["name"] as! String)
                        self.videoArr?.append(self.myVideo!)
                    }
                    //set Delegate
                    self.videoPresenter?.setVideos(videos: self.videoArr!)
                }
            }
        }
    }
    
}
