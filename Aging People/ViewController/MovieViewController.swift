//
//  MovieViewController.swift
//  Aging People
//
//  Created by 라완 💕 on 17/05/1444 AH.
//

import UIKit

class MovieViewController: UIViewController {
    @IBOutlet weak var tittle: UILabel!
    @IBOutlet weak var releaseData: UILabel!
    @IBOutlet weak var director: UILabel!
    @IBOutlet weak var openingCrawl: UILabel!
    
    var movieURl = String()
    var movie: FilmResult?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        // Do any additional setup after loading the view.
    }
    func getMovie(){
        //Title, Release Date, Director, Opening Crawl
        tittle.text = movie?.title
        releaseData.text = movie?.releaseDate
        director.text = movie?.director
        openingCrawl.text = movie?.openingCrawl
   
    }

    func fetch(){
        StarWarsModel.getAMovie(movieUrl: movieURl, compoletionHandler: { data, response, error in
            guard let data = data else {return}
            do {
                let movieData = try JSONDecoder().decode(FilmResult.self, from: data)
                self.movie = movieData
                DispatchQueue.main.async {
                    self.getMovie()
                }
                
                
                print(movieData)
            }catch
            {
                print("error in person data \(error)")
            }
        })
    }

}
