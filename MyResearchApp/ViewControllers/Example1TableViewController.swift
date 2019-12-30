//
//  Example1TableViewController.swift
//  MyResearchApp
//
//  Created by Hugo Rosado on 12/18/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit

class Example1TableViewController: UITableViewController {
  
  private var array: [(title: String, description: String)]!
  private var headerView: Example1TableHeaderView!
  private var imageHeight: CGFloat!
  private var secondNavigationBar: UIView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    navigationItem.title = "First View Controller"
    let bookmarks = UIBarButtonItem(barButtonSystemItem: .bookmarks, target: nil, action: nil)
    bookmarks.tintColor = UIColor(named: "FirstColor")
    navigationItem.setLeftBarButtonItems([
      bookmarks
    ], animated: true)
    let play = UIBarButtonItem(barButtonSystemItem: .play, target: nil, action: nil)
    play.tintColor = UIColor(named: "FirstColor")
    navigationItem.setRightBarButtonItems([
      play
    ], animated: true)
    
    array = []
    imageHeight = 300
    
    navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
    navigationController?.navigationBar.shadowImage = UIImage()
    navigationController?.navigationBar.isTranslucent = true
    updateBarTitleAlpha(with: 0)
    
    secondNavigationBar = UIView(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 64))
    secondNavigationBar.backgroundColor = .systemBackground
    secondNavigationBar.isHidden = true
    view.addSubview(secondNavigationBar)
    
    tableView.contentInsetAdjustmentBehavior = .never
    headerView = Example1TableHeaderView.get(owner: self)
    headerView.frame = CGRect(origin: .zero, size: CGSize(width: UIScreen.main.bounds.width, height: imageHeight))
    let view = UIView(frame: headerView.frame)
    view.addSubview(headerView)
    tableView.tableHeaderView = view
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    tableView.tableFooterView = UIView()
    
    for i in 0..<30 {
      array.append(("Title \(i + 1)", "Description \(i + 1)"))
    }
  }
  
  override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
    super.viewWillTransition(to: size, with: coordinator)
    
    secondNavigationBar.frame.size = CGSize(width: UIScreen.main.bounds.width, height: (UIDevice.current.orientation == .portrait) ? 64.0 : 32.0)
  }
  
  override func scrollViewDidScroll(_ scrollView: UIScrollView) {
    let headerHeight: CGFloat = (imageHeight - scrollView.contentOffset.y > 0) ? imageHeight - scrollView.contentOffset.y : 0
    print("sv_y: \(scrollView.contentOffset.y)")
    print("HeaderView Height: \(headerHeight)")
    headerView.frame = CGRect(x: 0, y: scrollView.contentOffset.y, width: UIScreen.main.bounds.width, height: headerHeight)
    secondNavigationBar.frame = CGRect(origin: CGPoint(x: 0, y: scrollView.contentOffset.y), size: secondNavigationBar.bounds.size)
    
    setupNavigationBar(headerHeight: headerHeight)
  }
  
  func updateBarTitleAlpha(with alpha: CGFloat) {
    navigationController?.navigationBar.titleTextAttributes = [
      .foregroundColor: UIColor.label.withAlphaComponent(alpha)
    ]
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
  
  // MARK: - Table view data source
  
  override func numberOfSections(in tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return array.count
  }
  
  override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath) as UITableViewCell
    
    cell.textLabel?.text = array[indexPath.row].title
    
    return cell
  }
  
  // MARK: - Navigation
  
  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
  }
  
}
