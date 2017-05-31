//
//  ViewController.swift
//  Sketch Daily
//
//  Created by Patrick Cooney on 5/30/17.
//  Copyright © 2017 Patrick Cooney. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireSwiftyJSON
import SwiftyJSON

var sketch: String = ""
var date: String = ""

class ViewController: UIViewController {

    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var sketchLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        let parameters: Parameters = ["sort": "new"]
        Alamofire.request("https://www.reddit.com/r/sketchdaily/new.json", method: .get, parameters: parameters, encoding: URLEncoding.default).responseSwiftyJSON { response in
            switch response.result {
            case .success(let json):
                // Use SwiftyJSON instance
                let topicAndDate = json["data"]["children"][0]["data"]["title"].string
                let topicComponents = topicAndDate?.components(separatedBy: "-")
                date = topicComponents![0]
                sketch = topicComponents![1]
                self.sketchLabel.text = sketch.capitalized
                self.dateLabel.text = date
                
            case .failure(let error):
                // Handle error
                print("Error: \(error)")
            }
          
        }

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

