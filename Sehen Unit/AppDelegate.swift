//
//  AppDelegate.swift
//  Sehen Unit
//
//  Created by Jean Flaherty on 7/1/17.
//  Copyright © 2017 kobejean. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    var windowController: NSWindowController!
    
    override init(){
        super.init()
        let storyboard = NSStoryboard(name: "Main", bundle: nil)
        self.windowController = storyboard.instantiateController(withIdentifier: "WindowController") as! NSWindowController
        
        print("init")
        
    }

    func applicationWillFinishLaunching(_ aNotification: Notification) {
        print("applicationWillFinishLaunching")
        // Insert code here to initialize your application
        let appleEventManager: NSAppleEventManager = NSAppleEventManager.shared()
        appleEventManager.setEventHandler(self,
                                          andSelector: #selector(AppDelegate.handleGetURLEvent(_:replyEvent:)),
                                          forEventClass: AEEventClass(kInternetEventClass),
                                          andEventID: AEEventID(kAEGetURL))
    }

    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
    
    func handleGetURLEvent(_ event:NSAppleEventDescriptor, replyEvent:NSAppleEventDescriptor) {
        guard let path = event.paramDescriptor(forKeyword: keyDirectObject)!.stringValue else {
            print("Error reading event:", event)
            return
        }
        print("handleGetURLEvent")
        
        let url = URL(string: path)
        let query = url?.query
        let queryPairs = query?.components(separatedBy: "&")
        
        var pairs = Dictionary<String, String>()
        for pair in queryPairs ?? [] {
            let bits = pair.components(separatedBy: "=")
            if bits.count != 2 { continue }
            let key = bits[0]
            let value = bits[1]
            pairs[key] = value
        }
        print("pairs", pairs)
        
        guard let filepathString = pairs["filepath"] else{ return }
        let filepath = URL(fileURLWithPath:filepathString)
        
        print(filepath)
        let viewController = windowController.contentViewController as! ViewController
        viewController.loadFile(filepath)
        
        guard let window = self.windowController.window else {return}
        
        self.windowController.showWindow(self)
        
        if !window.styleMask.contains(NSWindowStyleMask.fullScreen) {
            window.toggleFullScreen(nil)
        }
        
    }
    
    @IBAction func openFile(_ sender: Any) {
        let viewController = windowController.contentViewController as! ViewController
        let panel = NSOpenPanel()
        panel.allowedFileTypes = ["mp4", "mov"]
        
        panel.begin { (result) in
            guard let fileURL = panel.url else { return }
            
            viewController.loadFile(fileURL)
            
            guard let window = self.windowController.window else {return}
            
            self.windowController.showWindow(self)
            window.titleVisibility = NSWindowTitleVisibility.hidden
            window.titlebarAppearsTransparent = true
            window.appearance = NSAppearance(named: NSAppearanceNameVibrantDark)
            
            if !window.styleMask.contains(NSWindowStyleMask.fullScreen) {
                window.toggleFullScreen(nil)
            }
        }

    }

}

