//
//  Extensions.swift
//  FlexboxLayout
//
//  Created by Alex Usbergo on 30/03/16.
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

struct Reset {

  fileprivate static let _View = View()
  fileprivate static func resetView(_ view: View, proto: View = Reset._View) {
//    view.backgroundColor = proto.backgroundColor
//    view.tintColor = proto.backgroundColor
//    view.accessibilityIdentifier = nil
//    view.alpha = proto.alpha
//    view.isHidden = proto.isHidden
//    view.mask = proto.mask
//    view.accessibilityHint = proto.accessibilityHint
//    view.accessibilityLabel = proto.accessibilityLabel
//    view.accessibilityTraits = proto.accessibilityTraits
//    view.isUserInteractionEnabled = proto.isUserInteractionEnabled
//    view.layer.borderWidth = proto.layer.borderWidth
//    view.layer.borderColor = proto.layer.borderColor
//    view.layer.shadowPath = proto.layer.shadowPath
//    view.layer.shadowColor = proto.layer.shadowColor
//    view.layer.shadowOffset = proto.layer.shadowOffset
//    view.layer.shadowRadius = proto.layer.shadowRadius
//    view.layer.shadowOpacity = proto.layer.shadowOpacity
//    view.layer.cornerRadius = proto.layer.cornerRadius
//    view.layer.masksToBounds = proto.layer.masksToBounds
    Reset.resetTargets(view)
  }

  fileprivate static let _Label = Label()
  fileprivate static func resetLabel(_ label: Label) {
    Reset.resetView(label, proto: Reset._Label)
    label.backgroundColor = Reset._Label.backgroundColor
    label.font = Reset._Label.font
    label.textColor = Reset._Label.textColor
//    label.textAlignment = Reset._Label.textAlignment
//    label.numberOfLines = Reset._Label.numberOfLines
//    label.text = Reset._Label.text
//    label.attributedText = Reset._Label.attributedText
//    label.shadowColor = Reset._Label.shadowColor
//    label.shadowOffset = Reset._Label.shadowOffset
//    label.lineBreakMode = Reset._Label.lineBreakMode
//    label.highlightedTextColor = Reset._Label.highlightedTextColor
//    label.isHighlighted = Reset._Label.isHighlighted
//    label.isUserInteractionEnabled = Reset._Label.isUserInteractionEnabled
//    label.isEnabled = Reset._Label.isEnabled
//    label.adjustsFontSizeToFitWidth = Reset._Label.adjustsFontSizeToFitWidth
//    label.baselineAdjustment = Reset._Label.baselineAdjustment
//    label.minimumScaleFactor = Reset._Label.minimumScaleFactor
    if #available(iOS 9.0, *) {
      label.allowsDefaultTighteningForTruncation = Reset._Label.allowsDefaultTighteningForTruncation
    } else {
      // Fallback on earlier versions
    }
    Reset.resetTargets(label)
  }

  fileprivate static let _TextField = TextField()
  fileprivate static func resetTextField(_ textField: TextField) {
    Reset.resetView(textField, proto: Reset._TextField)
    textField.backgroundColor = Reset._TextField.backgroundColor
    textField.font = Reset._TextField.font
    textField.textColor = Reset._TextField.textColor
//    textField.textAlignment = Reset._TextField.textAlignment
//    textField.text = Reset._TextField.text
//    textField.attributedText = Reset._TextField.attributedText
    textField.isHighlighted = Reset._Label.isHighlighted
//    textField.isUserInteractionEnabled = Reset._TextField.isUserInteractionEnabled
    textField.isEnabled = Reset._TextField.isEnabled
//    textField.adjustsFontSizeToFitWidth = Reset._TextField.adjustsFontSizeToFitWidth
//    textField.borderStyle = Reset._TextField.borderStyle
//    textField.defaultTextAttributes = Reset._TextField.defaultTextAttributes
//    textField.placeholder = Reset._TextField.placeholder
//    textField.attributedPlaceholder = Reset._TextField.attributedPlaceholder
//    textField.clearsOnBeginEditing = Reset._TextField.clearsOnBeginEditing
//    textField.minimumFontSize = Reset._TextField.minimumFontSize
//    textField.background = Reset._TextField.background
//    textField.disabledBackground = Reset._TextField.disabledBackground
    textField.allowsEditingTextAttributes = Reset._TextField.allowsEditingTextAttributes
//    textField.typingAttributes = Reset._TextField.typingAttributes
//    textField.clearButtonMode = Reset._TextField.clearButtonMode
//    textField.leftView = Reset._TextField.leftView
//    textField.leftViewMode = Reset._TextField.rightViewMode
//    textField.rightView = Reset._TextField.rightView
//    textField.rightViewMode = Reset._TextField.rightViewMode
//    textField.inputView = Reset._TextField.inputView
//    textField.inputAccessoryView = Reset._TextField.inputAccessoryView
//    textField.clearsOnInsertion = Reset._TextField.clearsOnInsertion
    textField.delegate = nil
    Reset.resetTargets(textField)
  }

  fileprivate static let _TextView = TextView()
  fileprivate static func resetTextView(_ textView: TextView) {
    Reset.resetView(textView, proto: Reset._TextView)
    textView.backgroundColor = Reset._TextView.backgroundColor
    textView.font = Reset._TextView.font
    textView.textColor = Reset._TextView.textColor
//    textView.textAlignment = Reset._TextView.textAlignment
//    textView.text = Reset._TextView.text
//    textView.attributedText = Reset._TextView.attributedText
//    textView.isUserInteractionEnabled = Reset._TextView.isUserInteractionEnabled
//    textView.allowsEditingTextAttributes = Reset._TextView.allowsEditingTextAttributes
//    textView.inputView = Reset._TextView.inputView
//    textView.inputAccessoryView = Reset._TextView.inputAccessoryView
//    textView.clearsOnInsertion = Reset._TextView.clearsOnInsertion
    textView.isSelectable = Reset._TextView.isSelectable
    textView.selectedRange = Reset._TextView.selectedRange
    textView.isEditable = Reset._TextView.isEditable
//    textView.dataDetectorTypes = Reset._TextView.dataDetectorTypes
//    textView.allowsEditingTextAttributes = Reset._TextView.allowsEditingTextAttributes
//    textView.isScrollEnabled = Reset._TextView.isScrollEnabled
    textView.delegate = nil
    Reset.resetTargets(textView)
  }

  fileprivate static let _Button = Button()
  fileprivate static func resetButton(_ button: Button) {
    Reset.resetView(button, proto: _Button)
//    if let title = button.titleLabel { Reset.resetLabel(title) }
//    if let image = button.imageView { Reset.resetImageView(image) }
//
//    button.backgroundColor = Reset._TextView.backgroundColor
//    button.setTitle(Reset._Button.title(for: .disabled), for: .disabled)
//    if #available(iOS 9.0, *) {
//      button.setTitle(Reset._Button.title(for: .focused), for: .focused)
//    } else {
//      // Fallback on earlier versions
//    }
//    button.setTitle(Reset._Button.title(for: .highlighted), for: .highlighted)
//    button.setTitle(Reset._Button.title(for: UIControlState()), for: UIControlState())
//    button.setTitle(Reset._Button.title(for: .reserved), for: .reserved)
//    button.setTitle(Reset._Button.title(for: .selected), for: .selected)
//
//    button.setTitleColor(Reset._Button.titleColor(for: .disabled),
//                         for: .disabled)
//    if #available(iOS 9.0, *) {
//      button.setTitleColor(Reset._Button.titleColor(for: .focused),
//                           for: .focused)
//    } else {
//      // Fallback on earlier versions
//    }
//    button.setTitleColor(Reset._Button.titleColor(for: .highlighted),
//                         for: .highlighted)
//    button.setTitleColor(Reset._Button.titleColor(for: UIControlState()),
//                         for: UIControlState())
//    button.setTitleColor(Reset._Button.titleColor(for: .reserved),
//                         for: .reserved)
//    button.setTitleColor(Reset._Button.titleColor(for: .selected),
//                         for: .selected)
//
//    button.setTitleShadowColor(Reset._Button.titleShadowColor(for: .disabled),
//                               for: .disabled)
//    if #available(iOS 9.0, *) {
//      button.setTitleShadowColor(Reset._Button.titleShadowColor(for: .focused),
//                                 for: .focused)
//    } else {
//      // Fallback on earlier versions
//    }
//    button.setTitleShadowColor(Reset._Button.titleShadowColor(for: .highlighted),
//                               for: .highlighted)
//    button.setTitleShadowColor(Reset._Button.titleShadowColor(for: UIControlState()),
//                               for: UIControlState())
//    button.setTitleShadowColor(Reset._Button.titleShadowColor(for: .reserved),
//                               for: .reserved)
//    button.setTitleShadowColor(Reset._Button.titleShadowColor(for: .selected),
//                               for: .selected)
//
//    button.setImage(Reset._Button.image(for: .disabled), for: .disabled)
//    if #available(iOS 9.0, *) {
//      button.setImage(Reset._Button.image(for: .focused), for: .focused)
//    } else {
//      // Fallback on earlier versions
//    }
//    button.setImage(Reset._Button.image(for: .highlighted), for: .highlighted)
//    button.setImage(Reset._Button.image(for: UIControlState()), for: UIControlState())
//    button.setImage(Reset._Button.image(for: .reserved), for: .reserved)
//    button.setImage(Reset._Button.image(for: .selected), for: .selected)
//
//    button.setBackgroundImage(Reset._Button.backgroundImage(for: .disabled),
//                              for: .disabled)
    if #available(iOS 9.0, *) {
//      button.setBackgroundImage(Reset._Button.backgroundImage(for: .focused),
                                //for: .focused)
    } else {
      // Fallback on earlier versions
    }
//    button.setBackgroundImage(Reset._Button.backgroundImage(for: .highlighted),
//                              for: .highlighted)
//    button.setBackgroundImage(Reset._Button.backgroundImage(for: UIControlState()),
//                              for: UIControlState())
//    button.setBackgroundImage(Reset._Button.backgroundImage(for: .reserved),
//                              for: .reserved)
//    button.setBackgroundImage(Reset._Button.backgroundImage(for: .selected),
//                              for: .selected)
//
//    button.setAttributedTitle(Reset._Button.attributedTitle(for: .disabled),
//                              for: .disabled)
//    if #available(iOS 9.0, *) {
//      button.setAttributedTitle(Reset._Button.attributedTitle(for: .focused),
//                                for: .focused)
//    } else {
//      // Fallback on earlier versions
//    }
//    button.setAttributedTitle(Reset._Button.attributedTitle(for: .highlighted),
//                              for: .highlighted)
//    button.setAttributedTitle(Reset._Button.attributedTitle(for: UIControlState()),
//                              for: UIControlState())
//    button.setAttributedTitle(Reset._Button.attributedTitle(for: .reserved),
//                              for: .reserved)
//    button.setAttributedTitle(Reset._Button.attributedTitle(for: .selected),
//                              for: .selected)
    Reset.resetTargets(button)
  }

  fileprivate static let _ImageView = ImageView()
  fileprivate static func resetImageView(_ imageView: ImageView) {
    Reset.resetView(imageView, proto: Reset._ImageView)
    //imageView.backgroundColor = Reset._ImageView.backgroundColor
    imageView.image = Reset._ImageView.image
    imageView.isHighlighted = Reset._ImageView.isHighlighted
//    imageView.highlightedImage = Reset._ImageView.highlightedImage
//    imageView.animationImages = Reset._ImageView.animationImages
//    imageView.highlightedAnimationImages = Reset._ImageView.highlightedAnimationImages
//    imageView.animationDuration = Reset._ImageView.animationDuration
//    imageView.animationRepeatCount = Reset._ImageView.animationRepeatCount
//    imageView.tintColor = Reset._ImageView.tintColor
    Reset.resetTargets(imageView)
  }

  static func resetTargets(_ view: View?) {
    guard let view = view else { return }
    if let control = view as? Control {
//      for target in control.allTargets {
//        control.removeTarget(target, action: nil, for: .allEvents)
//      }
    }
  }
}

extension View {
  func prepareForComponentReuse() {
    Reset.resetView(self)
  }
}

extension Label {
  override func prepareForComponentReuse() {
    Reset.resetLabel(self)
  }
}

#if os(iOS)
extension TextField {
  override func prepareForComponentReuse() {
    Reset.resetTextField(self)
  }
}
#endif

extension TextView {
  override func prepareForComponentReuse() {
    Reset.resetTextView(self)
  }
}

extension Button {
  override func prepareForComponentReuse() {
    Reset.resetButton(self)
  }
}

extension ImageView {
  override func prepareForComponentReuse() {
    Reset.resetImageView(self)
  }
}

extension FlexboxView where Self: View {

  /// content-size calculation for the scrollview should be applied after the layout
  /// This is called after the scroll view is rendered.
  /// TableViews and CollectionViews are excluded from this post-render pass
  func postRender() {
    if let scrollView = self as? ScrollView {
      if let _ = self as? TableView { return }
      if let _ = self as? CollectionView { return }
      scrollView.postRender()
    }
  }
}

extension ScrollView {

  fileprivate func postRender() {
    var x: CGFloat = 0
    var y: CGFloat = 0
    for subview in self.subviews {
      x = subview.frame.maxX > x ? subview.frame.maxX : x
      y = subview.frame.maxY > y ? subview.frame.maxY : y
    }
//    self.contentSize = CGSize(width: x, height: y)
//    self.isScrollEnabled = true
  }
}
