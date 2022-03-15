//
//  AppSearchRouter.swift
//  iOSArchitecturesDemo
//
//  Created by Pavel Olegovich on 28.02.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import UIKit

protocol AppSearchRouterInput {
    func openDetails(with app: ITunesApp)
}

class AppSearchRouter: AppSearchRouterInput {
    weak var viewController: UIViewController?

    func openDetails(with app: ITunesApp) {
        let appDetailViewController = AppDetailViewController(app: app)
        viewController?.navigationController?.pushViewController(appDetailViewController, animated: true)
    }
}
