//
//  SongSearchBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Pavel Olegovich on 23.02.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
import UIKit

class SongSearchBuilder {

    static func build() -> (UIViewController & SearchSongViewInput) {
        let searchService = ITunesSearchService()
        let interactor = SearchSongInteractor(searchService: searchService)
        let router = SearchSongRouter()
        let songPresenter = SearchSongPresenter(interactor: interactor, router: router)
        let viewController = SearchSongViewController(searchPresenter: songPresenter)
        router.viewController = viewController
        
        songPresenter.viewInput = viewController
        return viewController
    }
}
