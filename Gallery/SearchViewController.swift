//
//  SearchViewController.swift
//  Gallery
//
//  Created by Apple on 30/03/2017.
//  Copyright © 2017 Apple. All rights reserved.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var SearchButton: UIButton!
    @IBOutlet weak var SearchText: UITextField!
    
    static var urlSearch: String!
    
    @IBAction func OnClickSearchButton(_ sender: Any) {
        SearchText.resignFirstResponder()
        
        var dictRoot: NSDictionary?
        if let path = Bundle.main.path(forResource: "Config", ofType: "plist") {
            dictRoot = NSDictionary(contentsOfFile: path)
        }
        
        let api_key = dictRoot!["api_key"]
        
        SearchViewController.urlSearch = "https://api.flickr.com/services/rest/?method=flickr.photos.search&api_key=\(api_key!)&tags=\(SearchText.text!)&format=json&nojsoncallback=1"
        
        SearchText.text = ""
        
        
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.SearchText.becomeFirstResponder()
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
