//
//  HomeMovies.swift
//  MovieApp
//
//  Created by azab on 2/27/20.
//  Copyright © 2020 azab. All rights reserved.
//

import UIKit
import SDWebImage
import Network
import DropDown


private let reuseIdentifier = "Cell"

class HomeMovies: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    var movieData : MovieData?
    
    var myMovies : [Movie]?
    
    let dropDown = DropDown()
    
    
    @IBOutlet weak var menuBtn: UIBarButtonItem!
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    @IBAction func showMenu(_ sender: Any) {
        dropDown.show()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let homePresenter : HomePresenter = HomePresenter(homeView: self)
        homePresenter.getMovies(orderBy: "popularity")
        showLoading()
        myMovies = [Movie]()
        
        movieData = self.storyboard?.instantiateViewController(identifier: "movieData")
        
        dropDown.anchorView = menuBtn // UIView or UIBarButtonItem
        // The list of items to display. Can be changed dynamically
        dropDown.dataSource = ["Populatity", "Vote Average"]
        
        // Action triggered on selection
        dropDown.selectionAction = { [unowned self] (index: Int, item: String) in
            if item == "Populatity"{
                self.showLoading()
                //myNetwork.getConnection(URL: self.BaseURL);
                homePresenter.getMovies(orderBy: "popularity")
                self.collectionView.reloadData()
            }else{
                self.showLoading()
                homePresenter.getMovies(orderBy: "vote_average")
                self.collectionView.reloadData()
            }
            print("Selected item: \(item) at index: \(index)")
        }
        // Will set a custom width instead of the anchor view width
        dropDown.width = 200
        //   dropDown.hide()
        
    }
    
    // MARK: UICollectionViewDataSource
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of items
        return myMovies!.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: reuseIdentifier, for: indexPath) as! MovieCollectionCell
        
        
        if myMovies![indexPath.row].posterPath! == "https://image.tmdb.org/t/p/w185a.jpg"{
            cell.movieImage.image = UIImage(named: "a.jpg")
        }else{
            cell.movieImage.sd_setImage(with:URL(string: myMovies![indexPath.row].posterPath!), placeholderImage:UIImage(named: "a.jpg"))
        }
        
        cell.movieImage.layer.cornerRadius = 10
        //        cell.labRating.rating = 3
        
        cell.contentView.layer.cornerRadius = 15
        cell.contentView.layer.borderWidth = 5.0
        //        cell.contentView.layer.borderColor = UIColor.white.cgColor
        cell.contentView.layer.borderColor = UIColor.clear.cgColor
        
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        movieData?.id = myMovies![indexPath.row].id
        movieData?.rating = myMovies![indexPath.row].voteAverage
        movieData?.movieTitle = myMovies![indexPath.row].originalTitle
        movieData?.moviePoster = myMovies![indexPath.row].posterPath
        movieData?.movieDate = myMovies![indexPath.row].releaseDate
        movieData?.movieOverview = myMovies![indexPath.row].overview
        movieData?.moviePopularity = myMovies![indexPath.row].popularity
        
        self.navigationController?.pushViewController(movieData!, animated: true)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        //        let viewHeight = view.frame.size.height
        let viewWidth = view.frame.size.width
        
        if view.frame.size.width > view.frame.size.height {
            return CGSize(width: viewWidth * 0.25, height: 240)
        }
        else {
            return CGSize(width: (viewWidth * 0.5), height: 240)
        }
    }
}
extension HomeMovies : IHomeView{
    
    func renderHomeWithMovies(movies: [Movie]) {
        DispatchQueue.main.async {
            self.hideLoading()
            self.myMovies = movies
            self.collectionView.reloadData()
        }
    }
    
    func showLoading() {
        
        activityIndicator.isHidden = false
        activityIndicator.startAnimating()
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func hideLoading() {
        activityIndicator.stopAnimating()
        activityIndicator.isHidden = true
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
    
    func showErrorMessage(errorMessage: String) {
        
    }
}
