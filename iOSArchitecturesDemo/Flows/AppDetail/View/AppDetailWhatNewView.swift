//
//  AppDetailWhatNewView.swift
//  iOSArchitecturesDemo
//
//  Created by Pavel Olegovich on 23.02.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
import UIKit
 
class AppDetailWhatNewView: UIView {
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "What's new"
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 20)
        
        return label
    }()
    
    private(set) lazy var versionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        
        return label
    }()
    
    private(set) lazy var historyVersionButton: UIButton = {
        let button = UIButton()
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("History version", for: .normal)
        return button
    }()
    
    private(set) lazy var lastUpdateVersionLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .lightGray
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        
        return label
    }()
    
    private(set) lazy var releaseNotesLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.numberOfLines = 0
        
        return label
    }()
    
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.addSubview(titleLabel)
        self.addSubview(historyVersionButton)
        self.addSubview(versionLabel)
        self.addSubview(lastUpdateVersionLabel)
        self.addSubview(releaseNotesLabel)
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            titleLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            historyVersionButton.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: 12),
            historyVersionButton.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            versionLabel.topAnchor.constraint(equalTo: historyVersionButton.bottomAnchor),
            versionLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16)
        ])
        
        NSLayoutConstraint.activate([
            lastUpdateVersionLabel.topAnchor.constraint(equalTo: versionLabel.topAnchor),
            lastUpdateVersionLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16)
        ])
        
        NSLayoutConstraint.activate([
            releaseNotesLabel.topAnchor.constraint(equalTo: lastUpdateVersionLabel.bottomAnchor, constant: 10),
            releaseNotesLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 16),
            releaseNotesLabel.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -16),
            releaseNotesLabel.bottomAnchor.constraint(equalTo: self.bottomAnchor, constant: -12)
        ])
    }
}
