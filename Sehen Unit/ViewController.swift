//
//  ViewController.swift
//  Sehen Unit
//
//  Created by Jean Flaherty on 7/1/17.
//  Copyright © 2017 kobejean. All rights reserved.
//

import Cocoa
import AVKit
import AVFoundation

class ViewController: NSViewController {
    @IBOutlet var playerView: AVPlayerView!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view.
        
        // sehen://send?filepath=/Users/kobejean/Code/Git/tf-image-kit/docs/media/kmeans_flower_1856x1392_k16_wx5.0_wy5.0.mp4
//        let filepath = URL(fileURLWithPath: "/Users/kobejean/Code/Git/tf-image-kit/docs/media/kmeans_flower_1856x1392_k16_wx5.0_wy5.0.mp4")
//        playerView.player = AVPlayer(url: filepath)
//        playerView.player?.play()
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }
    
//    override func prepare(for segue: NSStoryboardSegue, sender: Any?) {
//        if (segue.identifier == "MainToTimer") {
//            let viewController = segue.destinationController as! ViewController
//            let filepath = sender as! URL
//            viewController.filepath = filepath
//        }
//    }
    
    func loadFile(_ filepath: URL) {
        // sehen://send?filepath=/Users/kobejean/Code/Git/tf-image-kit/docs/media/kmeans_flower_1856x1392_k16_wx5.0_wy5.0.mp4
        print(filepath)
        playerView.player = AVPlayer(url: filepath)
        playerView.player?.play()
    }

}

