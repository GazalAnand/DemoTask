//
//  DetailViewController.swift
//  DemoTask
//
//  Created by Pankaj on 04/05/24.
//

import UIKit

class DetailViewController: UIViewController {

    @IBOutlet var detailTxtvw: UITextView!
    @IBOutlet var titleLbl: UILabel!
    
    var detailObject = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        titleLbl.text = detailObject["title"] as? String
        detailTxtvw.text = detailObject["body"] as? String
    }

    @IBAction func backButtonAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
