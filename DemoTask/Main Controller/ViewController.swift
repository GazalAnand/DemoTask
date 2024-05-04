//
//  ViewController.swift
//  DemoTask
//
//  Created by Pankaj on 04/05/24.
//

import UIKit
import CRRefresh
class ViewController: UIViewController {

    @IBOutlet var listingTbl: UITableView!
    
    
    var listingArr = [[String:Any]]()
    var duplicateListArr = [[String : Any]]()
    var pagination = 1
    var totalPages = 10
    var selectedValue = [String:Any]()
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        listingTbl.delegate = self
        listingTbl.dataSource = self
        listingTbl.registerCellFrom("listingTableCell")
        CLProgressHUD.show()
        self.getList("\(self.pagination)")
        
       
    }
    
    // MARK: - get Question list
    func getList(_ pageNumber:String) {
       let urlStr = "https://jsonplaceholder.typicode.com/posts?_page=\(pageNumber)&_limit=10"
        
        WebserviceClass.shared.postMethodWithoutHeaderApi([:], urlstring: urlStr, completion: { (response, error) in
            if response != nil {
                CLProgressHUD.dismiss(animated: true)
                let  jsonobj = response! as [[String:Any]]
                print(jsonobj)
                
                if jsonobj.count > 0 {
                    self.listingArr.removeAll()
                    
                    self.listingArr = self.duplicateListArr + jsonobj
                   // self.chatListArr = jsonData + self.chatDuplicateListArr
                    self.duplicateListArr = self.listingArr
                    print(self.listingArr)
                    
                    if self.listingArr.count > 0 {
                    DispatchQueue.main.async {
                        let indexPath = IndexPath(row: self.listingArr.count-1, section: 0)
                        self.listingTbl.scrollToRow(at: indexPath, at: .bottom, animated: false)
                        }

                    }
                    self.listingTbl.cr.endLoadingMore()
                    self.listingTbl.cr.noticeNoMoreData()
                    self.listingTbl.cr.resetNoMore()
                    self.listingTbl.cr.endHeaderRefresh()
                    self.listingTbl.reloadData()
                    self.pagination = self.pagination + 1
                }

            }else {
                CLProgressHUD.dismiss(animated: true)
               
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vw = segue.destination as? DetailViewController {
            vw.detailObject = selectedValue
        }
    }

}

extension ViewController:UITableViewDelegate,UITableViewDataSource,UIScrollViewDelegate {
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if (listingTbl.contentOffset.y + listingTbl.frame.size.height) >= listingTbl.contentSize.height - 50 {
            listingTbl.cr.addFootRefresh(animator: NormalFooterAnimator()) { [weak self] in
                self?.getList("\(self?.pagination ?? 1)")
            }
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listingArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
       
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "listingTableCell") as? listingTableCell else {
            return UITableViewCell()
        }
        let dataObject = listingArr[indexPath.row]
        cell.titleLbl.text = "\(dataObject["id"] as? Int ?? 0) : \(dataObject["title"] as? String ?? "")"
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedValue = listingArr[indexPath.row]
        self.performSegue(withIdentifier: "ListToDetail", sender: self)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
}
