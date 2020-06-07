//
//  PictureViewController.swift
//  Sigma Unit
//
//  Created by Jean Flaherty on 7/1/17.
//  Copyright © 2017 kobejean. All rights reserved.
//

import Cocoa
import Quartz
import CoreImage

class PictureViewController: NSViewController {
    @IBOutlet var imageView: CustomImageView!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    override var representedObject: Any? {
        didSet {
        // Update the view, if already loaded.
        }
    }

    /// Loads image from URL.
    func loadURL(_ url: URL) {

        imageView.setImageWith(url)

        guard let window = self.view.window else { return }
        window.aspectRatio = imageView.imageSize()
        
    }
}

