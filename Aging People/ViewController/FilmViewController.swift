//
//  FielmViewController.swift
//  Aging People
//
//  Created by 라완 💕 on 12/05/1444 AH.
//

import UIKit

class FilmViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    var allFilms: Films?
    var films: [FilmResult] = []
    
    
    
    @IBOutlet weak var filemTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return films.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let main = films[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "FilmTableViewCell", for: indexPath) as! FilmTableViewCell
        cell.filem.text = main.title
        
        return cell
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let movieView = self.storyboard?.instantiateViewController(withIdentifier: "MovieViewController") as? MovieViewController else{
            print("no View Found!!")
            return
        }
        movieView.movieURl = films[indexPath.row].url
        self.navigationController?.pushViewController(movieView, animated: true)
        
       
    
    }
    func fetch() {
        
        StarWarsModel.getAllFilms(completionHandler: {
            data, response, error in
            do {
                // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                guard let data = data else {return}
                
                let nameData = try JSONDecoder().decode(Films.self, from: data)
                self.films = nameData.results
                DispatchQueue.main.async {
                    self.filemTable.reloadData()
                }
            } catch {
                print("Something went wrong")
            }
        })
   
    }
}
    
