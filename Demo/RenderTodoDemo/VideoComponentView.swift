//
//  VideoComponentView.swift
//  RenderTodoDemo
//
//  Created by Alex Usbergo on 11/05/16.
//  Copyright © 2016 Alex Usbergo. All rights reserved.
//

#if os(OSX)
  import AppKit
#else
  import UIKit
#endif

#if os(OSX)
  import RendermacOS
#else
  import Render
#endif

// the model is marked as component state.
extension Video: ComponentStateType { }

class VideoComponentView: StaticComponentView {


  /// The component state.
  var video: Video? {
    return self.state as? Video
  }

  /// Constructs the component tree.
  override func construct() -> ComponentNodeType {

    let imageView =
          ComponentNode<ImageView>().configure({ view in
            view.image = self.video?.cover
            view.style.alignItems = .center
            view.style.dimensions.width = ~self.referenceSize.width
            view.style.dimensions.height = (~self.referenceSize.width * 9)/16
    
          })

    return ComponentNode<View>().configure({ view in
      view.style.flexDirection = .column
//      view.backgroundColor = S.Color.black
      view.style.dimensions.width =  ~self.referenceSize.width

    }).children  ([
            imageView
      ])
//      .children([
//
//      ComponentNode<ImageView>().configure({ view in
//        view.image = self.video?.cover
//        view.style.alignItems = .center
//        view.style.dimensions.width = ~self.referenceSize.width
//        view.style.dimensions.height = (~self.referenceSize.width * 9)/16
//
//      }).children([
//
//        ComponentNode<View>().configure({ view in
//          view.style.flex = Flex.Max
//          view.style.alignSelf = .stretch
//          view.style.justifyContent = .center
//          view.style.flexDirection = .row
//
//        }).children([
//          DefaultButton().configure({ view in
//            view.setTitle("FOO", for: .normal)
//          }),
//          DefaultButton().configure({ view in
//            view.setTitle("BAR", for: .normal)
//          }),
//          DefaultButton().configure({ view in
//            view.setTitle("BAZ", for: .normal)
//          })
//          ])
//        ])
//
//      ])
  }
}


