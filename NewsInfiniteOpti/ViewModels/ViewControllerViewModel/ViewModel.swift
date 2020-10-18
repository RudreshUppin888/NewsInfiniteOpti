//
//  ViewModel.swift
//  NewsInfiniteOpti
//
//  Created by Rudresh Uppin on 17/10/20.
//  Copyright © 2020 Rudresh Uppin. All rights reserved.
//

import Foundation
import  UIKit

class ViewModel{
    
    weak var vc: ViewController?
    
    var datasourceArray = [UsersMainResponse]()
    var ArticelsArray = [Articles]()
    var SourceArray = [Source]()
    
    var NameArray = [String]()
    var ImageArray = [String]()
    var TimeArray = [String]()
    
      var number = 1
      var rowNumber = 3
      var NewsQuantity:Int = 2000

 //Mark: Function to get UserMainResonsedata,Articlesdata,SourceData
    typealias completionBlock = ([Source]) -> ()
    func getDataFromApi(withUrl strUrl : String, completionBlock : @escaping completionBlock){
        
        if let unwrappedUrl = URL(string: strUrl){
            
            URLSession.shared.dataTask(with: unwrappedUrl, completionHandler: { [weak self] (data, response, error) in
                
                guard let data = data, error == nil, response != nil else {
                    print("something is wrong with url")
                    return
                }
                
                do {
                    let userResponse = try JSONDecoder().decode(UsersMainResponse.self, from: data)
                    self?.datasourceArray.append(userResponse)
                    
                    guard let valuedatasource = self?.datasourceArray else { return }
                    for usersdata in valuedatasource {
                        let articlesDemo = usersdata.articles
                        self?.ArticelsArray.append(contentsOf: articlesDemo!)
                    }
                    
                    guard let valuesArticals = self?.ArticelsArray else { return }
                    for users in valuesArticals{
                        let varticlesDemo  = users.source
                        self?.SourceArray.append(varticlesDemo!)
                        
                        let urlToImageDemo  = users.urlToImage
                        self?.ImageArray.append(urlToImageDemo!)
                        
                        let timeDemo  = users.publishedAt
                        self?.TimeArray.append(timeDemo!)
                        print("timeDemo",timeDemo as AnyObject)
                    }
                    
                    guard let valuesSourceArray = self?.SourceArray else { return }
                    for names in valuesSourceArray{
                        let nameDemo = names.name
                        self?.NameArray.append(nameDemo!)
                    }
                    completionBlock(valuesSourceArray)
                    
                } catch let err{
                    //self.showErrorAlertMessage(message: error.localizedDescription, title: "Some error")
                    print("error",err.localizedDescription)
                }
            }).resume()
        }
    }
    
    //Mark: Function to make viewcontroller tableviewcell image rounded.
    func CellImageRound(cell: ViewTableViewCell){
        cell.imageShow.layer.cornerRadius = cell.imageShow.bounds.size.width / 2.0
        cell.imageShow.layer.shadowColor = UIColor.black.cgColor
        cell.imageShow.layer.shadowOpacity = 0.8
        cell.imageShow.layer.borderWidth = 2.0
        cell.imageShow.layer.borderColor = UIColor.white.cgColor
        cell.imageShow.layer.masksToBounds = true
        cell.imageShow.clipsToBounds = true
    }
    
}



