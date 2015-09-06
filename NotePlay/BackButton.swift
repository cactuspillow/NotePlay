import UIKit
import Spring

class BackButton:SpringButton{
  var buttonIcon = UIImageView()
  override init(frame:CGRect){
    var buttonMarginTop = screenHeight - mainButtonSize - marginSize1_5
    var buttonMarginLeft = marginSize1_5
    var frame = CGRect(x: buttonMarginLeft, y: buttonMarginTop, width: mainButtonSize, height: mainButtonSize)
    super.init(frame:frame)
    self.backgroundColor = mainPink
    self.layer.cornerRadius = mainButtonSize/2
    self.layer.shadowColor = UIColor.blackColor().CGColor
    self.layer.shadowRadius = 3
    self.layer.shadowOffset = CGSize(width: 0, height: 1)
    self.layer.shadowOpacity = 0.35
    buttonIcon = UIImageView(frame: CGRect(x: 0, y: 0, width: mainButtonSize, height: mainButtonSize))
    buttonIcon.image = UIImage(named: "back")
    self.addSubview(buttonIcon)
  }
  required init(coder aDecoder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }
}