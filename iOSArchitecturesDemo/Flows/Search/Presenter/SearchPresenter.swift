//
//  SearchPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Veaceslav Chirita on 21.02.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
import UIKit

protocol SearchViewInput: AnyObject {
    var searchResults: [ITunesApp] { get set }
    
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
}

protocol SearchViewOutput: AnyObject {
    func viewDidSearch(with query: String)
    func viewDidSelectApp(app: ITunesApp)
}

class SearchPresenter {
    
    weak var viewInput: (UIViewController & SearchViewInput)?
    private let searchService = ITunesSearchService()
    
    private func requestApps(with query: String) {
        searchService.getApps(forQuery: query) { [weak self] (result) in
            guard let self = self else { return }
            
            self.viewInput?.throbber(show: false)
            
            switch result {
            case .success(let apps):
                guard !apps.isEmpty else {
                    self.viewInput?.searchResults = []
                    self.viewInput?.showNoResults()
                    return
                }
                self.viewInput?.hideNoResults()
                self.viewInput?.searchResults = apps
            case .failure(let error):
                self.viewInput?.showError(error: error)
            }
        }
    }
    
    private func openDetails(with app: ITunesApp) {
        let appDetaillViewController = AppDetailViewController(app: app)
        viewInput?.navigationController?.pushViewController(appDetaillViewController, animated: true)
    }
    
}

extension SearchPresenter: SearchViewOutput {
    func viewDidSearch(with query: String) {
        viewInput?.throbber(show: true)
        requestApps(with: query)
    }
    
    func viewDidSelectApp(app: ITunesApp) {
        openDetails(with: app)
    }
}
