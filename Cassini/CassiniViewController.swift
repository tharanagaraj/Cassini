//
//  CassiniViewController.swift
//  Cassini
//
//  Created by Thara Nagaraj on 11/15/18.
//  Copyright © 2018 Thara Nagaraj. All rights reserved.
//

import UIKit

class CassiniViewController: UIViewController {

    // MARK: - Navigation

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let identifier = segue.identifier{
            if let urlString = DemoURLs.NASA[identifier]{
                if let imageVC = segue.destination.contents as? ImageViewController{
                    imageVC.imageURL = urlString
                    imageVC.title = (sender as? UIButton)?.currentTitle
                }
            }
        }
    }
}

extension UIViewController{
    var contents : UIViewController{
        if let navcon = self as? UINavigationController{
            return navcon.visibleViewController ?? self
        }
        return self
    }
}

