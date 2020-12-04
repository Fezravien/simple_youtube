//
//  ViewController.swift
//  simple_youtube
//
//  Created by 윤재웅 on 2020/12/04.
//

import UIKit

class ViewController: UIViewController {
    
    // Model 객체 생성
    var model = Model()
    

    override func viewDidLoad() {
        super.viewDidLoad()
       
        model.getVideos()
    }


}

