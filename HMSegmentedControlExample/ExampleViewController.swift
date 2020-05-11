//
//  ExampleViewController.swift
//  HMSegmentedControlExample
//
//  Created by Hesham Abd-Elmegid on 5/11/20.
//  Copyright © 2020 HeshamMegid. All rights reserved.
//

import UIKit

class ExampleViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = .white
        let viewWidth = view.frame.size.width
        
        let segmentedControl = HMSegmentedControl(sectionTitles: [
            "Trending",
            "News",
            "Library"
        ])
        
        segmentedControl.frame = CGRect(x: 0, y: 80, width: viewWidth, height: 40)
        segmentedControl.autoresizingMask = [.flexibleRightMargin, .flexibleWidth]
        segmentedControl.addTarget(self, action: #selector(segmentedControlChangedValue(segmentedControl:)), for: .valueChanged)
        view.addSubview(segmentedControl)
        
        // For more examples, see `ViewController.m`
    }
    
    @objc func segmentedControlChangedValue(segmentedControl: HMSegmentedControl) {
        print("Selected index \(segmentedControl.selectedSegmentIndex)")
    }
}
