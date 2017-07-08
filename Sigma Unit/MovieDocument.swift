//
//  MovieDocument.swift
//  Sigma Unit
//
//  Created by Jean Flaherty on 7/2/17.
//  Copyright © 2017 kobejean. All rights reserved.
//

import Cocoa
import AVFoundation

class MovieDocument: NSDocument {
    var viewController: MovieViewController!
    
    override init() {
        super.init()
        Swift.print("MovieWindowController init")
        // Add your subclass-specific initialization here.
    }
    
    override class func autosavesInPlace() -> Bool {
        return false
    }
    
    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: "MovieWindowController") as! NSWindowController
        self.addWindowController(windowController)
        viewController = windowController.contentViewController as! MovieViewController

        guard let fileURL = self.fileURL else {
            Swift.print("no file")
            return
        }
        // load player
        let assetURL = AVAsset(url: fileURL)
        let aspectRatio = assetURL.tracks[0].naturalSize
        let playerItem = AVPlayerItem(asset: assetURL)
        viewController.loadPlayerItem(playerItem)
        
        guard let window = windowController.window else {
            return
        }
        guard let screen = window.screen else {
            return
        }

        window.aspectRatio = aspectRatio
        
        let pointSize = CGSize(width: aspectRatio.width/screen.backingScaleFactor,
                               height: aspectRatio.height/screen.backingScaleFactor)
        let screenSize = screen.frame.size
        let scale = min(screenSize.width/pointSize.width,
                        screenSize.height/pointSize.height,
                        1)
        let contentSize = CGSize(width: pointSize.width * scale,
                                 height: pointSize.height * scale)

        window.setContentSize(contentSize)
        
    }
    
    override func data(ofType typeName: String) throws -> Data {
        // Insert code here to write your document to data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning nil.
        // You can also choose to override fileWrapperOfType:error:, writeToURL:ofType:error:, or writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }
    
    override func read(from data: Data, ofType typeName: String) throws {
        // Insert code here to read your document from the given data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning false.
        // You can also choose to override readFromFileWrapper:ofType:error: or readFromURL:ofType:error: instead.
        // If you override either of these, you should also override -isEntireFileLoaded to return false if the contents are lazily loaded.
        //        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }

}
