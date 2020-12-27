//
//  CasesViewController.swift
//  covid-19
//
//  Created by Oleg Gribovsky on 11/2/20.
//

import UIKit




class CasesViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    private var cases: [Case] = []
    var casesTableView: UITableView!
    let casesDetailViewController = CasesDetailViewController()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "Cases"

        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
 
        
        guard let url = URL(string: "https://api.apify.com/v2/key-value-stores/tVaYRsPHLjNdNBu7S/records/LATEST?disableRedirect=true") else {return}

        let urlRequest  = URLRequest(url: url)
        print("ready")
        let datatask = session.dataTask(with: urlRequest) { (data,respond,error) in

        if let error = error{
            print(error)
        }
//            if let respond = respond{
//        }
        if let data = data {
            let decoder = JSONDecoder()

            if let jsonCases = try? decoder.decode([Case].self, from: data){
                self.cases = jsonCases
                    DispatchQueue.main.async {
                        self.casesTableView.reloadData()
                    }
            }
        }
        }
        datatask.resume()

        casesTableView = UITableView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        casesTableView.register(CasesTableViewCell.self, forCellReuseIdentifier: "MyCell")
        casesTableView.dataSource = self
        casesTableView.delegate = self
        self.view.addSubview(casesTableView)
   
        
    }

    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        casesDetailViewController.privateCase = cases[indexPath.row]
      //  self.navigationController?.pushViewController(casesDetailViewController, animated: true)
       
    }
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cases.count
    }

    
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MyCell", for: indexPath as IndexPath)
        var cellText: String = ""
        let country = cases[indexPath.row].country
        cellText.append(country)
        if let infected = cases[indexPath.row].infected {
                cellText.append(" - infected \(infected)")
            } else {
               // cellText.append(" N/A")
            }
        if let recovered = cases[indexPath.row].recovered {
            cellText.append(", recovered \(recovered)")
        } else
        {
              //  cellText.append(" N/A")
        }
        cell.textLabel!.text = cellText
        return cell
    }
}
