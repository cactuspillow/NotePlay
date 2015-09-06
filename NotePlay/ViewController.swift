//
//  ViewController.swift
//  NoteLite
//
//  Created by shikaiwen on 4/9/2015.
//  Copyright (c) 2015 shikaiwen. All rights reserved.
//

import UIKit
import CoreData
import Spring
import AVFoundation

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
  //初始化一个空数组
  var contentItems = [String]()
  var articleIDItems = [Int32]()
  var player = AVAudioPlayer()
  var addCellButton = UpdateButton()
  var newAID = Int32()
  override func viewDidLoad() {
    super.viewDidLoad()
    //指定声音文件
    player = self.loadSound("choose")
    // Do any additional setup after loading the view, typically from a nib.
    view.backgroundColor = mainColor
    var folderTableView = UITableView()
    folderTableView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight)
    folderTableView.backgroundColor = UIColor.clearColor()
    folderTableView.separatorColor = UIColor.clearColor()
    folderTableView.rowHeight = tableViewRowHeight
    folderTableView.showsVerticalScrollIndicator = false
    folderTableView.showsHorizontalScrollIndicator = false
    folderTableView.dataSource = self
    folderTableView.delegate = self
    view.addSubview(folderTableView)
    var headerView = UIView()
    headerView.frame = CGRect(x: 0, y: 0, width: screenWidth, height: 20)
    folderTableView.addSubview(headerView)
    folderTableView.tableHeaderView = headerView
    
    addCellButton.addTarget(self, action: "addNote", forControlEvents: UIControlEvents.TouchUpInside)
    view.addSubview(addCellButton)
    
    //获取管理的数据上下文 对象
    let app = UIApplication.sharedApplication().delegate as! AppDelegate
    let context = app.managedObjectContext!
    
    var error:NSError?
    
    //声明数据的请求
    var fetchRequest:NSFetchRequest = NSFetchRequest()
    //fetchRequest.fetchLimit = 20 //限定查询结果的数量
    fetchRequest.fetchOffset = 0 //查询的偏移量
    
    //声明一个实体结构
    var entity:NSEntityDescription? = NSEntityDescription.entityForName("Article",
      inManagedObjectContext: context)
    //设置数据请求的实体结构
    fetchRequest.entity = entity
    
    //设置查询条件
    let predicate = NSPredicate(format: "id= '1' ")
    fetchRequest.predicate = predicate
    
    //查询操作
    var fetchedObjects:[AnyObject]? = context.executeFetchRequest(fetchRequest, error: &error)
    
    //遍历查询的结果
    for info:Article in fetchedObjects as! [Article]{
      contentItems.append(info.content)
      articleIDItems.append(info.articleID)
    }
    if(articleIDItems.count == 0){
      newAID = 0
    }else{
      newAID = maxElement(articleIDItems)+1
    }
    
//    //遍历查询的结果
//    for info:Article in fetchedObjects as! [Article]{
//      //删除对象
//      context.deleteObject(info)
//    }
//    
//    //重新保存-更新到数据库
//    if !context.save(&error){
//      println("删除后保存：\(error?.localizedDescription)")
//    }
  }
  func addNote(){
    self.player.play()
    var noteDetail = NoteDetailViewController()
    addCellButton.animation = "pop"
    addCellButton.animate()
    noteDetail.article.text = ""
    noteDetail.updateNote.buttonIcon.image = UIImage(named: "update")
    noteDetail.actionWay = "updateYN"
    noteDetail.newArticleID = newAID
    noteDetail.article.becomeFirstResponder()
    self.navigationController!.pushViewController(noteDetail,animated:true)
  }
  func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return contentItems.count
  }
  func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cellIdentifier: String = "folderTableView"
    var cell: CustomCell? = (tableView.dequeueReusableCellWithIdentifier(cellIdentifier) as? CustomCell)
    if (cell == nil) {
      cell = CustomCell(style: UITableViewCellStyle.Default, reuseIdentifier: cellIdentifier)
    }
    var row = indexPath.row as Int
    var reser = contentItems.reverse()
    cell!.cellTitle.text = reser[row]
    cell!.selectionStyle = UITableViewCellSelectionStyle.None
    cell!.backgroundColor = UIColor.clearColor()
    return cell!
  }
  //tabelview cell 点击选择事件方法
  func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
    var reser = contentItems.reverse()
    var reserArticleID = articleIDItems.reverse()
    var noteDetail = NoteDetailViewController()
    noteDetail.article.text = reser[indexPath.row]
    noteDetail.currentArticleID = reserArticleID[indexPath.row]
    noteDetail.updateNote.buttonIcon.image = UIImage(named: "edit")
    noteDetail.actionWay = "editNote"
    self.navigationController!.pushViewController(noteDetail,animated:true)
  }
  //播放声音的方法
  func loadSound(filename:NSString) -> AVAudioPlayer {
    let url = NSBundle.mainBundle().URLForResource(filename as String, withExtension: "aiff")
    var error:NSError? = nil
    let player = AVAudioPlayer(contentsOfURL: url, error: &error)
    player.prepareToPlay()
    return player
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  
}

