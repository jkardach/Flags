//
//  WebVC.swift
//  Flags
//
//  Created by jim kardach on 5/6/21.
//

import UIKit
import WebKit

class WebVC: UIViewController {
    @IBOutlet var webView: WKWebView!
    var urlString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)

        if !urlString.contains("https") {
            urlString = urlString.replacingOccurrences(of: "http", with: "https")
        }
        // Do any additional setup after loading the view.
        if let urlToDo = URL(string: urlString) {
            let request = URLRequest(url: urlToDo)
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
