//
//  SongPlayerViewModel.swift
//  iOSArchitecturesDemo
//
//  Created by Pavel Olegovich on 28.02.2022.
//  Copyright © 2022 ekireev. All rights reserved.
//

import Foundation

protocol SongPlayerViewModelInput {
    func play()
    func pause()
    func stop()
}

protocol SongPlayerViewModelOutput {
    var onProgressViewChanged: ((Double) -> Void)? { get set }
}

class SongPlayerViewModel: SongPlayerViewModelOutput {
    var onProgressViewChanged: ((Double) -> Void)?
    
    var timer: Timer?
    var progressSong: Double {
        didSet {
            onProgressViewChanged?(progressSong)
        }
    }
    
    init(progressSong: Double, onProgressViewChanged: @escaping ((Double) -> Void)) {
        self.progressSong = progressSong
        self.onProgressViewChanged = onProgressViewChanged
        onProgressViewChanged(progressSong)
    }
}

extension SongPlayerViewModel: SongPlayerViewModelInput {
    func play() {
        timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: true, block: { [weak self] timer in
            guard let self = self else { return }
        
            let newProgressSong = self.progressSong + 0.05
            
            if self.progressSong == 1 {
                timer.invalidate()
            }
            
            self.progressSong = min(newProgressSong, 1)
        })
    }
    
    func pause() {
        timer?.invalidate()
    }
    
    func stop() {
        timer?.invalidate()
        self.progressSong = 0
    }
    
    
}
