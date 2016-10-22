//
//  AppDelegate.swift
//  RenderMacOSDemo
//
//  Created by Mathieu Tozer on 10/21/16.
//  Copyright © 2016 Alex Usbergo. All rights reserved.
//

import Cocoa

@NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {

  @IBOutlet weak var window: NSWindow!
  var windowController: NSWindowController?

  func applicationDidFinishLaunching(_ aNotification: Notification) {
    // Insert code here to initialize your application
    let viewController = SingleDemoViewController(nibName: "EmptyViewController", bundle: Bundle.main)
    windowController = NSWindowController(window: NSWindow(contentViewController: viewController!))
    windowController?.showWindow(self)
  }

  func applicationWillTerminate(_ aNotification: Notification) {
    // Insert code here to tear down your application
  }


}

