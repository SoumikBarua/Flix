//
//  TrailerViewController.swift
//  Flix
//
//  Created by SB on 10/2/20.
//  Copyright © 2020 SB. All rights reserved.
//

import UIKit
import WebKit

class TrailerViewController: UIViewController {

    @IBOutlet weak var webView: WKWebView!
    
    var trailerKey = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let url = URL(string: "https://www.youtube.com/watch?v=\(trailerKey)") {
            print("trailerKey is \(trailerKey)")
            let request = URLRequest(url: url)
            webView.load(request)
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
