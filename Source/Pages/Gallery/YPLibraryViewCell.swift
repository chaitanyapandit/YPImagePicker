//
//  YPLibraryViewCell.swift
//  YPImgePicker
//
//  Created by Sacha Durand Saint Omer on 2015/11/14.
//  Copyright © 2015 Yummypets. All rights reserved.
//

import UIKit
import Stevia

class YPMultipleSelectionIndicator: UIView {
    
    let circle = UIView()
    let label = UILabel()
    let checkmarkImageView = UIImageView()
    var selectionColor = UIColor.ypSystemBlue

    convenience init() {
        self.init(frame: .zero)
        
        let size: CGFloat = 20
        subviews(
            circle,
            checkmarkImageView,
            label
        )
        
        circle.fillContainer()
        circle.size(size)
        label.fillContainer()
        checkmarkImageView.centerInContainer().size(50%)

        circle.backgroundColor = UIColor.ypSystemBlue
        circle.layer.cornerRadius = size / 2.0
        
        checkmarkImageView.tintColor = UIColor.white
        
        label.textAlignment = .center
        label.textColor = .white
        label.font = YPConfig.fonts.multipleSelectionIndicatorFont
        
        set(number: nil)
    }
    
    func set(number: Int?) {
        label.isHidden = (number == nil)
        label.text = nil
        if number != nil {
            circle.backgroundColor = selectionColor
            circle.layer.borderColor = UIColor.clear.cgColor
            circle.layer.borderWidth = 0
            if #available(iOS 13.0, *) {
                checkmarkImageView.image = UIImage(systemName: "checkmark")
            } else {
                checkmarkImageView.image = UIImage(named: "checkmark")
            }
        } else {
            circle.backgroundColor = UIColor.white.withAlphaComponent(0.3)
            circle.layer.borderColor = UIColor.white.cgColor
            circle.layer.borderWidth = 1
            checkmarkImageView.image = nil
        }
    }
}

class YPLibraryViewCell: UICollectionViewCell {
    
    var representedAssetIdentifier: String!
    let imageView = UIImageView()
    let durationLabel = UILabel()
    let selectionOverlay = UIView()
    let multipleSelectionIndicator = YPMultipleSelectionIndicator()
    
    required init?(coder aDecoder: NSCoder) { fatalError("init(coder:) has not been implemented") }
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        subviews(
            imageView,
            durationLabel,
            selectionOverlay,
            multipleSelectionIndicator
        )

        imageView.fillContainer()
        selectionOverlay.fillContainer()
        layout(
            durationLabel-5-|,
            5
        )
        
        layout(
            3,
            multipleSelectionIndicator-3-|
        )
        
        imageView.contentMode = .scaleAspectFill
        imageView.clipsToBounds = true
        durationLabel.textColor = .white
        durationLabel.font = YPConfig.fonts.durationFont
        durationLabel.isHidden = true
        selectionOverlay.backgroundColor = .white
        selectionOverlay.alpha = 0
        backgroundColor = .ypSecondarySystemBackground
//        setAccessibilityInfo()
    }

    var showSelected: Bool = false {
        didSet { refreshSelection() }
    }
    
    override var isHighlighted: Bool {
        didSet { refreshSelection() }
    }
    
    private func refreshSelection() {
        let showOverlay = showSelected || isHighlighted
        selectionOverlay.alpha = showOverlay ? 0.6 : 0
    }
}

//extension YPLibraryViewCell: Accessibility {
//    func setAccessibilityInfo() {
//        isAccessibilityElement = true
//        self.accessibilityIdentifier = "YPLibraryViewCell"
//        self.accessibilityLabel = "Library Image"
//    }
//}
