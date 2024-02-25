//
//  JobDetailViewController.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 25/02/24.
//

import UIKit

import UIKit

class JobDetailViewController: UIViewController {

    private lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 18)
        label.accessibilityIdentifier = "JobTitleIdentifier"
        return label
    }()

    private lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.numberOfLines = 0
        label.accessibilityIdentifier = "JobDecriptionIdentifier"
        return label
    }()

    private lazy var locationLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .white
        label.accessibilityIdentifier = "JobLocationIdentifier"
        return label
    }()

    private lazy var applyButton: UIButton = {
        let button = UIButton(type: .system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle(JobsConstants.textConstants.jobsApply, for: .normal)
        button.backgroundColor = HexColor.getUIColor(AppConstants.UIColors.hexStringActionButton)
        button.accessibilityIdentifier = "ApplyButton"
        button.tintColor = .white
        button.layer.cornerRadius = 8
        button.layer.borderWidth = 1
        button.layer.borderColor = UIColor.white.cgColor
        button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
        return button
    }()

    // MARK: - Properties

    var jobDetailViewModel: JobDetailViewModel?

    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()
        configureNavUI()
        configureUI()
        configureLabels()
    }

    // MARK: - UI Setup

    private func configureUI() {
        view.backgroundColor = HexColor.getUIColor(
            AppConstants.UIColors.hexStringBackground
        )

        // Add UI elements to the view
        view.addSubview(titleLabel)
        view.addSubview(descriptionLabel)
        view.addSubview(locationLabel)
        view.addSubview(applyButton)

        // Setup constraints
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 20),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            descriptionLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 20),
            descriptionLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            descriptionLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            locationLabel.topAnchor.constraint(equalTo: descriptionLabel.bottomAnchor, constant: 20),
            locationLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            locationLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),

            applyButton.topAnchor.constraint(equalTo: locationLabel.bottomAnchor, constant: 30),
            applyButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            applyButton.widthAnchor.constraint(equalToConstant: 120),
            applyButton.heightAnchor.constraint(equalToConstant: 40)
        ])
    }
    
    private func configureNavUI() {
        
        if let navigationController = navigationController {
            navigationController.navigationBar.barTintColor = HexColor.getUIColor(
                AppConstants.UIColors.hexStringBackground
            )
            navigationController.navigationBar.tintColor = UIColor.white
            navigationController.navigationBar.titleTextAttributes = [NSAttributedString.Key.foregroundColor: UIColor.white]
            navigationItem.title = JobsConstants.textConstants.jobsDetailTitle
            navigationController.navigationBar.accessibilityIdentifier = "JobDetails"
        }
    }

    private func configureLabels() {
        titleLabel.text = jobDetailViewModel?.jobDetailModel.jobTitle
        descriptionLabel.text = jobDetailViewModel?.jobDetailModel.jobDescription
        locationLabel.text = "Location: \(jobDetailViewModel?.jobDetailModel.jobLocation ?? "")"
    }

    // MARK: - Button Action

    @objc private func applyButtonTapped() {}
}

