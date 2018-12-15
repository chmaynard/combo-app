//
//  ComboViewCell.swift
//  Combo
//
//  Created by Craig H Maynard on 28 November 2017.
//  Copyright ©️ Craig H Maynard. All rights reserved.
//

import UIKit

@objcMembers class _ComboViewCell: UICollectionViewCell, ComboCardProtocol {

    var isAnimating = false
    var rank : Int?
    var color, shading, shape : String?
    var fillColor : UIColor?

    // MARK: - Initialization

    required init(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override init(frame: CGRect) {
        super.init(frame: frame)
        backgroundColor = .clear
        contentMode = .redraw
        fillColor = UIColor.white
        isOpaque = false
   }

    // MARK: - Drawing

}
