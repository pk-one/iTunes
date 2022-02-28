//
//  AppSearchPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Pavel Olegovich on 28.02.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

protocol AppSearchPresenterInput: AnyObject {
    var searchResults: [ITunesApp] { get set }
    
    func throbber(show: Bool)
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
}

protocol AppSearchPresenterOutput: AnyObject {
    func viewDidSearch(with query: String)
    func viewDidSelectApp(app: ITunesApp)
}

class AppSearchPresenter {
    weak var viewInput: (UIViewController & AppSearchPresenterInput)?
    private let interactor: AppSearchInteractorInput?
    private let router: AppSearchRouterInput?
    
    init(interactor: AppSearchInteractorInput?, router: AppSearchRouterInput?) {
        self.interactor = interactor
        self.router = router
    }

    private func openDetails(with app: ITunesApp) {
        router?.openDetails(with: app)
    }
}

extension AppSearchPresenter: AppSearchPresenterOutput {
    func viewDidSearch(with query: String) {
        viewInput?.throbber(show: true)
        interactor?.requestApp(with: query, completion: { [weak self] result in
            guard let self = self else { return }
            
            self.viewInput?.throbber(show: false)
            
            switch result {
            case let .success(apps):
                guard !apps.isEmpty else {
                    self.viewInput?.searchResults = []
                    self.viewInput?.showNoResults()
                    return
                }
                
                self.viewInput?.hideNoResults()
                self.viewInput?.searchResults = apps
                
            case let .failure(error):
                self.viewInput?.showError(error: error)
            }
        })
    }
    
    func viewDidSelectApp(app: ITunesApp) {
        openDetails(with: app)
    }
}
