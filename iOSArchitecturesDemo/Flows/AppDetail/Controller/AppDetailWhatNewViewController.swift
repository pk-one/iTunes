//
//  AppDetailWhatNewViewController.swift
//  iOSArchitecturesDemo
//
//  Created by Pavel Olegovich on 23.02.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
import UIKit

class AppDetailWhatNewViewController: UIViewController {
    
    private let app: ITunesApp
    
    private var appDetailWhatNewView: AppDetailWhatNewView {
        return self.view as! AppDetailWhatNewView
    }
    
    init(app: ITunesApp) {
        self.app = app
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func loadView() {
        self.view = AppDetailWhatNewView()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fillData()
    }
    
    private func fillData() {
        appDetailWhatNewView.versionLabel.text = "Version " + app.version
        appDetailWhatNewView.lastUpdateVersionLabel.text = app.currentVersionReleaseDate 
        appDetailWhatNewView.releaseNotesLabel.text = app.releaseNotes
    }
}
