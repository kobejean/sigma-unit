//
//  Window.swift
//  Sigma Unit
//
//  Created by Jean Flaherty on 7/2/17.
//  Copyright © 2017 kobejean. All rights reserved.
//

import Cocoa

class Window: NSWindow {

    
    override var appearance: NSAppearance? {
        get { return NSAppearance(named: NSAppearanceNameVibrantDark)}
        set {}
    }
    
    override var canBecomeKey: Bool {
        get { return true }
    }
    
    override var canBecomeMain: Bool {
        get { return true }
    }
    
    override var contentView: NSView? {
        get {
            return super.contentView
        }
        set {
            super.contentView = newValue
            self.contentView?.wantsLayer = true
            self.contentView?.layer!.cornerRadius = 5.0
            self.contentView?.layer!.masksToBounds = true
        }
    }
    
    override init(contentRect: NSRect, styleMask: NSWindowStyleMask, backing: NSBackingStoreType, defer aDefer: Bool){
        super.init(contentRect: contentRect, styleMask: styleMask, backing: backing, defer: aDefer)
        self.styleMask = [.fullSizeContentView, .titled, .resizable, .borderless, .closable, .miniaturizable]
//        self.styleMask = [.fullSizeContentView, .resizable, .borderless, .closable]
        self.isMovableByWindowBackground = true
        self.titleVisibility = NSWindowTitleVisibility.hidden
        self.titlebarAppearsTransparent = true
        self.backgroundColor = NSColor.clear
        self.isOpaque = false
        self.hasShadow = true
    }
    

    
}
