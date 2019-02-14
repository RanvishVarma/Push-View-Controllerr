//
//  ViewController.swift
//  PageViewController
//
//  Created by Allvy on 24/10/18.
//  Copyright © 2018 Allvy. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UIScrollViewDelegate {

    
    @IBOutlet weak var getStartedButton: UIButton!
    @IBOutlet weak var pageControl: UIPageControl!
    
     var scrollView = UIScrollView()
    
    var yPosition:CGFloat = 0
    var scrollViewContentSize:CGFloat=0;
    
    var timer = Timer()
    
     let imagelist = ["image1.jpg","image3.jpg"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
            scrollView = UIScrollView(frame: CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height))
        
        scrollView.delegate = self
        self.view.addSubview(scrollView)
        for  i in stride(from: 0, to: imagelist.count, by: 1) {
            var frame = CGRect.zero
            frame.origin.x = self.scrollView.frame.size.width * CGFloat(i)
            frame.origin.y = 0
            frame.size = self.scrollView.frame.size
            self.scrollView.isPagingEnabled = true
            
            let myImage:UIImage = UIImage(named: imagelist[i])!
            let myImageView:UIImageView = UIImageView()
            myImageView.image = myImage
            myImageView.contentMode = UIView.ContentMode.scaleToFill
            myImageView.frame = frame
            
            
            scrollView.addSubview(myImageView)
            
        // Do any additional setup after loading the view, typically from a nib.
    }

        self.scrollView.contentSize = CGSize(width: self.scrollView.frame.size.width * CGFloat(imagelist.count), height: self.scrollView.frame.size.height)
        // pageControl.addTarget(self, action: Selector(("changePage:")), for: UIControlEvents.valueChanged)
        // Do any additional setup after loading the view.
        configurePageControl()
        
        timer = Timer.scheduledTimer(timeInterval: 2, target: self, selector: #selector(self.updateCounting), userInfo: nil, repeats: true)
    }
    func configurePageControl() {
        // The total number of pages that are available is based on how many available colors we have.
        self.pageControl.numberOfPages = imagelist.count
        self.pageControl.currentPage = 0
        self.pageControl.tintColor = UIColor.red
        self.pageControl.pageIndicatorTintColor = UIColor.white
        self.pageControl.currentPageIndicatorTintColor = UIColor.blue
        // self.view.addSubview(pageControloutlet)
        
        self.view.bringSubviewToFront(pageControl)
        self.view.bringSubviewToFront(getStartedButton)
      //  self.view.bringSubview(toFront: detailLabel)
        //self.view.bringSubview(toFront: logoView)
        
    }
    
    @objc func updateCounting(){
        NSLog("counting..")
        if pageControl.currentPage == imagelist.count-1
        {
            timer.invalidate()
        }
        pageControl.currentPage =  pageControl.currentPage + 1
        changePage(sender:pageControl)
    }
    // MARK : TO CHANGE WHILE CLICKING ON PAGE CONTROL
    func changePage(sender: AnyObject) -> () {
        let x = CGFloat(pageControl.currentPage) * scrollView.frame.size.width
        scrollView.setContentOffset(CGPoint(x: x,y :0), animated: true)
    }
    
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        
        let pageNumber = round(scrollView.contentOffset.x / scrollView.frame.size.width)
        pageControl.currentPage = Int(pageNumber)
    }
    
    
    
}

