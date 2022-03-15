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
    private var cache = Cache<NSString, [ITunesSong]>()
    private let searchService: ITunesSearchService
    
    init(searchService: ITunesSearchService) {
        self.searchService = searchService
    }
    
    func requestSong(with query: String, completion: @escaping (Result<[ITunesSong], Error>) -> Void) {
        if let songs = checkingCache(query: query) {
            completion(.success(songs))
        } else {
            searchService.getSongs(forQuery: query) { [weak self] result in
                switch result {
    
                case let .success(songs):
                    self?.cache[query as NSString] = songs
                case let .failure(error):
                    print(error.localizedDescription)
                }
            }
        }
    }
    
    private func checkingCache(query: String) -> [ITunesSong]?{
        if let cached = cache[query as NSString] {
            return cached
        }
        return nil
    }
}
