//
//  MovieViewController.swift
//  Sigma Unit
//
//  Created by Jean Flaherty on 7/1/17.
//  Copyright © 2017 kobejean. All rights reserved.
//

import Cocoa
import AVKit
import AVFoundation

class MovieViewController: NSViewController {
    @IBOutlet var playerView: AVPlayerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        playerView.player = AVPlayer()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    /// Loads player item into player and plays it if autoplay is true.
    func loadPlayerItem(_ playerItem: AVPlayerItem, autoplay:Bool = false) {
        playerView.player?.replaceCurrentItem(with: playerItem)
        if autoplay {
            playerView.player?.play()
        }
    }
}

