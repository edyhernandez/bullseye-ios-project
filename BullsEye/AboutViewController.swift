//
//  AboutViewController.swift
//  BullsEye
//
//  Created by Edy Hernandez on 8/9/16.
//  Copyright © 2016 Edy Hernandez. All rights reserved.
//

import UIKit

class AboutViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let htmlFile = NSBundle.mainBundle().pathForResource("BullsEye", // This loads the local html file into the web view!
                                                        ofType: "html") {
            if let htmlData = NSData(contentsOfFile: htmlFile) { // Loads the html file into an NSData object
                let baseURL = NSURL(fileURLWithPath:
                                            NSBundle.mainBundle().bundlePath)
                webView.loadData(htmlData, MIMEType: "text/html", // Asks the web view to show the contents of this data object 
                                 textEncodingName: "UTF-8", baseURL: baseURL)
            }
        }
    }

    @IBOutlet weak var webView: UIWebView!
    
    @IBAction func close() {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
}
