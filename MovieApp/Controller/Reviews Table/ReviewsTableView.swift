//
//  ReviewsTableView.swift
//  MovieApp
//
//  Created by azab on 3/12/20.
//  Copyright © 2020 azab. All rights reserved.
//

import UIKit

class ReviewsTableView: UITableViewController {
    
    var myReviews : [Reviews]?
    
    var id : Int?

    
    override func viewWillAppear(_ animated: Bool) {
        
        let reviewsPresenter : ReviewsPresenter = ReviewsPresenter(reviewsView: self)
        showLoading()
        reviewsPresenter.getReviews(id: id!)
        myReviews = [Reviews]()
    }

    override func viewDidLoad() {
        super.viewDidLoad()
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return myReviews!.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myReviews", for: indexPath)

        cell.textLabel?.text = myReviews?[indexPath.row].author
        cell.detailTextLabel?.text = myReviews?[indexPath.row].content
        return cell
    }

}
