//
//  ImageDownloader.swift
//  iOSArchitecturesDemo
//
//  Created by ekireev on 19.02.2018.
//  Copyright © 2018 ekireev. All rights reserved.
//

import UIKit
import Alamofire

typealias DownloadImageCompletion = (Result<UIImage, Error>) -> Void

final class ImageDownloader {
    
    public func getImage(fromUrl url: URLConvertible, completion: @escaping DownloadImageCompletion) {
        AF.request(url).response(completionHandler: { (dataResponse) in
            if let error = dataResponse.error {
                completion(.failure(error))
                return
            }
            
            guard let imageData = dataResponse.data else {
                let errorUserInfo = [NSLocalizedDescriptionKey: "Ошибка: нет данных"]
                let error = NSError(domain:"Image", code:401, userInfo:errorUserInfo)
                completion(.failure(error))
                
                return
            }
            
            guard let image = UIImage(data: imageData, scale: 1.0) else {
                let errorUserInfo = [NSLocalizedDescriptionKey: "Ошибка конвертирования данных в изображение"]
                let error = NSError(domain:"Image", code:401, userInfo:errorUserInfo)
                completion(.failure(error))
                
                return
            }
            
            completion(.success(image))
        })
    }
}
