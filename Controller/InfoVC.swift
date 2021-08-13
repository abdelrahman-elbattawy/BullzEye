//
//  InfoVC.swift
//  BullzEye
//
//  Created by Aboody on 04/06/2021.
//

import UIKit
import WebKit

class InfoVC: UIViewController {
    
    //MARK: - Outlets
    @IBOutlet weak var myWebView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        loadHTMLFile()
    }
    
    //MARK: - IBActions
    @IBAction func closeBtnPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    //MARK: - Helper Functions
    func loadHTMLFile(){
        guard let htmlPath = Bundle.main.path(forResource: "BullsEye", ofType: "html") else {return}
        
        let htmlURL = URL(fileURLWithPath: htmlPath)
        let htmlRequest = URLRequest(url: htmlURL)
        myWebView.load(htmlRequest)
    }
}
