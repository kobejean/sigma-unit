//
//  MovieDocument.swift
//  Sigma Unit
//
//  Created by Jean Flaherty on 7/2/17.
//  Copyright © 2017 kobejean. All rights reserved.
//

import Cocoa
import FSEventsUnofficialWrapper

class FolderDocument: NSDocument {
    var viewController: PictureViewController!
    var stream: FSEventUnofficialWrapperStream!
    
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
        let windowController = storyboard.instantiateController(withIdentifier: "PictureWindowController") as! NSWindowController
        self.addWindowController(windowController)
        viewController = windowController.contentViewController as! PictureViewController
        
        guard let path = self.fileURL?.path else {
            Swift.print("no file")
            return
        }
        
        Swift.print(path)
        let stream = try? FSEventUnofficialWrapperStream(pathsToWatch: [path],
            sinceWhen: .now,
            latency: 0,
            flags: [.fileEvents, .ignoreSelf]) { event in
                Swift.print(event)
                if (event.flag ?? []).contains([.itemIsFile,.itemCreated]) {
                    let url = URL(fileURLWithPath:event.path)
                    self.viewController.loadURL(url)
                }
                                                    
        }
        self.stream = stream
        self.stream.setDispatchQueue(DispatchQueue.main)
        do {
            try self.stream.start()
        } catch {
            Swift.print("Error: \(error)")
        }
    
    }
    
    override func data(ofType typeName: String) throws -> Data {
        // Insert code here to write your document to data of the specified type. If outError != nil, ensure that you create and set an appropriate error when returning nil.
        // You can also choose to override fileWrapperOfType:error:, writeToURL:ofType:error:, or writeToURL:ofType:forSaveOperation:originalContentsURL:error: instead.
        throw NSError(domain: NSOSStatusErrorDomain, code: unimpErr, userInfo: nil)
    }
    
    
    override func read(from fileWrapper: FileWrapper, ofType typeName: String) throws {
        //
    }

    override func close() {
        super.close()
        self.stream.stop()
    }
}
