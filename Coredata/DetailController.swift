//
//  DetailController.swift
//  Coredata
//
//  Created by manish on 22/01/18.
//  Copyright © 2018 manish. All rights reserved.
//

import UIKit

class DetailController: UIViewController {

    var book: Book?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.\
        print(book?.name ?? "")
    }
    
}
