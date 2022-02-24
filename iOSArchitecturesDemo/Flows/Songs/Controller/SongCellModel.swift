//
//  SongCellModel.swift
//  iOSArchitecturesDemo
//
//  Created by Pavel Olegovich on 23.02.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation
import UIKit

struct SongCellModel {
    public var trackName: String
    public var artistName: String?
    public var collectionName: String?
    public var songImage: UIImage?
}

final class SongCellModelFactory {
    
    static private let imageDownloader = ImageDownloader()
    static private var songImageByUrl: UIImage?
    
    static func songCellModel(from model: ITunesSong) -> SongCellModel {
        downloadImage(model: model)
        return SongCellModel(trackName: model.trackName, artistName: model.artistName, collectionName: model.collectionName, songImage: songImageByUrl)
    }
    
    static private func downloadImage(model: ITunesSong) {
        guard let songImageURL = model.songImageURL, let url = URL(string: songImageURL) else { return }
        imageDownloader.getImage(fromUrl: url) { result in
            switch result {
            case .success(let image):
                self.songImageByUrl = image
            case .failure(let error):
                print(error)
            }
        }
    }
}
