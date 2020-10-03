//
//  MovieGridDetailsViewController.swift
//  Flix
//
//  Created by SB on 10/2/20.
//  Copyright © 2020 SB. All rights reserved.
//

import UIKit

class MovieGridDetailsViewController: UIViewController {
    
    @IBOutlet weak var backdropImageView: UIImageView!
    @IBOutlet weak var posterImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var synopsisLabel: UILabel!
    
    
    var movie: [String: Any]!
    var movieTrailerURL = ""
    var trailerKey = ""

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        titleLabel.text = movie["title"] as? String
        synopsisLabel.text = movie["overview"] as? String
        
        let baseURL = "https://image.tmdb.org/t/p/w185"
        
        let posterPath = movie["poster_path"] as! String
        let posterURL = URL(string: baseURL + posterPath)
        posterImageView.af.setImage(withURL: posterURL!)
        
        
        let backdropPath = movie["backdrop_path"] as! String
        let backdropURL = URL(string: "https://image.tmdb.org/t/p/w780" + backdropPath)
        backdropImageView.af.setImage(withURL: backdropURL!)
        
        
        // Get the YouTube video key for the movie trailer from the Get Videos end point
        let movieID = movie["id"] as! Int
        let url = URL(string: "https://api.themoviedb.org/3/movie/\(movieID)/videos?api_key=a07e22bc18f5cb106bfe4cc1f83ad8ed")!
        let request = URLRequest(url: url, cachePolicy: .reloadIgnoringLocalCacheData, timeoutInterval: 10)
        let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: request) { (data, response, error) in
            // This will run when the network request returns
            if let error = error {
                print(error.localizedDescription)
                
            } else if let data = data {
                let dataDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String: Any]
                
                let results = dataDictionary["results"] as! [[String:Any]]
                
                self.trailerKey = results[0]["key"] as! String
                print("trailerKey after didTapPoster \(self.trailerKey)")
           }
        }
        task.resume()
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBAction func didTapPoster(_ sender: UITapGestureRecognizer) {
        performSegue(withIdentifier: "showTrailer", sender: nil)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segue.identifier {
        case "showTrailer":
            print("trailerKey about to be passed \(self.trailerKey)")
            let trailerViewController = segue.destination as! TrailerViewController
            trailerViewController.trailerKey = trailerKey
        default:
            preconditionFailure("Unexpected segue identifier")
        }
    }
    
}
