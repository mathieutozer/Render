//
//  AlbumComponentView.swift
//  RenderTodoDemo
//
//  Created by Alex Usbergo on 03/05/16.
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

// The model is marked as component state.
extension Album: ComponentStateType { }

class AlbumComponentView: ComponentView {

  // If the component is used as list item it should be registered
  // as prototype for the infra.
  override class func initialize() {
    ComponentPrototypes.registerComponentPrototype(component: AlbumComponentView())
  }

  /// The component state.
  var album: Album? {
    return self.state as? Album
  }

  var featured: Bool {
    return self.album?.featured ?? false
  }

  /// Constructs the component tree.
  override func construct() -> ComponentNodeType {

    return ComponentNode<View>(props: [:]).configure { (view) in
        view.style.flex = Flex.Max
        view.style.alignSelf = .stretch
        view.style.justifyContent = .center
        view.style.flexDirection = .row
    }.children([
      ComponentNode<Label>(props: [
            #keyPath(flexMargin): EdgeInsets(top: 4, left: 4, bottom: 4, right: 4),
            #keyPath(Label.text): self.album?.title ?? "None",
            #keyPath(Label.font): S.Typography.mediumBold,
            #keyPath(Label.textColor): S.Color.black
        ])
      ])



    let size = self.referenceSize
    let imageView =
            // image view.
            ComponentNode<ImageView>(props: [
              #keyPath(ImageView.image): self.album?.cover,
              #keyPath(flexAlignSelf): Directive.Align.center.rawValue,
              #keyPath(flexDimensions): self.featured
                                        ? CGSize(width: size.width/2, height: size.width/2)
                                        : CGSize(width: 48, height: 48)])
    return ComponentNode<View>(props: [
      #keyPath(flexDirection): self.featured
                               ? Directive.FlexDirection.column.rawValue
                               : Directive.FlexDirection.row.rawValue,
//      #keyPath(backgroundColor): S.Color.black,
      #keyPath(flexDimensions): self.featured
                                ? CGSize(width: size.width/2, height: CGFloat(Undefined))
                                : CGSize(width: size.width, height: 64)])
    .children([imageView])
//      .children([
//
//        // image view.
//        ComponentNode<ImageView>(props: [
//          #keyPath(ImageView.image): self.album?.cover,
//          #keyPath(flexAlignSelf): Directive.Align.center.rawValue,
//          #keyPath(flexDimensions): self.featured
//                                    ? CGSize(width: size.width/2, height: size.width/2)
//                                    : CGSize(width: 48, height: 48)]).children([
//
//            // When the items is featured, there's a node with a button.
//            when(self.featured, ComponentNode<View>(props: [
//              #keyPath(flexGrow): Flex.Max,
//              #keyPath(flexAlignSelf): Directive.Align.stretch.rawValue,
//              #keyPath(flexJustifyContent): Directive.Justify.center.rawValue]).children([
//                DefaultButton().configure { $0.setTitle("PLAY", for: .normal)}
//              ]))
//        ]),
//
//        // Text wrapper.
//        ComponentNode<View>(props: [
//          #keyPath(flexDirection): Directive.FlexDirection.column.rawValue,
//          #keyPath(flexMargin): EdgeInsets(top: 4, left: 4, bottom: 4, right: 4),
//          #keyPath(flexAlignSelf): Directive.Align.center.rawValue,]).children([
//
//          // Title.
//          ComponentNode<Label>(props: [
//            #keyPath(flexMargin): EdgeInsets(top: 4, left: 4, bottom: 4, right: 4),
//            #keyPath(Label.text): self.album?.title ?? "None",
//            #keyPath(Label.font): S.Typography.mediumBold,
//            #keyPath(Label.textColor): S.Color.white]),
//
//          // Subitle.
//          ComponentNode<Label>(props: [
//            #keyPath(flexMargin): EdgeInsets(top: 4, left: 4, bottom: 4, right: 4),
//            #keyPath(Label.text): self.album?.artist ?? "Unknown artist",
//            #keyPath(Label.font): S.Typography.extraSmallLight,
//            #keyPath(Label.textColor): S.Color.white]),
//        ])
//    ])

  }
}


func DefaultButton() -> ComponentNode<Button> {

  // when you construct a node with a custom initClosure setting a reuseIdentifier
  // helps the infra recycling that view.
  return ComponentNode<Button>(reuseIdentifier: "DefaultButton", initClosure: {
    let view = Button()
    view.style.dimensions = (64, 64)
    view.style.alignSelf = .center
    view.style.justifyContent = .center
    view.style.margin = S.Album.defaultInsets
//    view.setTitleColor(S.Color.white, for: .normal)
//    view.backgroundColor = S.Color.black.withAlphaComponent(0.8)
//    view.titleLabel?.font = S.Typography.superSmallBold
//    view.layer.cornerRadius = 32
    return view
  })
}
