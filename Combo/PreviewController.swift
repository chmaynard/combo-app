//
//  PreviewController.swift
//  Combo
//
//  Created by Craig H Maynard on 23 November 2017.
//  Copyright © 2017 Craig H Maynard. All rights reserved.
//

import UIKit
import QuickLook

@objc public class PreviewController: QLPreviewController, QLPreviewControllerDataSource, QLPreviewControllerDelegate {

    override public func viewDidLoad() {
        super.viewDidLoad()
        dataSource = self
        delegate = self
   }

    override public func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    public func numberOfPreviewItems(in controller: QLPreviewController) -> Int {
        return 1
    }

    public func previewController(_ controller: QLPreviewController, previewItemAt index: Int) -> QLPreviewItem {
        let path = Bundle.main.path(forResource:"about-combo", ofType: "pdf")
        let item = PreviewItem()
        item.previewItemURL = NSURL.fileURL(withPath:path!)
        item.previewItemTitle = "About Combo"
        return item
    }
}
