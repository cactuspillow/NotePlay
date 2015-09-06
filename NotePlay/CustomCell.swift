//
//  CustomCell.swift
//  NoteLite
//
//  Created by shikaiwen on 5/9/2015.
//  Copyright (c) 2015 shikaiwen. All rights reserved.
//

import UIKit

class CustomCell:UITableViewCell{
  var cellTitle = UILabel()
  override init(style:UITableViewCellStyle,reuseIdentifier:String?){
    super.init(style:style,reuseIdentifier:reuseIdentifier)
    
      cellTitle = UILabel(frame: CGRect(x: marginSize2, y: 0, width: screenWidth*0.75, height: tableViewRowHeight))
      cellTitle.numberOfLines = 3
      cellTitle.font = songtiFont
      cellTitle.textColor = defaultFontColor
      cellTitle.backgroundColor = UIColor.clearColor()
//      cellTitle.text = "I am where i have to be, the past is like the atlantic ocean"
      self.addSubview(cellTitle)
    var itemsCount = UIButton()
      var itemsCountMarginLeft = screenWidth - itemsBgSize - marginSize1_5
      var itemsCountMarginTop = (tableViewRowHeight - itemsBgSize)/2
      itemsCount.frame = CGRect(x: itemsCountMarginLeft, y: itemsCountMarginTop, width: itemsBgSize, height: itemsBgSize)
      itemsCount.backgroundColor = darkBg
      itemsCount.layer.cornerRadius = itemsBgSize/2
      itemsCount.setTitle("", forState: UIControlState.Normal)
      itemsCount.titleLabel!.font = numFont
      itemsCount.setTitleColor(defaultFontColor, forState: UIControlState.Normal)
      self.addSubview(itemsCount)
  }
  
  required init(coder aDecoder: NSCoder) {
      fatalError("init(coder:) has not been implemented")
  }
}
