//
//  CoreDataORM.swift
//  MovieApp
//
//  Created by azab on 3/13/20.
//  Copyright © 2020 azab. All rights reserved.
//

import Foundation
import UIKit
import CoreData

class CoreDataORM {
    
    func insertInCoreData(data : [Movie]) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "MovieEntity", in: managedContext)
        
        for d in data {
            let movieSaved = NSManagedObject(entity: entity!, insertInto: managedContext)
            movieSaved.setValue(d.id, forKey: "id")
            movieSaved.setValue(d.originalTitle, forKey: "originalTitle")
            movieSaved.setValue(d.overview, forKey: "overview")
            movieSaved.setValue(d.popularity, forKey: "popularity")
            movieSaved.setValue(d.posterPath, forKey: "posterPath")
            movieSaved.setValue(d.releaseDate, forKey: "releaseDate")
            movieSaved.setValue(d.voteAverage, forKey: "voteAverage")
        }
        do{
            try managedContext.save()
        }catch let error as NSError {
            print(error)
        }
    }
    
    func deleteAllData() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "MovieEntity")
        fetchRequest.returnsObjectsAsFaults = false
        
        do
        {
            let results = try managedContext.fetch(fetchRequest)
            for managedObject in results
            {
                let managedObjectData:NSManagedObject = managedObject as! NSManagedObject
                managedContext.delete(managedObjectData)
            }
        } catch let error as NSError {
            print("Detele all data error : \(error) \(error.userInfo)")
        }
    }
    
    func fetchData(entity : String) -> [Movie]{
        
        var movieD: [NSManagedObject] = []
        var myData : Movie
        var cachedMovies = [Movie]()
        var appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: entity)
        
        //3
        do {
            movieD = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        for m in movieD{
            myData = Movie(originalTitle: m.value(forKey: "originalTitle") as! String, posterPath: m.value(forKey: "posterPath") as! String, overview: m.value(forKey: "overview") as! String, releaseDate: m.value(forKey: "releaseDate") as! String, id: m.value(forKey: "id") as! Int, voteAverage: m.value(forKey: "voteAverage") as! Double, popularity: (m.value(forKey: "popularity") as! Double))
            cachedMovies.append(myData)
        }
        return cachedMovies
    }
    
    // Favourite Movies
    
    func insertFavouriteMovie(data : Movie) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let managedContext = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "FavouriteEntity", in: managedContext)
        let movieSaved = NSManagedObject(entity: entity!, insertInto: managedContext)
        
        movieSaved.setValue(data.id, forKey: "id")
        movieSaved.setValue(data.originalTitle, forKey: "originalTitle")
        movieSaved.setValue(data.overview, forKey: "overview")
        movieSaved.setValue(data.popularity, forKey: "popularity")
        movieSaved.setValue(data.posterPath, forKey: "posterPath")
        movieSaved.setValue(data.releaseDate, forKey: "releaseDate")
        movieSaved.setValue(data.voteAverage, forKey: "voteAverage")
        
        do{
            try managedContext.save()
        }catch let error as NSError {
            print(error)
        }
    }
    
    /*func fetchFavMovie(id: Int) -> Movie{
        
        var movieD: [NSManagedObject] = []
        var myData : Movie
        var appDelegate =
            UIApplication.shared.delegate as! AppDelegate
        let managedContext =
            appDelegate.persistentContainer.viewContext
        
        //2
        let fetchRequest =
            NSFetchRequest<NSManagedObject>(entityName: "FavouriteEntity")
        
        let myPredicate = NSPredicate(format: "id == %d ", id)
        fetchRequest.predicate = myPredicate
        
        do {
            movieD = try managedContext.fetch(fetchRequest)
        } catch let error as NSError {
            print("Could not fetch. \(error), \(error.userInfo)")
        }
        
        myData = Movie(originalTitle: movieD[0].value(forKey: "originalTitle") as! String, posterPath: movieD[0].value(forKey: "posterPath") as! String, overview: movieD[0].value(forKey: "overview") as! String, releaseDate: movieD[0].value(forKey: "releaseDate") as! String, id: movieD[0].value(forKey: "id") as! Int, voteAverage: movieD[0].value(forKey: "voteAverage") as! Double, popularity: (movieD[0].value(forKey: "popularity") as! Double))
        
        return myData
    }*/
    
    func removeFavMovie(id : Int)
    {
        guard  let appDelegate =
            UIApplication.shared.delegate as? AppDelegate else{return}
        let managedContext = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName:"FavouriteEntity")
        fetchRequest.predicate = NSPredicate(format: "id = %d", id)
        do
        {
            let test = try  managedContext.fetch(fetchRequest)
            let objectToBeDeleted = test[0] as! NSManagedObject
            managedContext.delete(objectToBeDeleted)
            do{
                try managedContext.save()
            }catch{
                print(error)
            }
        }
        catch {
            print("Could not delete")
        }
    }
    
}
