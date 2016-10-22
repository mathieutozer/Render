//
//  ComponentCell.swift
//  Render
//
//  Created by Alex Usbergo on 21/04/16.
//
//  Copyright (c) 2016 Alex Usbergo.
//
//  Permission is hereby granted, free of charge, to any person obtaining a copy
//  of this software and associated documentation files (the "Software"), to deal
//  in the Software without restriction, including without limitation the rights
//  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the Software is
//  furnished to do so, subject to the following conditions:
//
//  The above copyright notice and this permission notice shall be included in
//  all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
//  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
//  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
//  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
//  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
//  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
//  THE SOFTWARE.
//

#if os(OSX)
  import AppKit
#else
  import UIKit
#endif

public protocol ComponentCellType {

  /// Render the component.
  /// - parameter size: The bounding box for this component. The default will determine the
  /// intrinsic content size for this component.
  /// - parameter state: The (optional) state for this component.
  func renderComponent(_ size: CGSize?)
}

/// Wraps a component inside a UITableViewCell.
open class ComponentTableViewCell<C: ComponentViewType>: TableViewCell, ComponentCellType {

  /// The internal component.
  open var component: C?

  open func hasMountedComponent() -> Bool {
    return self.component != nil
  }

  open func mountComponentIfNecessary(_ component: @autoclosure (Void) -> C) {
    if self.component != nil {
      return
    }
    self.component = component()
    if let view = self.component as? View {
     #if os(OSX)
      addSubview(view)
     #else
      self.contentView.addSubview(view)
      self.clipsToBounds = true
    #endif
    }
  }

  /// Render the component.
  /// - parameter size: The bounding box for this component. The default will determine the
  /// intrinsic content size for this component.
  /// - parameter state: The (optional) state for this component.
  open func renderComponent(_ size: CGSize? = nil) {
    self.component?.renderComponent(withSize:
      size ?? self.superview?.bounds.size ?? CGSize.undefined)
    self.component?.renderComponent(withSize:

      size ?? self.superview?.bounds.size ?? CGSize.undefined)
    if let view = self.component as? View {
      #if os(OSX)
        self.frame = view.bounds
      #else
        self.contentView.frame = view.bounds
      #endif
    }
  }

  /// Asks the view to calculate and return the size that best fits the specified size.
  /// - parameter size: The size for which the view should calculate its best-fitting size.
  /// - returns: A new size that fits the receiver’s subviews.
  #if os(iOS)
  open override func sizeThatFits(_ size: CGSize) -> CGSize {
    if let view = self.component as? View {
      let size = view.sizeThatFits(size)
      return size
    }
    return CGSize.zero
  }
  #endif

  /// Returns the natural size for the receiving view, considering only properties of the view.
  /// - returns: A size indicating the natural size for the receiving view based on its 
  /// intrinsic properties.
  open override var intrinsicContentSize : CGSize {
    if let view = self.component as? View {
      return view.intrinsicContentSize
    }
    return CGSize.zero
  }
}

/// Wraps a component inside a UICollectionViewCell.
open class ComponentCollectionViewCell<C: ComponentViewType>: CollectionViewCell,
                                                                ComponentCellType {

  /// The internal component
  open var component: C?

  open func hasMountedComponent() -> Bool {
    return self.component != nil
  }

  open func mountComponentIfNecessary(_ component: C) {
    if self.component != nil {
      return
    }
    self.component = component
    if let view = self.component as? View {
      #if os(OSX)
        view.addSubview(view)
      #else
        self.contentView.addSubview(view)
        self.clipsToBounds = true
      #endif
    }
  }

  /// Render the component.
  /// - parameter size: The bounding box for this component. The default will determine the
  /// intrinsic content size for this component.
  /// - parameter state: The (optional) state for this component.
  open func renderComponent(_ size: CGSize? = nil) {
    #if os(OSX)
      let superview = view.superview
      let contentView = view
    #else
      let superview = self.superview
      let contentView = self.contentView
    #endif
    self.component?.renderComponent(withSize:
      size ?? superview?.bounds.size ?? CGSize.undefined)
    if let view = self.component as? View {
      contentView.frame = view.bounds
    }
  }
  #if os(iOS)
  /// Asks the view to calculate and return the size that best fits the specified size.
  /// - parameter size: The size for which the view should calculate its best-fitting size.
  /// - returns: A new size that fits the receiver’s subviews.
  open override func sizeThatFits(_ size: CGSize) -> CGSize {
    self.renderComponent(size)
    if let view = self.component as? View {
      let size = view.sizeThatFits(size)
      return size
    }
    return CGSize.zero
  }
  #endif

  /// Returns the natural size for the receiving view, considering only properties of the 
  /// view itself.
  /// - returns: A size indicating the natural size for the receiving view based on its 
  /// intrinsic properties.
  #if os(OSX)
  open var intrinsicContentSize : CGSize {
    if let view = self.component as? View {
      return view.intrinsicContentSize
    }
    return CGSize.zero
  }
    #else
  open override var intrinsicContentSize : CGSize {
    if let view = self.component as? UIView {
      return view.intrinsicContentSize
    }
    return CGSize.zero
  }
  #endif

}

//MARK: Extensions

extension TableView {

  /// Refreshes the component at the given index path.
  /// - parameter indexPath: The indexpath for the targeted component.
  public func renderComponent(atIndexPath indexPath: IndexPath) {
    self.beginUpdates()
    #if os(OSX)
      self.reloadData() //todo
    #else
      self.reloadRows(at: [indexPath], with: .fade)
    #endif
    self.endUpdates()
  }

  #if os(OSX)
  var visibleCells: [TableViewCell] {
    let rect = enclosingScrollView?.contentView.visibleRect
    let range = rows(in: rect!)
    var cells = [NSTableCellView]()
    for i in range.location...range.length {
      //cells.append(rowView(atRow: i, makeIfNecessary: true) as NSTableCellView) todo
    }
    return cells
  }
  #endif

  /// Re-renders all the compoents currently visible on screen.
  /// - Note: Call this method whenever the table view changes its bounds/size.
  public func renderVisibleComponents() {

    for cell in self.visibleCells where cell is ComponentCellType {
      (cell as! ComponentCellType).renderComponent(CGSize.sizeConstraintToWidth(self.bounds.width))
    }
  }
}

extension CollectionView {

  /// Refreshes the component at the given index path.
  /// - parameter indexPath: The indexpath for the targeted component.
  public func renderComponent(atIndexPath indexPath: IndexPath) {
    #if os(OSX)
      self.performBatchUpdates({
        self.reloadItems(at: [indexPath])
        }, completionHandler: nil)
    #else
      self.performBatchUpdates({
        self.reloadItems(at: [indexPath])
        }, completion: nil)
    #endif

  }

  /// Re-renders all the compoents currently visible on screen.
  /// - Note: Call this method whenever the collection view changes its bounds/size.
  public func renderVisibleComponents() {
    #if os(OSX)
    for cell in self.visibleItems() {
      (cell as! ComponentCellType).renderComponent(CGSize.sizeConstraintToWidth(self.bounds.width))
    }
    #else
      for cell in self.visibleCells where cell is ComponentCellType {
        (cell as! ComponentCellType).renderComponent(CGSize.sizeConstraintToWidth(self.bounds.width))
      }
    #endif
  }
}

//MARK: Prototypes

public struct ComponentPrototypes {

  /// The collection of registered prototypes.
  fileprivate static var prototypes = [String: ComponentViewType]()

  /// Register the component as a reusable component in the list component.
  /// - parameter reuseIdentifier: The identifier for this component. The default is the component 
  /// class name.
  /// - parameter component: An instance of the component.
  public static func registerComponentPrototype<C:ComponentViewType>(
      _ reuseIdentifier: String = String(describing: C.self), component: C) {

    ComponentPrototypes.prototypes[reuseIdentifier] = component
  }

  /// Returns the size of the prototype wrapped in the view (CollectionView or TableView) 
  /// passed as argument
  public static func prototypeComponentSize(_ referenceView: View,
                                            reuseIdentifier: String,
                                            state: ComponentStateType) -> CGSize {

    guard let component = ComponentPrototypes.prototypes[reuseIdentifier] else {
      fatalError("Unregistered component with reuse identifier \(reuseIdentifier).")
    }

    // render the component.
    component.state = state
    component.referenceView = referenceView
    component.renderComponent(withSize:
      CGSize.sizeConstraintToWidth(referenceView.bounds.size.width))

    if let view = component as? View {
      return view.bounds.size
    } else {
      return CGSize.zero
    }
  }
}

