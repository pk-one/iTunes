//
//  AppDetailHeaderViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Veaceslav Chirita on 21.02.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

class AppDetailHeaderViewController: UIViewController {
    
    private let app: ITunesApp
    private lazy var imageDownloader = ImageDownloader()
    
    private var appDetailHeaderView: AppDetailHeaderView {
        return self.view as! AppDetailHeaderView
    }
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = AppDetailHeaderView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillData()
    }
    
    private func fillData() {
        dowloadImage()
        
        appDetailHeaderView.titleLabel.text = app.appName
        appDetailHeaderView.subTitleLabel.text = app.company ?? ""
        appDetailHeaderView.ratingLabel.text = app.averageRating.flatMap { "\($0)" }
    }
    
    private func dowloadImage() {
        guard let url = app.iconUrl else { return }
        imageDownloader.getImage(fromUrl: url) { [weak self] result in
            
            switch result {
            case .success(let image):
                DispatchQueue.main.async {
                    self?.appDetailHeaderView.imageView.image = image
                }
            case .failure(let error):
                print(error)
            }
            
            
        }
    }
}
