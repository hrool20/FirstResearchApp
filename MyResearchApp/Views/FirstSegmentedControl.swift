//
//  FirstSegmentedControl.swift
//  MyResearchApp
//
//  Created by Hugo Rosado on 12/30/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit

protocol FirstSegmentedControlDelegate: class {
  func didChangeTab(toIndex index: Int)
}

class FirstSegmentedControl: UIView {

  @IBOutlet weak var firstView: UIView!
  @IBOutlet weak var firstStackView: UIStackView!
  @IBOutlet weak var selectorView: UIView!
  @IBOutlet weak var selectorViewToSuperviewLeadingConstraint: NSLayoutConstraint!
  @IBOutlet weak var superviewToSelectorViewTrailingConstraint: NSLayoutConstraint!
  @IBOutlet weak var selectorViewWidthConstraint: NSLayoutConstraint!
  weak var delegate: FirstSegmentedControlDelegate?
  private var buttons: [UIButton]!
  private var _selectedIndex: Int!
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
    tabs = []
    textColor = .label
    selectedTextColor = UIColor(named: "FirstColor") ?? .red
    selectorViewColor = UIColor(named: "FirstColor") ?? .red
    
    self.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: firstView.bounds.height))
  }
  
  func createTabs() {
    buttons.removeAll()
    
    firstStackView.subviews.forEach { (view) in
      view.removeFromSuperview()
    }
    
    for tab in tabs {
      let button = UIButton(type: .system)
      button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 13)
      button.setTitleColor(textColor, for: .normal)
      button.setTitle(tab, for: .normal)
      button.addTarget(self, action: #selector(didShowTabContent(sender:animated:)), for: .touchUpInside)
      buttons.append(button)
      firstStackView.addArrangedSubview(button)
    }
    
    buttons.first?.setTitleColor(selectedTextColor, for: .normal)
    updateSelectorViewSize()
  }
  
  func updateSelectorViewSize() {
    selectorViewWidthConstraint.priority = tabs.count > 1 ? .required : .defaultLow
    selectorViewWidthConstraint.constant = bounds.width / CGFloat(tabs.count)
  }
  
  @objc func didShowTabContent(sender: UIButton, animated: Bool = true) {
    var selectorViewPosition: CGFloat = selectorViewToSuperviewLeadingConstraint.constant
    
    for (index, button) in buttons.enumerated() {
      button.setTitleColor(textColor, for: .normal)
      if button == sender {
        selectorViewPosition = selectorViewWidthConstraint.constant * CGFloat(index)
        delegate?.didChangeTab(toIndex: index)
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
    
    didShowTabContent(sender: buttons[index], animated: animated)
  }
  
  /*
  // Only override draw() if you perform custom drawing.
  // An empty implementation adversely affects performance during animation.
  override func draw(_ rect: CGRect) {
  // Drawing code
  }
  */

}
