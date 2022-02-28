//
//  SearchSongInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Pavel Olegovich on 28.02.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation

protocol SearchSongInteractorInput {
    func requestSong(with query: String, completion: @escaping (Result<[ITunesSong], Error>) -> Void )
}

class SearchSongInteractor: SearchSongInteractorInput {
    
    private let searchSrvice = ITunesSearchService()
    
    func requestSong(with query: String, completion: @escaping (Result<[ITunesSong], Error>) -> Void) {
        searchSrvice.getSongs(forQuery: query, completion: completion)
    }
}
