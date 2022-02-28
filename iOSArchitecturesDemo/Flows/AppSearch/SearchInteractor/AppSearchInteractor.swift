//
//  AppSearchInteractor.swift
//  iOSArchitecturesDemo
//
//  Created by Pavel Olegovich on 28.02.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
import Alamofire

protocol AppSearchInteractorInput {
    func requestApp(with query: String, completion: @escaping (Result<[ITunesApp], Error>) -> Void )
}

class AppSearchInteractor: AppSearchInteractorInput {
    
    private let searchService = ITunesSearchService()
    
    func requestApp(with query: String, completion: @escaping (Result<[ITunesApp], Error>) -> Void) {
        searchService.getApps(forQuery: query, then: completion)
    }
}
