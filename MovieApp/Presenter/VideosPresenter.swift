//
//  VideosPresenter.swift
//  MovieApp
//
//  Created by azab on 3/10/20.
//  Copyright © 2020 azab. All rights reserved.
//

import Foundation

class VideosPresenter : IVideoPresenter {
    
    //Object of Model
    var model : VideoModel?    
    
    //reference of Home view delegate
    var videoView : IVideosView?
    
    var myArray : [Videos]?
    
    init(videoView : IVideosView?) {
        self.videoView = videoView
        model = VideoModel(videoPresenter: self)
        myArray = [Videos]()
    }
    
    func setVideos(videos: [Videos]) {
        
        myArray = videos
         
         if myArray!.count == 0 {
             
             onFail(errorMessgae: "Fail to Retrieve Data")
             
         } else {
            onSuccess(videos: myArray!)
        }
    }
    
    func getVideos(id: Int) {
         model?.showVideos(id: id)
    }
    
    func onSuccess(videos: [Videos]) {
        videoView?.renderMovieVideos(videos: videos)
    }
    
    func onFail(errorMessgae: String) {
        
    }
}
