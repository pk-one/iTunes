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
        let songPresenter = SearchSongPresenter()
        let viewController = SearchSongViewController(searchPresenter: songPresenter)
        
        songPresenter.viewInput = viewController
        return viewController
    }
}
