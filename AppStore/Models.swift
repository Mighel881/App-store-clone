//
//  Models.swift
//  AppStore
//
//  Created by Anirudh Bandi on 1/9/18.
//  Copyright © 2018 Anirudh Bandi. All rights reserved.
//

import UIKit

class AppCategory: NSObject {
    
    var type: String?
    var name: String?
    var apps: [App]?
    
    override func setValue(_ value: Any?, forKey key: String) {
        if key == "apps"{
            apps = [App]()
            for dict in value as! [[String:Any]] {
                let app = App()
                app.Category = dict["Category"] as? String
                app.Id = dict["Id"] as? NSNumber
                app.ImageName = dict["ImageName"] as? String
                app.Price = dict["Price"] as? NSNumber
                app.Name = dict["Name"] as? String
                apps?.append(app)
            }
    }
    }
    
    
    static func fetchFeaturedApps(completionHandler: @escaping ([AppCategory]) -> ()) {
       let  urlString = "https://api.letsbuildthatapp.com/appstore/featured"
        
        URLSession.shared.dataTask(with: URL(string: urlString)!) { (data, response, error) in
            guard let data = data else { return }
            
            
            do {
    guard let json  = try JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String:Any] else { return }
                var appCategories = [AppCategory]()
                for dict in json["categories"] as! [[String:Any]] {
                    
                    let appCategory = AppCategory()
                    appCategory.setValue(dict["apps"], forKey: "apps")
                    appCategory.name = dict["name"] as? String
                    appCategory.type = dict["type"] as? String
                    appCategories.append(appCategory)
                    
                }
               // print(appCategories)
                DispatchQueue.main.async {
                    completionHandler(appCategories)
                }
            } catch let err {
                print(err)
            }
            
            
            
        }.resume()
    }
    
}
class App: NSObject {
    
    var Name: String?
    var Id: NSNumber?
    var Category: String?
    var Price: NSNumber?
    var ImageName: String?
}



