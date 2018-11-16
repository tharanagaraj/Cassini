//
//  ImageViewController.swift
//  Cassini
//
//  Created by Thara Nagaraj on 11/13/18.
//  Copyright © 2018 Thara Nagaraj. All rights reserved.
//

import UIKit

class ImageViewController: UIViewController, UIScrollViewDelegate
{
    var imageURL : URL? {
        didSet{
            image = nil
            if view.window != nil{
            fetchImage()
            }
        }
    }
    
    private var image : UIImage?{
        get{
            return imageView.image
        }
        set{
            imageView.image = newValue
            imageView.sizeToFit()
            scrollView?.contentSize = imageView.frame.size
            spinner?.stopAnimating()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
//        if imageURL == nil{
//            imageURL = DemoURLs.stanford
//        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        if image == nil{
            fetchImage()
        }
        
    }

//    @IBOutlet weak var imageView: UIImageView!
    
    var imageView = UIImageView()
    
    @IBOutlet weak var scrollView: UIScrollView!{
        didSet{
            scrollView.minimumZoomScale = 1/25
            scrollView.maximumZoomScale = 1.0
            scrollView.delegate = self
            scrollView.addSubview(imageView)
        }
    }
    
    @IBOutlet weak var spinner: UIActivityIndicatorView!
    
    
    func viewForZooming(in scrollView: UIScrollView) -> UIView? {
         return imageView
    }
    
    
    
    private func fetchImage(){
        if let url = imageURL{
            spinner.startAnimating()
            DispatchQueue.global(qos: .userInitiated).async {[weak self] in
                let urlContents = try? Data(contentsOf: url)
                DispatchQueue.main.async {
                    if let imageData = urlContents, url == self?.imageURL{
                        self?.image = UIImage(data: imageData)
                    }
                }
                
            }
        }
    }
}
