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
        tableView.backgroundColor = HexColor.getUIColor(
            AppConstants.UIColors.hexStringTableBackground
        )
        tableView.separatorStyle = .none
        return tableView
    }()
    
    var jobsViewModel: JobsViewModel?
    
    let jobsCellStrIdentifier = JobsConstants.TableCellIdentifiers.jobsTableCell
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavUI()
        configureUI()
    }
    
    private func configureUI() {
        
        view.backgroundColor = HexColor.getUIColor(
            AppConstants.UIColors.hexStringBackground
        )
        
        tableView.register(JobsTableViewCell.self, forCellReuseIdentifier: jobsCellStrIdentifier)
        
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
    }
    
    private func configureNavUI() {
        
        if let navigationController = navigationController {
            navigationController.navigationBar.barTintColor = HexColor.getUIColor(
                AppConstants.UIColors.hexStringBackground
            )
            navigationController.navigationBar.tintColor = UIColor.white
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationItem.title = JobsConstants.textConstants.jobsTitle
        }
    }
    
}

extension JobsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: jobsCellStrIdentifier, for: indexPath) as! JobsTableViewCell
        
        cell.configure(withTitle: "Title", subtitle: "Subtitle", description: "Description")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("Selected item: \(items[indexPath.row])")
    }
}

