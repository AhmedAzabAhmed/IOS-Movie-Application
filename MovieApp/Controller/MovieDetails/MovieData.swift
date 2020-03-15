//
//  MovieData.swift
//  MovieApp
//
//  Created by azab on 2/29/20.
//  Copyright © 2020 azab. All rights reserved.
//

import UIKit
import SDWebImage
import Cosmos

class MovieData: UITableViewController {
    
    
    var favCore = CoreDataORM()
    
    @IBOutlet weak var videoCollectionView: UICollectionView!
    
    var myVideos : [Videos]?
    
    var id : Int?
    
    var moviePoster : String?
    var movieTitle : String?
    var movieDate : String?
    var movieOverview : String?
    var rating : Double?
    var moviePopularity : Double?
    
    @IBOutlet weak var posterView: UIImageView!
    
    @IBOutlet weak var titleLbl: UILabel!
    
    @IBOutlet weak var dateLbl: UILabel!
    
    @IBOutlet weak var overviewLbl: UILabel!
    
    @IBOutlet weak var cosmosView: CosmosView!
    
    
    // to round btn review corners
    @IBOutlet weak var reviewBtnRound: UIButton!
    
    @IBAction func showReviewsBtn(_ sender: Any) {
        
        let reviewsView : ReviewsTableView = (self.storyboard?.instantiateViewController(identifier: "reviewsView"))!
        
        reviewsView.id = id
        
        navigationController?.pushViewController(reviewsView, animated: true)
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
        // to round btn review corners
        reviewBtnRound.layer.cornerRadius = 15
        reviewBtnRound.clipsToBounds = true
        
        cosmosView.rating = Double(rating!/2)
        
        // Called when user finishes changing the rating by lifting the finger from the view.
        // This may be a good place to save the rating in the database or send to the server.
        cosmosView.didFinishTouchingCosmos = { rating in }        
        posterView.sd_setImage(with:URL(string:moviePoster!), placeholderImage:UIImage(named: "a.jpg"))
        titleLbl.text = movieTitle
        dateLbl.text = movieDate
        overviewLbl.text = movieOverview
        
        let videosPresenter : VideosPresenter = VideosPresenter(videoView: self)
        showLoading()
        videosPresenter.getVideos(id: id!)
        myVideos = [Videos]()
            
        let  check = UserDefaults.standard.object(forKey: "\(String(describing: id))") as? String
        
        if check == "true" {
            favouriteBtn.tintColor = UIColor.red
        } else {
            favouriteBtn.tintColor = UIColor.white
        }
        
    }
    
    
    //favourite button
    @IBOutlet weak var favouriteBtn: UIButton!
    
    @IBAction func addToFavourite(_ sender: Any) {
        
        favouriteBtn.tintColor = UIColor.red
        
        let myFavMovie = Movie(originalTitle: movieTitle!, posterPath: moviePoster!, overview: movieOverview!, releaseDate: movieDate!, id: id!, voteAverage: rating!, popularity: moviePopularity)
        
        //UserDefaults.standard.set("false", forKey: "click")
        let  click = UserDefaults.standard.object(forKey: "\(String(describing: id))") as? String
        
        if click == "false" || click == nil{
            UserDefaults.standard.set("true", forKey: "\(String(describing: id))")
            favouriteBtn.tintColor = UIColor.red
            favCore.insertFavouriteMovie(data: myFavMovie)
            
        } else if click == "true" {
            UserDefaults.standard.set("false", forKey: "\(String(describing: id))")
            favouriteBtn.tintColor = UIColor.white
            favCore.removeFavMovie(id: id!)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
}

