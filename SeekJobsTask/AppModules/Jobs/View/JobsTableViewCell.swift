//
//  JobsTableViewCell.swift
//  SeekJobsTask
//
//  Created by Anup kumar sahu on 24/02/24.
//

import Foundation
import UIKit

class JobsTableViewCell: UITableViewCell {
    
    lazy var cardView: UIView = {
        let view = UIView()
        view.backgroundColor = HexColor.getUIColor(
            AppConstants.UIColors.hexStringCellBackground
        )
        view.layer.cornerRadius = 10
        view.layer.shadowColor = UIColor.black.cgColor
        view.layer.shadowOpacity = 0.5
        view.layer.shadowOffset = CGSize(width: 0, height: 2)
        view.layer.shadowRadius = 4
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.boldSystemFont(ofSize: 16)
        label.textColor = HexColor.getUIColor(AppConstants.UIColors.hexStringTextPrimary)
        return label
    }()
    
    lazy var subtitleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 12)
        label.textColor = HexColor.getUIColor(AppConstants.UIColors.hexStringTextSecondary)
        return label
    }()
    
    lazy var descriptionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 14)
        label.textColor = HexColor.getUIColor(AppConstants.UIColors.hexStringTextPrimary)
        label.numberOfLines = 2
        return label
    }()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupCardView()
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        setupCardView()
        setupUI()
    }
    
    private func setupCardView() {
        addSubview(cardView)
        
        NSLayoutConstraint.activate([
            cardView.topAnchor.constraint(equalTo: topAnchor, constant: 8),
            cardView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 16),
            cardView.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -16),
            cardView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8)
        ])
        
    }
    
    private func setupUI() {
        cardView.addSubview(titleLabel)
        cardView.addSubview(subtitleLabel)
        cardView.addSubview(descriptionLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: cardView.topAnchor, constant: 16),
            titleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            titleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 8),
            subtitleLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            subtitleLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            
            descriptionLabel.topAnchor.constraint(equalTo: subtitleLabel.bottomAnchor, constant: 12),
            descriptionLabel.leadingAnchor.constraint(equalTo: cardView.leadingAnchor, constant: 16),
            descriptionLabel.trailingAnchor.constraint(equalTo: cardView.trailingAnchor, constant: -16),
            descriptionLabel.bottomAnchor.constraint(equalTo: cardView.bottomAnchor, constant: -16),
        ])
    }
    
    func configure(withTitle title: String, subtitle: String, description: String) {
        titleLabel.text = title
        subtitleLabel.text = subtitle
        descriptionLabel.text = description
    }
}
