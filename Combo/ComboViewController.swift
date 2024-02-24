//
//  ComboViewController.swift
//  Combo
//
//  Created by Craig H Maynard on 23 November 2017.
//  Copyright (c) 2017 Craig H Maynard. All rights reserved.
//

import UIKit
import QuickLook

class ComboViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func aboutCombo(sender: AnyObject) {
        let preview = PreviewController()
        self.presentViewController(preview, animated: true, completion: nil)
    }

}

/*

 let button:UIButton = UIButton(frame: CGRect(x: 100, y: 400, width: 100, height: 50))
 button.backgroundColor = .black
 button.setTitle("Button", for: .normal)
 button.addTarget(self, action:#selector(self.buttonClicked), for: .touchUpInside)
 self.view.addSubview(button)

 @objc func buttonClicked() {
 print("Button Clicked")
 }

 */
