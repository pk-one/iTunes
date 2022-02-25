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
    
    static func build() -> (UIViewController & SearchAppViewInput) {
        let presenter = SearchAppPresenter()
        let viewController = SearchAppViewController(searchPresenter: presenter)
        
        presenter.viewInput = viewController
        return viewController
    }
    
}
