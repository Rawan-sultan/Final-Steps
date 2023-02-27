//
//  ViewController.swift
//  Aging People
//
//  Created by 라완 💕 on 21/04/1444 AH.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    var names: [Result] = []
    var nameData: Name?
    

    @IBOutlet weak var nameTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return names.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let main = names[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyTableViewCell", for: indexPath) as! MyTableViewCell
        cell.nameLabel.text = main.name

            return cell
        }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let personView = self.storyboard?.instantiateViewController(withIdentifier: "PersonViewController") as? PersonViewController else{
            print("no View Found!!")
            return
        }
        personView.personUrl = names[indexPath.row].url
        self.navigationController?.pushViewController(personView, animated: true)
    }
    func fetch() {
        
        StarWarsModel.getAllPeople(completionHandler: {
            data, response, error in
            do {
                // Try converting the JSON object to "Foundation Types" (NSDictionary, NSArray, NSString, etc.)
                guard let data = data else {return}
                
                let nameData = try JSONDecoder().decode(Name.self, from: data)
                self.names += nameData.results
                
                DispatchQueue.main.async {
                    self.nameTable.reloadData()
                }
            } catch {
                print("Something went wrong")
            }
        })
    }
        
}

    

