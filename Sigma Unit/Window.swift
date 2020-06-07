//
//  Window.swift
//  Sigma Unit
//
//  Created by Jean Flaherty on 7/2/17.
//  Copyright © 2017 kobejean. All rights reserved.
//

import Cocoa

class Window: NSWindow {

    // instance variables
    
    override var canBecomeKey: Bool { true }
    override var canBecomeMain: Bool { true }
    
    override var contentView: NSView? {
        get { super.contentView }
        set { super.contentView = newValue }
    }
    override var acceptsFirstResponder: Bool { true }
    var isFullscreen: Bool { self.styleMask.contains(.fullScreen) }
    var trackingArea: NSTrackingArea!
    var titleBar: NSView? { standardWindowButton(.zoomButton)?.superview }

    // constructor
    override init(contentRect: NSRect, styleMask: NSWindow.StyleMask, backing: NSWindow.BackingStoreType, defer aDefer: Bool){
        super.init(contentRect: contentRect, styleMask: styleMask, backing: backing, defer: aDefer)
        self.isMovableByWindowBackground = true
        self.titlebarAppearsTransparent = true
        self.titleVisibility = .hidden
        self.setTitleBarHidden(hidden: true, animated: false)
        self.updateTrackingAreas()
        NotificationCenter.default.addObserver(forName: NSWindow.didResizeNotification, object: nil, queue: nil, using: windowDidResize(_:))
        NotificationCenter.default.addObserver(forName: NSWindow.willEnterFullScreenNotification, object: nil, queue: nil, using: windowWillEnterFullScreen(_:))
        NotificationCenter.default.addObserver(forName: NSWindow.willExitFullScreenNotification, object: nil, queue: nil, using: windowWillExitFullScreen(_:))
    }

    // methods
    override func setContentSize(_ size: NSSize) {
        self.updateTrackingAreas()
        super.setContentSize(size)
    }

    // mouse event methods
    override func mouseEntered(with event: NSEvent) {
        setTitleBarHidden(hidden: false)
    }

    override func mouseExited(with event: NSEvent) {
        if !self.isFullscreen {
            setTitleBarHidden(hidden: true)
        }
    }

    private func updateTrackingAreas() {
        guard let titleBar = self.titleBar else { return }

        var trackingRect = titleBar.frame
        trackingRect.size.height = 60

        if self.trackingArea != nil && titleBar.trackingAreas.contains(self.trackingArea){
            titleBar.removeTrackingArea(self.trackingArea)
        }
        self.trackingArea = NSTrackingArea(rect: trackingRect,
                                           options: [.mouseEnteredAndExited, .activeInKeyWindow, .activeAlways],
                                           owner: self,
                                           userInfo: nil)
        titleBar.addTrackingArea(self.trackingArea)
    }

    func setTitleBarHidden(hidden: Bool, animated: Bool = true) {
        guard let titleBar = self.titleBar else { return }
        let titleBarInterface = animated ? titleBar.animator() : titleBar
        titleBarInterface.alphaValue = hidden ? 0 : 1
    }
    
    func windowDidResize(_ notification: Notification) {
        self.updateTrackingAreas()
    }

    func windowWillExitFullScreen(_ notification: Notification) {
        setTitleBarHidden(hidden: true)
    }

    func windowWillEnterFullScreen(_ notification: Notification) {
        setTitleBarHidden(hidden: false)
    }


}
