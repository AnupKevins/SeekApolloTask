//
//  ViewController.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 23/02/24.
//

import UIKit

class JobsViewController: UIViewController {
    
    let items = ["Item 1", "Item 2", "Item 3", "Item 4", "Item 5"]
    
    lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        return tableView
    }()
    
    var jobsViewModel: JobsViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        configureUI()
    }
    
    func configureUI() {
       
        view.backgroundColor = .black
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
}

extension JobsViewController: UITableViewDelegate, UITableViewDataSource {
    
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           return items.count
       }

       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
           let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
           cell.textLabel?.text = items[indexPath.row]
           return cell
       }

       func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
           print("Selected item: \(items[indexPath.row])")
       }
}

