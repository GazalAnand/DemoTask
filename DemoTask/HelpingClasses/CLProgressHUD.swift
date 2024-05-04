

import UIKit
import SVProgressHUD

class CLProgressHUD: SVProgressHUD {
  
  class func present(animated: Bool, status: String = "") {
    self.setDefaultStyle(SVProgressHUDStyle.custom)
    self.setDefaultMaskType(.gradient)
    self.setBackgroundColor(UIColor.white)
    self.setRingThickness(3)
      self.setForegroundColor(UIColor(red: 74.0/255.0, green: 178.0/255.0, blue: 106.0/255.0,alpha: 1.0))
    if status.isEmpty {
      self.show()
    } else {
      self.show(withStatus: status)
    }
  }
  
  class func dismiss(animated: Bool) {
    SVProgressHUD.dismiss()
  }
  
}
