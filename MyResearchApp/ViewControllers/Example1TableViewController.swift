//
//  Example1TableViewController.swift
//  MyResearchApp
//
//  Created by Hugo Rosado on 12/18/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit

class Example1TableViewController: UITableViewController {
  
  private var array: [String]!
  private var headerView: Example1TableHeaderView!
  private var imageHeight: CGFloat!
  private var secondNavigationBar: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "First View Controller"
    let bookmarks = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: nil, action: nil)
    bookmarks.tintColor = UIColor(named: "SecondColor")
    navigationItem.setLeftBarButtonItems([
      bookmarks
    ], animated: true)
    let play = UIBarButtonItem(barButtonSystemItem: .play, target: nil, action: nil)
    play.tintColor = UIColor(named: "SecondColor")
    navigationItem.setRightBarButtonItems([
      play
    ], animated: true)
    
    array = []
    imageHeight = 300
    guard let statusBarSize = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size,
      let navigationBarSize = navigationController?.navigationBar.bounds.size else {
        fatalError("Sizes should not be empty")
    }
    
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
    updateBarTitleAlpha(with: 0)
    
    secondNavigationBar = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: statusBarSize.height + navigationBarSize.height))
    secondNavigationBar.backgroundColor = .systemBackground
    secondNavigationBar.isHidden = true
    view.addSubview(secondNavigationBar)
    
    headerView = Example1TableHeaderView.get(owner: self)
    headerView.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: imageHeight))
    let view = UIView(frame: headerView.frame)
    view.addSubview(headerView)
    tableView.contentInsetAdjustmentBehavior = .never
    tableView.tableHeaderView = view
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    tableView.tableFooterView = UIView()
    
    array.append(contentsOf: [
      "TableView without TableViewController",
      "Segment Control with TableViewController",
      "Segment Control with TableView (inside a ViewController)",
      "Segment Control with CollectionView"
    ])
    for i in 0..<20 {
      array.append("Title \(i + 1)")
    }
    
    NotificationCenter.default.addObserver(self, selector: #selector(didOrientationChange), name: UIDevice.orientationDidChangeNotification, object: nil)
  }
  
  deinit {
    NotificationCenter.default.removeObserver(self, name: UIDevice.orientationDidChangeNotification, object: nil)
  }
  
  @objc func didOrientationChange() {
    guard let statusBarSize = UIApplication.shared.windows.first?.windowScene?.statusBarManager?.statusBarFrame.size,
      let navigationBarSize = navigationController?.navigationBar.bounds.size else {
        fatalError("Sizes should not be empty")
    }
    guard secondNavigationBar.bounds.width != navigationBarSize.width else {
      return
    }
    print("##StatusBarSize: \(statusBarSize)")
    print("##NavigationBarSize: \(navigationBarSize)")
    DispatchQueue.main.async {
      self.secondNavigationBar.frame.size = CGSize(width: navigationBarSize.width, height: navigationBarSize.height + statusBarSize.height)
    }
  }
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let headerHeight: CGFloat = (imageHeight - scrollView.contentOffset.y > 0) ? imageHeight - scrollView.contentOffset.y : 0
    print("sv_y: \(scrollView.contentOffset.y)")
    print("HeaderView Height: \(headerHeight)")
    headerView.frame = CGRect(x: 0, y: scrollView.contentOffset.y, width: UIScreen.main.bounds.width, height: headerHeight)
    secondNavigationBar.frame = CGRect(origin: CGPoint(x: 0, y: scrollView.contentOffset.y), size: secondNavigationBar.bounds.size)
    
    setupNavigationBar(headerHeight: headerHeight)
  }
  
  func setupNavigationBar(headerHeight: CGFloat) {
    if headerHeight < 100 {
      secondNavigationBar.isHidden = false
      secondNavigationBar.alpha = 1 - (headerHeight / 100)
      updateBarTitleAlpha(with: 1 - (headerHeight / 100))
    } else if headerHeight == 0 {
      secondNavigationBar.alpha = 1
      updateBarTitleAlpha(with: 1)
    } else {
      secondNavigationBar.isHidden = true
      secondNavigationBar.alpha = 0
      updateBarTitleAlpha(with: 0)
    }
  }
  
  func updateBarTitleAlpha(with alpha: CGFloat) {
    navigationController?.navigationBar.titleTextAttributes = [
      .foregroundColor: UIColor.label.withAlphaComponent(alpha)
    ]
  }
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as UITableViewCell
    
    cell.textLabel?.text = array[indexPath.row]
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    switch indexPath.row {
    case 0:
      performSegue(withIdentifier: "showSecondTableView", sender: nil)
    case 1:
      performSegue(withIdentifier: "showSegmentedControlWithTableViewController", sender: nil)
    case 2:
      performSegue(withIdentifier: "showSegmentedControlWithTableView", sender: nil)
    case 3:
      performSegue(withIdentifier: "showSegmentedControlWithCollectionView", sender: nil)
    default:
      break
    }
    
    tableView.deselectRow(at: indexPath, animated: true)
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
  }
  
}
