//
//  LoadFailHeaderView.swift
//  currency
//
//  Created by Ольга on 02.07.2018.
//  Copyright © 2018 SO. All rights reserved.
//

import UIKit

class LoadFailHeaderView: UIView {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setup()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        self.backgroundColor = UIColor.white
        
        let loadFailLabel = UILabel(frame: CGRect(x: 16, y: 0, width: self.frame.width - 16, height: self.frame.height))
        loadFailLabel.font = UIFont.systemFont(ofSize: 14)
        loadFailLabel.textColor = UIColor(named: "darkEmerald")
        loadFailLabel.textAlignment = .left
        loadFailLabel.numberOfLines = 2
        loadFailLabel.text = "Can't update currencies list.\nPlease, check your internet connection."
        
        let separatorHeight: CGFloat = 1
        let separatorView = UIView(frame: CGRect(x: 0, y: self.frame.height - separatorHeight, width: self.frame.width, height: separatorHeight))
        separatorView.backgroundColor = UIColor(named: "darkEmerald70")
        
        self.addSubview(loadFailLabel)
        self.addSubview(separatorView)
    }
}
