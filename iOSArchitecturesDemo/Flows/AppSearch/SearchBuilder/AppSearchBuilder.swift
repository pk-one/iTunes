//
//  SearchBuilder.swift
//  iOSArchitecturesDemo
//
//  Created by Veaceslav Chirita on 21.02.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
import UIKit

class AppSearchBuilder {
    
    static func build() -> (UIViewController & AppSearchPresenterInput) {
        
        let interactor = AppSearchInteractor()
        let router = AppSearchRouter()
        let presenter = AppSearchPresenter(interactor: interactor, router: router)
        
        let viewController = SearchAppViewController(searchPresenter: presenter)
        router.viewController = viewController
        presenter.viewInput = viewController
        return viewController
    }
    
}
