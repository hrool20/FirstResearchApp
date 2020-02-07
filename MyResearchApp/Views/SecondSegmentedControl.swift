//
//  SecondSegmentedControl.swift
//  MyResearchApp
//
//  Created by Hugo Rosado on 1/3/20.
//  Copyright © 2020 UPC. All rights reserved.
//

import UIKit

protocol SecondSegmentedControlDelegate: class {
  func didChangeTab(toIndex index: Int, isPageShowed: Bool)
}

class SecondSegmentedControl: UICollectionReusableView {

  @IBOutlet weak var firstView: UIView!
  @IBOutlet weak var firstStackView: UIStackView!
  @IBOutlet weak var selectorView: UIView!
  @IBOutlet weak var firstViewHeightConstraint: NSLayoutConstraint!
  @IBOutlet weak var selectorViewToSuperviewLeadingConstraint: NSLayoutConstraint!
  @IBOutlet weak var superviewToSelectorViewTrailingConstraint: NSLayoutConstraint!
  @IBOutlet weak var selectorViewWidthConstraint: NSLayoutConstraint!
  weak var delegate: SecondSegmentedControlDelegate?
  private var buttons: [UIButton]!
  private var _selectedIndex: Int!
  private var animated: Bool!
  var segmentedControlHeight: CGFloat?
  var selectedIndex: Int {
    return _selectedIndex
  }
  var tabs: [String]! {
    didSet {
      guard tabs != nil && !tabs.isEmpty else {
        return
      }
      
      createTabs()
    }
  }
  var textColor: UIColor!
  var selectedTextColor: UIColor!
  var selectorViewColor: UIColor!
  
  override func awakeFromNib() {
    super.awakeFromNib()
    
    buttons = []
    _selectedIndex = 0
    animated = true
    tabs = []
    textColor = .label
    selectedTextColor = UIColor(named: "FirstColor") ?? .red
    selectorViewColor = UIColor(named: "FirstColor") ?? .red
    
    self.firstViewHeightConstraint.constant = (segmentedControlHeight == nil) ? firstViewHeightConstraint.constant : segmentedControlHeight!
    
    self.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: firstView.bounds.height))
  }
  
  private func createTabs() {
    buttons.removeAll()
    
    firstStackView.subviews.forEach { (view) in
      view.removeFromSuperview()
    }
    
    for tab in tabs {
      let button = UIButton(type: .system)
      button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
      button.setTitleColor(textColor, for: .normal)
      button.setTitle(tab, for: .normal)
      button.addTarget(self, action: #selector(didShowTabContent(sender:)), for: .touchUpInside)
      buttons.append(button)
      firstStackView.addArrangedSubview(button)
    }
    
    buttons.first?.setTitleColor(selectedTextColor, for: .normal)
    updateSelectorViewSize()
  }
  
  private func updateSelectorViewSize() {
    selectorViewWidthConstraint.priority = tabs.count > 1 ? .required : .defaultLow
    selectorViewWidthConstraint.constant = bounds.width / CGFloat(tabs.count)
  }
  
  @objc private func didShowTabContent(sender: UIButton) {
    animated = true
    showTabContent(sender: sender)
  }
  
  private func showTabContent(sender: UIButton) {
    var selectorViewPosition: CGFloat = selectorViewToSuperviewLeadingConstraint.constant
    
    for (index, button) in buttons.enumerated() {
      button.setTitleColor(textColor, for: .normal)
      if button == sender {
        selectorViewPosition = selectorViewWidthConstraint.constant * CGFloat(index)
        delegate?.didChangeTab(toIndex: index, isPageShowed: false)
        _selectedIndex = index
      }
    }
    
    UIView.animate(withDuration: animated ? 0.3 : 0.0) {
      self.selectorViewToSuperviewLeadingConstraint.constant = selectorViewPosition
      sender.setTitleColor(self.selectedTextColor, for: .normal)
      self.firstView.layoutIfNeeded()
    }
  }
  
  func setTab(toIndex index: Int, animated: Bool = true) {
    guard buttons.count > index else {
      fatalError("Index has to be lower than the number of buttons.")
    }
    self.animated = animated
    showTabContent(sender: buttons[index])
  }
  
  public func moveTabContent(scrollView: UIScrollView, didEndDecelerating: Bool = false) {
    let page = scrollView.currentPage
    let progress = scrollView.currentProgress
    
    if progress > 0.0 && progress < CGFloat(tabs.count - 1) {
      let selectorViewPosition = selectorViewWidthConstraint.constant * progress
      self.selectorViewToSuperviewLeadingConstraint.constant = selectorViewPosition
    } else {
      let selectorViewPosition: CGFloat
      if progress <= 0 {
        selectorViewPosition = selectorViewWidthConstraint.constant * progress * 3
      } else {
        selectorViewPosition = selectorViewWidthConstraint.constant + selectorViewWidthConstraint.constant * (progress - 1) * 3
      }
      self.selectorViewToSuperviewLeadingConstraint.constant = selectorViewPosition
    }
    
    guard page != _selectedIndex && didEndDecelerating else {
      return
    }
    for (index, button) in buttons.enumerated() {
      button.setTitleColor(textColor, for: .normal)
      if button == buttons[page] {
        delegate?.didChangeTab(toIndex: index, isPageShowed: true)
        _selectedIndex = index
        self.buttons[page].setTitleColor(self.selectedTextColor, for: .normal)
      }
    }
  }
  
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
