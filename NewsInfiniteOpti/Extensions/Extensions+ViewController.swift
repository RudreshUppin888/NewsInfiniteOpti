//
//  Extensions+ViewController.swift
//  NewsInfiniteOpti
//
//  Created by Rudresh Uppin on 16/10/20.
//  Copyright © 2020 Rudresh Uppin. All rights reserved.
//

import Foundation
import UIKit

@available(iOS 10.0, *)

extension ViewController: UITableViewDelegate,UITableViewDataSource, UIGestureRecognizerDelegate{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt  indexPath: IndexPath) {
        performSegue(withIdentifier: "Second", sender: self)
    }
    
    //MARK: Function for tableview numberOfRowsInSection
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.NameArray.count
    }
    
    //MARK: Function for tableview cellForRowAt index path
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as! ViewTableViewCell
        cell.labelName?.text = viewModel.NameArray[indexPath.row]
        cell.labelTime?.text = viewModel.TimeArray[indexPath.row]
        
        let url = URL(string: viewModel.ImageArray[indexPath.row])
        
        let ai = UIActivityIndicatorView(frame: cell.imageShow.frame)
        // Add the UIActivityIndicatorView as a subview on the cell
        cell.addSubview(ai)
        // Start the UIActivityIndicatorView animating
        ai.startAnimating()
        
        DispatchQueue.global().async(){
            let data = try? Data(contentsOf: url!)
            DispatchQueue.main.async {
                self.dismiss(animated: false, completion: nil)
                cell.imageShow.image = UIImage(data: data!)
                ai.stopAnimating()
                //Mark: Function to make viewcontroller tableviewcell image rounded.
                self.viewModel.CellImageRound(cell: cell)
            }
        }
        return cell
    }
    
    //Mark: Function to Choose your custom row heigh
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 150
    }
    
    
    //MARK: Function to copy the image in string litral
    func tableView(_ tableView: UITableView, shouldShowMenuForRowAt indexPath: IndexPath) -> Bool {
        
        return (tableView.cellForRow(at: indexPath) != nil)
    }
    
    //MARK: Function to copy the image in string litral
    func tableView(_ tableView: UITableView, canPerformAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) -> Bool {
        return action == #selector(copy(_:))
    }
    
    //MARK: Function to copy the image in string litral
    func tableView(_ tableView: UITableView, performAction action: Selector, forRowAt indexPath: IndexPath, withSender sender: Any?) {
        if action == #selector(copy(_:)) {
            let customlabel3 = viewModel.ImageArray[indexPath.row]
            let pasteboard = UIPasteboard.general
            pasteboard.string = "\(customlabel3)"
            print("customlabel3",customlabel3)
            self.Alert()
        }
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        
        // Checks if we're in the last cell
        if indexPath.section == lastSectionIndex && indexPath.row == lastRowIndex && viewModel.NameArray.count < viewModel.NewsQuantity {
            
            // Set button at tableView footer
            self.tableview.tableFooterView = button
            self.tableview.tableFooterView?.isHidden = false
            
            // Loading results when button clicked
            button.addTarget(self, action: #selector(loadByDemand), for: .touchUpInside)
        } else {
            
            // Hide button if there is no more news data to load
            if viewModel.NameArray.count == viewModel.NewsQuantity {
                self.tableview.tableFooterView?.isHidden = true
            }
        }
    }
    
    // Load the next news list
    @objc func loadByDemand() {
        
        // Increase list number by 1
        viewModel.number += 1
        
        if viewModel.number <= viewModel.NameArray.count {
            viewModel.getDataFromApi(withUrl: EndPoint.strUrl){ (_) in
                
            }
            self.tableview.reloadData()
            
            // Fix cells jumping when loading data
            self.tableview.scrollToRow(at: [0, viewModel.rowNumber], at: .middle, animated: false)
            viewModel.rowNumber += 4
        }
    }
    
    
}

