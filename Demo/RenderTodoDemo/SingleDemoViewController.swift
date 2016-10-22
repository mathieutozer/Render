//
//  SingleViewController.swift
//  RenderTodoDemo
//
//  Created by Alex Usbergo on 14/05/16.
//  Copyright © 2016 Alex Usbergo. All rights reserved.
//

import Foundation
#if os(OSX)
  import RendermacOS
#else
  import Render
#endif

class SingleDemoViewController: ViewController {

  // The item list.
  var album = Album(featured: true)

  /// The collection view component.
  lazy var component: AlbumComponentView = {
    let component = AlbumComponentView()
    component.state = self.album
    return component
  }()

  /// Called after the controller's view is loaded into memory.
  override func viewDidLoad() {
    self.view.wantsLayer = true
    super.viewDidLoad()
    self.view.addSubview(self.component)
    self.toggleFeatured()
  }

  #if os(OSX)
  /// Called to notify the view controller that its view has just laid out its subviews.
  override func viewDidLayout() {
    self.render()
  }

//  override func loadView() {
//    self.view = View(frame: .zero)
//    self.view.wantsLayer = true
//  }
  #else
  /// Called to notify the view controller that its view has just laid out its subviews.
  override func viewDidLayoutSubviews() {
    self.render()
  }
  #endif


  #if os(OSX)
  func render(_ animated: Bool = false) {
    //if animated {
      //View.animate(withDuration: 0.3, animations: {
        self.component.renderComponent()
        self.component.setCenter(self.view.getCenter())
//      //})
//    } else {
//      self.component.renderComponent()
//      self.component.center = self.view.center

  }
  #else
  func render(_ animated: Bool = false) {
  if animated {
  View.animate(withDuration: 0.3, animations: {
  self.component.renderComponent()
  self.component.center = self.view.center
  })
  } else {
  self.component.renderComponent()
  self.component.center = self.view.center
  }
  }
  #endif

  /// Change the component state every 2 seconds.
  func toggleFeatured() {
    delay(2) {
      self.album.featured = !self.album.featured
      self.component.state = self.album
      self.render(true)

      self.toggleFeatured()
    }
  }

}


func delay(_ delay:Double, closure:@escaping ()->()) {
  DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() +
    Double(Int64(delay * Double(NSEC_PER_SEC))) / Double(NSEC_PER_SEC), execute: closure)
}
