//
//  UITableView+Extension.swift
//  Jugnoo Driver
//
//  Created by cl-macmini-67 on 28/03/18.
//  Copyright © 2018 Socomo. All rights reserved.
//

import Foundation
import UIKit

extension UITableView {
  func registerCellFrom(_ string: String) {
    self.register(UINib.init(nibName: string, bundle: Bundle.main), forCellReuseIdentifier: string)
  }
    
    func registerHeaderFooterView(_ string: String) {
        self.register(UINib(nibName: string, bundle: Bundle.main), forHeaderFooterViewReuseIdentifier: string)
    }
}
