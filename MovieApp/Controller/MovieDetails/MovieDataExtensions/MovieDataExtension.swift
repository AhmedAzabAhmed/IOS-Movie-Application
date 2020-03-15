//
//  MovieDataExtension.swift
//  MovieApp
//
//  Created by azab on 3/10/20.
//  Copyright © 2020 azab. All rights reserved.
//

import Foundation
import UIKit

extension MovieData : UICollectionViewDelegate, UICollectionViewDataSource, IVideosView {
    func renderMovieVideos(videos: [Videos]) {
        DispatchQueue.main.async {
            self.hideLoading()
            self.myVideos = videos
            self.videoCollectionView.reloadData()
        }
    }
    
    func showLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hideLoading() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func showErrorMessage(errorMessage: String) {
        
    }
    
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return myVideos!.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "trailer", for: indexPath) as! MovieVideoCell
        
        cell.youTubePlayer.load(videoId: myVideos![indexPath.row].key!)
        return cell
    }
    
    
}
