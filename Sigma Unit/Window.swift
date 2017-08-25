//
//  Window.swift
//  Sigma Unit
//
//  Created by Jean Flaherty on 7/2/17.
//  Copyright © 2017 kobejean. All rights reserved.
//

import Cocoa

class Window: NSWindow, NSWindowDelegate {

    // instance variables
    override var appearance: NSAppearance? {
        get { return NSAppearance(named: NSAppearance.Name.vibrantDark)}
        set { super.appearance = NSAppearance(named: NSAppearance.Name.vibrantDark) }
    }
    
    override var canBecomeKey: Bool {
        get { return true }
    }
    
    override var canBecomeMain: Bool {
        get { return true }
    }
    
    override var contentView: NSView? {
        get { return super.contentView }
        set { super.contentView = newValue }
    }
    override var acceptsFirstResponder: Bool { return true }
    var isFullscreen: Bool { return self.styleMask.contains(NSWindow.StyleMask.fullScreen) }
    var trackingArea: NSTrackingArea!
    var titleBarHidden: Bool {
        guard let view = self.standardWindowButtonSuperView() else {
            return true
        }
        return view.alphaValue < 1
    }

    // constructor
    override init(contentRect: NSRect, styleMask: NSWindow.StyleMask, backing: NSWindow.BackingStoreType, defer aDefer: Bool){
        super.init(contentRect: contentRect, styleMask: styleMask, backing: backing, defer: aDefer)
        super.appearance = NSAppearance(named: NSAppearance.Name.vibrantDark)
        self.isMovableByWindowBackground = true
        self.titleVisibility = NSWindow.TitleVisibility.hidden
        self.setTitleBarHidden(hidden: true, animated: false)
        self.updateTrackingAreas()
        self.delegate = self
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

    private func updateTrackingAreas(){
        guard let titlebar = self.standardWindowButtonSuperView() else {
            return
        }

        let titleFrame = titlebar.frame
        let trackingRect = CGRect(x: titleFrame.origin.x, y: titleFrame.origin.y,
                                  width: titleFrame.width, height: 60.0)

        if self.trackingArea != nil && titlebar.trackingAreas.contains(self.trackingArea){
            titlebar.removeTrackingArea(self.trackingArea)
        }
        self.trackingArea = NSTrackingArea(rect: trackingRect,
                                           options: [NSTrackingArea.Options.mouseEnteredAndExited, NSTrackingArea.Options.activeInKeyWindow, NSTrackingArea.Options.activeAlways],
                                           owner: self,
                                           userInfo: nil)
        titlebar.addTrackingArea(self.trackingArea)
    }

    func setTitleBarHidden(hidden: Bool, animated: Bool = true) {
        //https://stackoverflow.com/questions/28371381/nswindow-animate-show-hide-titlebar
        guard let view = self.standardWindowButtonSuperView() else {
            return
        }
        if hidden {
            if view.alphaValue > 0.1 {
                if !animated {
                    view.alphaValue = 0
                    return
                }
                view.animator().alphaValue = 0
            }
            return
        } else {
            if view.alphaValue < 1 {
                if !animated {
                    view.alphaValue = 1
                    return
                }
                view.animator().alphaValue = 1
            }
        }
    }

    func standardWindowButtonSuperView() -> NSView? {
        //http://stackoverflow.com/a/28381918
        return standardWindowButton(NSWindow.ButtonType.zoomButton)?.superview
    }

    func windowWillResize(_ sender: NSWindow, to frameSize: NSSize) -> NSSize {
        self.updateTrackingAreas()
        return frameSize
    }

    func windowDidExitFullScreen(_ notification: Notification) {
        setTitleBarHidden(hidden: true)
    }

    func windowWillEnterFullScreen(_ notification: Notification) {
        setTitleBarHidden(hidden: false)
    }


}
