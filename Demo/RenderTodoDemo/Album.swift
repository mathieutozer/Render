//
//  Album.swift
//  RenderTodoDemo
//
//  Created by Alex Usbergo on 03/05/16.
//  Copyright © 2016 Alex Usbergo. All rights reserved.
//

import Foundation
#if os(OSX)
  import RendermacOS
#else
  import Render
#endif

private let covers = [Image(named: "cover")!]

private let titles = ["Aa"]

private let artits = ["Brian Eno"]

func ==(lhs: Album, rhs: Album) -> Bool {
  return lhs.id == rhs.id
}

class Album: Equatable {

  let id = UUID().uuidString
  let title: String
  let artist: String
  let cover: Image
  var featured: Bool

  init(featured: Bool = false) {
    let idx = randomInt(0, max: covers.count-1)
    self.title = titles[idx]
    self.artist = artits[idx]
    self.cover = covers[idx]
    self.featured = featured
  }
}
