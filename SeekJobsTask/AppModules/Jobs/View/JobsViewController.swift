//
//  ViewController.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 23/02/24.
//

import UIKit
import Combine

class JobsViewController: UIViewController {
    
    private lazy var tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.backgroundColor = HexColor.getUIColor(
            AppConstants.UIColors.hexStringTableBackground
        )
        tableView.separatorStyle = .none
        tableView.accessibilityIdentifier = "JobsTable"
        return tableView
    }()
    
    private lazy var profileButton: UIBarButtonItem = {
        let barButton = UIBarButtonItem(
            title: JobsConstants.textConstants.userProfileText,
            style: .plain,
            target: self,
            action: #selector(profileButtonTapped)
        )
        return barButton
    }()
    
    var jobsViewModel: JobsViewModel?
    
    private var cancellables: Set<AnyCancellable> = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavUI()
        configureProfileNavBarButton()
        configureUI()
        setupSubscriptions()
        fetchJobs()
    }
    
   private func fetchJobs() {

        jobsViewModel?.fetchActiveJobs(page: jobsViewModel?.currentPage ?? 1 , completion: { [weak self] result in
            
            switch result {
            case .success(_):
                self?.reloadTableView()
            case .failure(let error):
                print(error)
                
            }
        })
    }
    
    private func setupSubscriptions() {
        
        jobsViewModel?.jobsSubject.sink { [weak self] in
            guard let self = self else {
                return
            }
            self.fetchJobs()
        }.store(in: &cancellables)
    }
    
    private func configureUI() {
        
        view.backgroundColor = HexColor.getUIColor(
            AppConstants.UIColors.hexStringBackground
        )
        
        tableView.register(JobsTableViewCell.self, forCellReuseIdentifier: JobsTableViewCell.jobsCellStrIdentifier)
        
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
            navigationController.navigationBar.accessibilityIdentifier = "ActiveJobs"
        }
    }
    
    private func configureProfileNavBarButton() {
        navigationItem.leftBarButtonItem = profileButton
    }
    
    @objc private func profileButtonTapped() {
        jobsViewModel?.navigateToProfile()
    }
    
    private func reloadTableView() {
        DispatchQueue.main.async {
            self.tableView.reloadData()
            self.jobsViewModel?.isLoading = false
        }
    }
}

extension JobsViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return jobsViewModel?.jobList.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JobsTableViewCell.jobsCellStrIdentifier, for: indexPath) as! JobsTableViewCell
        
        configureCell(indexPath, cell)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        guard let job = jobsViewModel?.jobList[indexPath.row] else { return }
        jobsViewModel?.navigateToJobDetail(job: job)
    }
    
    fileprivate func configureCell(_ indexPath: IndexPath, _ cell: JobsTableViewCell) {
        let title = jobsViewModel?.jobList[indexPath.row].positionTitle
        
        let description = jobsViewModel?.jobList[indexPath.row].description
        
        let subtitle = jobsViewModel?.jobList[indexPath.row].id
        
        let applied = jobsViewModel?.jobList[indexPath.row].haveIApplied
        
        cell.configure(
            withTitle: title,
            subtitle: subtitle,
            description: description,
            applied: applied
        )
    }
    
}

extension JobsViewController: UIScrollViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offsetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        let screenHeight = scrollView.frame.size.height
        let threshold: CGFloat = 300
        if offsetY > contentHeight - screenHeight - threshold, 
            let joblist = jobsViewModel?.jobList {
            
             jobsViewModel?.fetchAdditionalDataIfNeeded(
                for: IndexPath(row: joblist.count - 1, section: 0)
             )
        }
    }

}

