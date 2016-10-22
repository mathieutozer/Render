//
//  Video.swift
//  RenderTodoDemo
//
//  Created by Alex Usbergo on 11/05/16.
//  Copyright © 2016 Alex Usbergo. All rights reserved.
//

import Foundation

#if os(OSX)
  import RendermacOS
#else
  import Render
#endif

private let covers = [Image(data: try! Data(contentsOf: URL(string: "http://images3.mtv.com/uri/mgid:uma:video:mtv.com:1254271?width=657&height=370&crop=true&quality=0.85")!)),
                      Image(data: try! Data(contentsOf: URL(string: "http://images1.mtv.com/uri/mgid:uma:video:mtv.com:263678?width=657&height=370&crop=true&quality=0.85")!))]

private let titles = ["Adele",
                      "Radiohead"]

func ==(lhs: Video, rhs: Video) -> Bool {
  return lhs.id == rhs.id
}

class Video: Equatable {

  let id = UUID().uuidString
  let title: String
  let cover: Image

  init(featured: Bool = false) {
    let idx = randomInt(0, max: covers.count-1)
    self.title = titles[idx]
    self.cover = covers[idx]!
  }
}

func randomInt(_ min: Int, max:Int) -> Int {
  return min + Int(arc4random_uniform(UInt32(max - min + 1)))
}

func randomChance() -> Bool {
  return  Int(arc4random_uniform(UInt32(10))) % 5 == 0
}
