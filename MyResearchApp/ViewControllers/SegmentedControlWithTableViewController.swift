//
//  SegmentedControlWithTableViewController.swift
//  MyResearchApp
//
//  Created by Hugo Rosado on 12/30/19.
//  Copyright © 2019 UPC. All rights reserved.
//

import UIKit

class SegmentedControlWithTableViewController: UITableViewController {

  private var array: [(title1: String, title2: String)]!
  private var firstSegmentedControl: FirstSegmentedControl!
  
  override func viewDidLoad() {
    super.viewDidLoad()

    array = []
    firstSegmentedControl = FirstSegmentedControl.get(owner: self)
    firstSegmentedControl.delegate = self
    firstSegmentedControl.tabs = [
      "My Tab",
      "Description"
    ]
    let view = UIView(frame: firstSegmentedControl.frame)
    view.addSubview(firstSegmentedControl)
    tableView.tableHeaderView = view
    tableView.register(UITableViewCell.self, forCellReuseIdentifier: "reuseIdentifier")
    tableView.tableFooterView = UIView()
    
    for i in 0..<10 {
      array.append(("My first title \(i + 1)", "My second title \(i + 1)"))
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
    
    cell.textLabel?.text = firstSegmentedControl.selectedIndex == 0 ? array[indexPath.row].title1 : array[indexPath.row].title2
    
    return cell
  }
  
  override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
    tableView.deselectRow(at: indexPath, animated: true)
  }

  // MARK: - Navigation

  // In a storyboard-based application, you will often want to do a little preparation before navigation
  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    // Get the new view controller using segue.destination.
    // Pass the selected object to the new view controller.
  }

}
extension SegmentedControlWithTableViewController: FirstSegmentedControlDelegate {
  func didChangeTab(toIndex index: Int) {
    tableView.reloadData()
  }
}
