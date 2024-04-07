//
//  MusicPlayerViewModel.swift
//  MuzicMaza
//
//  Created by Suvendu Kumar on 07/04/24.
//

import AVFoundation

class MusicPlayer {
    var player: AVAudioPlayer?
    var currentURL: URL?
    
    init() {
        // Initialize the AVAudioSession
        do {
            try AVAudioSession.sharedInstance().setCategory(.playback, mode: .default)
            try AVAudioSession.sharedInstance().setActive(true)
        } catch {
            print("Failed to configure AVAudioSession: \(error.localizedDescription)")
        }
    }
    
    func play(url: URL) {
        do {
            // Check if the same URL is already playing
            if url != currentURL {
                // Create a new player instance
                player = try AVAudioPlayer(contentsOf: url)
                player?.prepareToPlay()
                currentURL = url
            }
            
            // Start playing the audio
            player?.play()
        } catch {
            print("Failed to play audio: \(error.localizedDescription)")
        }
    }
    
    func pause() {
        player?.pause()
    }
    
    func resume() {
        player?.play()
    }
    
    func forward(seconds: TimeInterval) {
        guard let player = player else { return }
        let currentTime = player.currentTime
        let newTime = currentTime + seconds
        
        // Check if new time is within bounds
        if newTime < player.duration {
            player.currentTime = newTime
        } else {
            player.currentTime = player.duration
            player.stop()
        }
    }
    
    func backward(seconds: TimeInterval) {
        guard let player = player else { return }
        let currentTime = player.currentTime
        let newTime = currentTime - seconds
        
        // Check if new time is within bounds
        if newTime > 0 {
            player.currentTime = newTime
        } else {
            player.currentTime = 0
        }
    }
}

