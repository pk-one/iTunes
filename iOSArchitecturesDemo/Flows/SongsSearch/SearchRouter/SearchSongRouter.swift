//
//  SearchSongRouter.swift
//  iOSArchitecturesDemo
//
//  Created by Pavel Olegovich on 28.02.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

protocol SearchSongRouterInput {
    func openPlayer(with song: ITunesSong)
}

class SearchSongRouter: SearchSongRouterInput {
    weak var viewController: UIViewController?
    
    func openPlayer(with song: ITunesSong) {
        let songPlayerViewController = SongPlayerViewController(song: song)
        viewController?.navigationController?.pushViewController(songPlayerViewController, animated: true)
    }
}
