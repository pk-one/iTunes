//
//  SearchSongPresenter.swift
//  iOSArchitecturesDemo
//
//  Created by Pavel Olegovich on 23.02.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
import UIKit

protocol SearchSongViewInput: AnyObject {
    var searchResults: [ITunesSong] { get set }
    
    func showError(error: Error)
    func showNoResults()
    func hideNoResults()
    func throbber(show: Bool)
}

protocol SearchSongViewOutput: AnyObject {
    func viewDidSearch(with query: String)
}


class SearchSongPresenter {
    weak var viewInput: (UIViewController & SearchSongViewInput)?
    private let interactor: SearchSongInteractorInput?
    
    init(interactor: SearchSongInteractorInput) {
        self.interactor = interactor
    }
}

extension SearchSongPresenter: SearchSongViewOutput {
    func viewDidSearch(with query: String) {
        viewInput?.throbber(show: true)
        interactor?.requestSong(with: query, completion: { [weak self] result in
            guard let self = self else { return }
            
            self.viewInput?.throbber(show: false)
            
            switch result {
            case .success(let songs):
                guard !songs.isEmpty else {
                    self.viewInput?.searchResults = []
                    self.viewInput?.showNoResults()
                    return
                }
                self.viewInput?.hideNoResults()
                self.viewInput?.searchResults = songs
            case .failure(let error):
                self.viewInput?.showError(error: error)
            }
        })
    }
}
