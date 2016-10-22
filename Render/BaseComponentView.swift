//
//  AutolayoutComponentView.swift
//  Render
//
//  Created by Alex Usbergo on 27/04/16.
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
  public typealias View = NSView
  public typealias ViewController = NSViewController
  public typealias TableView = NSTableView
  public typealias CollectionView = NSCollectionView
  public typealias ScrollView = NSScrollView
  public typealias TableViewCell = NSTableCellView
  public typealias CollectionViewCell = NSCollectionViewItem
  public typealias TextView = NSTextView
  public typealias Label = MTTextField
  public typealias TextField = NSTextField
  public typealias Button = NSButton
  public typealias Control = NSControl
  public typealias ImageView = NSImageView
  public typealias Image = NSImage

#else
  import UIKit
  public typealias View = UIView
  public typealias ViewController = UIViewController
  public typealias TableView = UITableView
  public typealias CollectionView = UICollectionView
  public typealias TableViewCell = UITableViewCell
  public typealias CollectionViewCell = UICollectionViewCell
  public typealias ScrollView = UIScrollView
  public typealias TextView = UITextView
  public typealias Label = UILabel
  public typealias TextField = UITextField
  public typealias Button = UIButton
  public typealias Control = UIControl
  public typealias ImageView = UIImageView
  public typealias Image = UIImage
#endif


#if os(OSX)
  public class MTTextField : NSTextField {
    public var text: String {
      set {
        self.stringValue = text
      }
      get {
        return self.stringValue
      }
    }
  }

  public extension NSView {
    public func setCenter(_ :CGPoint) {

    }
    public func getCenter() -> CGPoint {
      return CGPoint(x: bounds.size.width / 2, y: bounds.size.height / 2)
    }
  }
  
#endif

open class BaseComponentView: View, ComponentViewWithReusePoolViewType {

  public
  required init() {
    super.init(frame: CGRect.zero)
    self.initalizeComponent()
  }

  public override init(frame: CGRect) {
    super.init(frame: frame)
    self.initalizeComponent()
  }

  required public init?(coder aDecoder: NSCoder) {
    super.init(coder: aDecoder)
    self.initalizeComponent()
  }

  /// The reusable pool associated to this component view.
  let reusePool: ComponentViewReusePool? = {
    if InfraConfiguration.useReusePool {
      return ComponentViewReusePool()
    } else {
      return nil
    }
  }()

  private var props: PropsType = PropsType() {
    didSet {
      self.internalStore.props = props
    }
  }

  /// The component initialization.
  /// - Note: Always call the super implemention.
  open  func initalizeComponent() {
  }

  /// Applies the component configuration (as per ViewType extension)
  open  func configure(_ closure: @escaping ((ComponentViewType) -> Void)) {
    self.internalStore.configureClosure = { [weak self] in
      if let _self = self {
        closure(_self)
      }
    }
  }

  open func props(_ props: PropsType) -> ComponentViewType {
    self.props = props
    return self
  }

  /// The state of this component.
  open  var state: ComponentStateType?

  /// The parent for this component
  internal weak var _parentView: View?
  open  var referenceView: View? {
    get {
      return self._parentView ?? self.superview
    }
    set {
      self._parentView = newValue
    }
  }

  /// This method should be overriden by the subclass and define the component
  /// configuration for the current state.
  /// - Note: Always call the super implemention.
  open  func renderComponent(withSize size: CGSize = CGSize.undefined) {
    self.internalStore.configureClosure?()
  }
}


