//
//  PersonViewController.swift
//  Aging People
//
//  Created by 라완 💕 on 17/05/1444 AH.
//

import UIKit

class PersonViewController: UIViewController {
    @IBOutlet weak var name: UILabel!
    @IBOutlet weak var gender: UILabel!
    @IBOutlet weak var bearthYear: UILabel!
    @IBOutlet weak var mass: UILabel!
    @IBOutlet weak var species: UILabel!
    
    var speciyName: String?
    var personUrl = String()
    var person: Result?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetch()
        // Do any additional setup after loading the view.
    }
    
    func setPersonData(){
        name.text = "Name: "+(person?.name ?? "N/A")
        gender.text = "Gender: "+(person?.gender.rawValue ?? "N/A")
        mass.text = "Mass: "+(person?.mass ?? "N/A")
        bearthYear.text = "BirthYear: "+(person?.birthYear ?? "N/A")
        species.text = "N/A"
        
    }
    
    func fetch(){
        StarWarsModel.getAPerson(personUrl: personUrl, compoletionHandler: {
            data, response, error in
            guard let data = data else {return}
            do {
                let personData:Result  = try JSONDecoder().decode(Result.self, from: data)
                self.person = personData
                DispatchQueue.main.async {
                    self.setPersonData()
                    
                }
                
                
                print(personData)
            }catch
            {
                print("error in person data \(error)")
            }
            
        })
    }

}
