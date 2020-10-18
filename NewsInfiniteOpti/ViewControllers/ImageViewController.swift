//
//  ImageViewController.swift
//  NewsInfiniteOpti
//
//  Created by Rudresh Uppin on 16/10/20.
//  Copyright © 2020 Rudresh Uppin. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController {
    
    
    var imageshowto = String()
    
    @IBOutlet weak var imageShowview: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        print("imageshowto",imageshowto)
        let url = URL(string: imageshowto)
        let data = try? Data(contentsOf: url!)
        self.imageShowview.image = UIImage(data: data!)
        
        
        
    }
    
    
}
