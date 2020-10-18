//
//  ViewController.swift
//  NewsInfiniteOpti
//
//  Created by Rudresh Uppin on 16/10/20.
//  Copyright © 2020 Rudresh Uppin. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tableview: UITableView!
    
      var viewModel = ViewModel()
    
      var button: UIButton!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        tableview.delegate = self
        tableview.dataSource = self
        
        viewModel.vc = self
        self.ShowIndicator()
        viewModel.getDataFromApi(withUrl: EndPoint.strUrl){ (_) in
            DispatchQueue.main.async { [weak self] in
                self?.tableview.reloadData()
            }
        }
                               
            // Setup - Load more button
            button = UIButton(frame: CGRect(x: 0, y: 0, width: tableview.bounds.width, height: 45))
            button.setTitleColor(.blue, for: .normal)
            button.setTitle("Load more News", for: .normal)
 
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "Second") {
            let index = self.tableview.indexPathForSelectedRow
            let indexNumber = index?.row //0,1,2,3
            let vc = segue.destination as! ImageViewController
            vc.imageshowto =  viewModel.ImageArray[indexNumber!]
        }
    }
    
    //Mark: Function to show UIActivityIndicatorView.
    func ShowIndicator(){
        let alert = UIAlertController(title: nil, message: "Please wait...", preferredStyle: .alert)
        let loadingIndicator = UIActivityIndicatorView(frame: CGRect(x: 10, y: 5, width: 50, height: 50))
        loadingIndicator.hidesWhenStopped = true
        loadingIndicator.style = UIActivityIndicatorView.Style.gray
        loadingIndicator.startAnimating();
        alert.view.addSubview(loadingIndicator)
        present(alert, animated: true, completion: nil)
    }
    
    //Mark: Function to show AlertView.
    func Alert(){
        let alert = UIAlertController(title: "Copied", message: "Image is copied to clipboard", preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
}
