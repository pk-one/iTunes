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
    
    static func songCellModel(from model: ITunesSong, completion: @escaping (SongCellModel) -> Void) {
        downloadImage(model: model) { imageFromURL in
            let cellModel = SongCellModel(trackName: model.trackName, artistName: model.artistName, collectionName: model.collectionName, songImage: imageFromURL)
            completion(cellModel)
        }
    }
    
    static private func downloadImage(model: ITunesSong, completion: @escaping (UIImage) -> Void) {
        guard let songImageURL = model.songImageURL, let url = URL(string: songImageURL) else { return }
        imageDownloader.getImage(fromUrl: url) { result in
            switch result {
            case .success(let image):
                completion(image)
            case .failure(let error):
                print(error)
            }
        }
    }
}
