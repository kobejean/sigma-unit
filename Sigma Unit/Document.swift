//
//  Document.swift
//  Sigma Unit
//
//  Created by Jean Flaherty on 7/2/17.
//  Copyright © 2017 kobejean. All rights reserved.
//

import Cocoa
import AVFoundation

class Document: NSDocument {
    var viewController: ViewController!
    
    override init() {
        super.init()
        
        // Add your subclass-specific initialization here.
    }
    
    override class func autosavesInPlace() -> Bool {
        return false
    }
    
    override func makeWindowControllers() {
        // Returns the Storyboard that contains your Document window.
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        let windowController = storyboard.instantiateController(withIdentifier: "WindowController") as! NSWindowController
        self.addWindowController(windowController)
        viewController = windowController.contentViewController as! ViewController
        
        guard let fileURL = self.fileURL else {
            Swift.print("no file")
            return
        }
        
        
        let assetURL = AVAsset(url: fileURL)
        let aspectRatio = assetURL.tracks[0].naturalSize
        let playerItem = AVPlayerItem(asset: assetURL)
        viewController.loadPlayerItem(playerItem)
        
        guard let window = windowController.window else {
            return
        }
        
        window.aspectRatio = aspectRatio
        let scale = min(window.screen!.frame.size.width/aspectRatio.width,
                        window.screen!.frame.size.height/aspectRatio.height)
        let size = CGSize(width: aspectRatio.width * scale,
                          height: aspectRatio.height * scale)
        window.setContentSize(size)
        
        
//        window.titleVisibility = NSWindowTitleVisibility.hidden
//        window.titlebarAppearsTransparent = true
//        window.appearance = NSAppearance(named: NSAppearanceNameVibrantDark)
//        window.styleMask = [.fullSizeContentView, .titled, .resizable, .borderless]
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(5)) {
//            window.styleMask = [.fullSizeContentView, .resizable, .borderless]
//        }
        
//        if !window.styleMask.contains(NSWindowStyleMask.fullScreen) {
//            window.toggleFullScreen(nil)
//        }
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
