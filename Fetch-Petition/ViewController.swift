//
//  ViewController.swift
//  Fetch-Petition
//
//  Created by Bahittin on 3.08.2023.
//

import UIKit

class ViewController: UITableViewController {
    var petitions = [Petition]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        let urlString = "https://www.hackingwithswift.com/samples/petitions-1.json"
        
        if let url = URL(string: urlString) {
            let session = URLSession(configuration: .default)
            let task = session.dataTask(with: url) {( data, response, error) in
                if error != nil {
                    print(error!)
                    return
                }
                if let data = data {
                    // Veriyi işleme
                    // JSON verisini çözümle
                    self.parse(json: data)
                }
            }
            task.resume()
        }
    }
    func parse(json: Data) {
        let decoder = JSONDecoder()
        let jsonPetitions = try? decoder.decode(Petitions.self, from: json)
        self.petitions = jsonPetitions!.results
        print("deneme: \(self.petitions[0])")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return petitions.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell",for: indexPath)
        let petition = petitions[indexPath.row]
        cell.textLabel?.text = petition.title
        cell.detailTextLabel?.text = petition.body
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
}

