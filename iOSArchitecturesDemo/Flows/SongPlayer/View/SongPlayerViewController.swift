//
//  SongPlayerViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Pavel Olegovich on 28.02.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
import UIKit

class SongPlayerViewController: UIViewController {
        
    private(set) lazy var logoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.contentMode = .scaleAspectFit
        imageView.layer.cornerRadius = 30
        imageView.clipsToBounds = true
        imageView.translatesAutoresizingMaskIntoConstraints = false
        return imageView
    }()
    
    private(set) lazy var titleLabel: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.textColor = .black
        label.textAlignment = .center
        label.font = UIFont.boldSystemFont(ofSize: 20)
        return label
    }()
    
    private(set) lazy var progressSongView: UIProgressView = {
        let progressView = UIProgressView()
        progressView.translatesAutoresizingMaskIntoConstraints = false
        return progressView
    }()
    
    private(set) lazy var buttonsStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.axis = .horizontal
        stackView.distribution = .fillProportionally
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    private(set) lazy var playButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "play.fill"), for: .normal)
        button.tintColor = .black
        button.tag = 0
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private(set) lazy var pauseButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "pause.fill"), for: .normal)
        button.tintColor = .black
        button.tag = 1
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private(set) lazy var stopButton: UIButton = {
        let button = UIButton(type: .system)
        button.setImage(UIImage(named: "stop.fill"), for: .normal)
        button.tintColor = .black
        button.tag = 2
        button.addTarget(self, action: #selector(buttonTapped), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    private let song: ITunesSong?
    
    private let imageDownloader = ImageDownloader()
    
    var viewModel: SongPlayerViewModel?

    init(song: ITunesSong) {
        self.song = song
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        setConstraints()
        fillData()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        self.navigationController?.navigationBar.tintColor = UIColor.white;
        self.navigationItem.largeTitleDisplayMode = .never
        view.addSubview(logoImageView)
        view.addSubview(titleLabel)
        view.addSubview(progressSongView)
        buttonsStackView.addArrangedSubview(playButton)
        buttonsStackView.addArrangedSubview(pauseButton)
        buttonsStackView.addArrangedSubview(stopButton)
        view.addSubview(buttonsStackView)
    }
    
    private func fillData() {
        titleLabel.text = song?.trackName
        
        viewModel = SongPlayerViewModel(progressSong: 0, onProgressViewChanged: { [weak self] progress in
            self?.progressSongView.setProgress(Float(progress), animated: false)
        })
        
        dowloadImage()
    }
    
    private func dowloadImage() {
        guard let url = song?.songImageURL else { return }
        imageDownloader.getImage(fromUrl: url) { [weak self] result in
            
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.logoImageView.image = image
                }
            case .failure(let error):
                print(error)
            }
        }
    }
    
    @objc private func buttonTapped(sender: UIButton) {
        switch sender.tag {
        case 0:
            viewModel?.play()
        case 1:
            viewModel?.pause()
        case 2:
            viewModel?.stop()
        default: break
        }
    }
}

//MARK: - setConstraints
extension SongPlayerViewController {
    private func setConstraints() {
        NSLayoutConstraint.activate([
            logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: 30),
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.widthAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7),
            logoImageView.heightAnchor.constraint(equalTo: view.widthAnchor, multiplier: 0.7)
        ])
        
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 10),
            titleLabel.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            titleLabel.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            progressSongView.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 10),
            progressSongView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            progressSongView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            progressSongView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
        
        NSLayoutConstraint.activate([
            buttonsStackView.topAnchor.constraint(equalTo: progressSongView.bottomAnchor, constant: 20),
            buttonsStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            buttonsStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            buttonsStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20)
        ])
    }
}
