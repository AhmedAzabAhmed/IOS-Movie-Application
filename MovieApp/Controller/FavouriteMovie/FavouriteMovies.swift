//
//  FavouriteMovies.swift
//  MovieApp
//
//  Created by azab on 2/27/20.
//  Copyright © 2020 azab. All rights reserved.
//

import UIKit

class FavouriteMovies: UITableViewController {
    
    
    var favCore = CoreDataORM()
    var myFavMovies : [Movie] = []
    
    var movieDataFav : MovieData?
    
    override func viewWillAppear(_ animated: Bool) {
        myFavMovies = favCore.fetchData(entity: "FavouriteEntity")
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        movieDataFav = self.storyboard?.instantiateViewController(identifier: "movieData")
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        
        return myFavMovies.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "favCell", for: indexPath)
        
        // Configure the cell...
        cell.imageView?.sd_setImage(with:URL(string: myFavMovies[indexPath.row].posterPath!), placeholderImage:UIImage(named: ""))
        cell.textLabel?.text = myFavMovies[indexPath.row].originalTitle
        cell.textLabel?.textColor = UIColor.yellow
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        movieDataFav?.id = myFavMovies[indexPath.row].id
               movieDataFav?.rating = myFavMovies[indexPath.row].voteAverage
               movieDataFav?.movieTitle = myFavMovies[indexPath.row].originalTitle
               movieDataFav?.moviePoster = myFavMovies[indexPath.row].posterPath
               movieDataFav?.movieDate = myFavMovies[indexPath.row].releaseDate
               movieDataFav?.movieOverview = myFavMovies[indexPath.row].overview
               movieDataFav?.moviePopularity = myFavMovies[indexPath.row].popularity
               
               self.navigationController?.pushViewController(movieDataFav!, animated: true)
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    
}
