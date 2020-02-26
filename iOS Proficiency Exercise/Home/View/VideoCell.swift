//
//  VideoCell.swift
//  iOS Proficiency Exercise
//
//  Created by Nanda iMac on 25/02/20.
//  Copyright © 2020 Nanda. All rights reserved.
//

import UIKit

class VideoCell: UITableViewCell {
    
    var titleLabelHeightConstraint: NSLayoutConstraint?
    var descriptionLabelHeightConstraint: NSLayoutConstraint?
    var thumbnailImageViewHeightContraint: NSLayoutConstraint?
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    
    var video: Row? {
        
        didSet{
            
            setupThumbnailImage()
            titleLabel.text = video?.title
            if let description = video?.description {
                
                descriptionTitleLbl.text = description
                
                let size = CGSize(width: frame.width, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: description).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 14.0)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = estimatedRect.size.height
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
            }
            
            if let title = video?.title {
                let size = CGSize(width: frame.width, height: 1000)
                let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
                let estimatedRect = NSString(string: title).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.boldSystemFont(ofSize: 20.0)], context: nil)
                
                if estimatedRect.size.height > 20 {
                    titleLabelHeightConstraint?.constant = estimatedRect.size.height
                } else {
                    titleLabelHeightConstraint?.constant = 20
                }
                
            }
        }
        
    }
    
    func setupThumbnailImage() {
        
        if let thumbnailImageUrl = video?.imageHref {
            thumbnailImageView.loadImageUsingUrl(urlString: thumbnailImageUrl)
        }else{
            thumbnailImageView.image = UIImage(named: "placeholder")
        }
        
    }
    
    
    let titleLabel: UILabel = {
        let label = UILabel()
        label.text = ""
        label.numberOfLines = 0
        label.font = UIFont.boldSystemFont(ofSize: 20.0)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let thumbnailImageView: CustomImageView = {
        let imageView = CustomImageView()
        imageView.contentMode = .scaleToFill
        imageView.clipsToBounds = true
        return imageView
    }()
    
    let descriptionTitleLbl: UILabel = {
        let subLbl = UILabel()
        subLbl.text = ""
        subLbl.numberOfLines = 0
        subLbl.textColor = .lightGray
        subLbl.font = UIFont.systemFont(ofSize: 14.0)
        subLbl.translatesAutoresizingMaskIntoConstraints = false
        return subLbl
    }()
    
    
    
    func setupViews() {
        
        let marginGuide = contentView.layoutMarginsGuide
        
        // configure thumbnailImageView
        contentView.addSubview(thumbnailImageView)
        thumbnailImageView.translatesAutoresizingMaskIntoConstraints                                             = false
        thumbnailImageView.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive                 = true
        thumbnailImageView.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor, constant: 10).isActive = true
        thumbnailImageView.topAnchor.constraint(equalTo: marginGuide.topAnchor).isActive                         = true
        thumbnailImageView.heightAnchor.constraint(equalToConstant: 200).isActive                                = true
        
        // configure titleLabel
        contentView.addSubview(titleLabel)
        titleLabel.translatesAutoresizingMaskIntoConstraints                                                     = false
        titleLabel.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive                         = true
        titleLabel.topAnchor.constraint(equalTo: thumbnailImageView.bottomAnchor, constant: 10).isActive         = true
        titleLabel.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive                       = true
        
        
        // configure descriptionTitleLbl
        contentView.addSubview(descriptionTitleLbl)
        descriptionTitleLbl.translatesAutoresizingMaskIntoConstraints                                            = false
        descriptionTitleLbl.leadingAnchor.constraint(equalTo: marginGuide.leadingAnchor).isActive                = true
        descriptionTitleLbl.bottomAnchor.constraint(equalTo: marginGuide.bottomAnchor).isActive                  = true
        descriptionTitleLbl.trailingAnchor.constraint(equalTo: marginGuide.trailingAnchor).isActive              = true
        descriptionTitleLbl.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: 5).isActive         = true
        
    }
    
}
