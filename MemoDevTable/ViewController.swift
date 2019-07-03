//
//  ViewController.swift
//  MemoDevTable
//
//  Created by Daichi Hasegawa on 2019/06/23.
//  Copyright © 2019 Daichi Hasegawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    @IBOutlet weak var _button : UIButton?
    @IBOutlet weak var _tableView : UITableView?
    @IBOutlet weak var _editButton:UIButton?
    
    let folderPath:String =  NSHomeDirectory()+"/Documents/devmemo/"
    let fileName:String = "todo.csv"
    
    var _todo:Todo? = Todo.init(content: "a", date: Date())
    var _data :[Todo]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.loadTodo()
        self._tableView?.dataSource = (self as UITableViewDataSource)
        self.designDefine()
        //self.makeCsv()
        // Do any additional setup after loading the view.
    }
    
    public func tableView(_ tableView: UITableView, estimatedHeightForRowAt indexPath: IndexPath) -> CGFloat {
        return UITableView.automaticDimension
    }
    
    func designDefine(){
        // ボタンのデザイン
        _button?.backgroundColor = #colorLiteral(red: 0.3970779445, green: 0.9150340026, blue: 0.8999217573, alpha: 1)
        _button?.layer.masksToBounds = true
        _button?.layer.cornerRadius = (_button?.bounds.height)!/2
        _button?.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: UIControl.State.normal)
        
        // テーブルビューのデザイン
        _tableView?.separatorStyle = .none
        _tableView?.estimatedRowHeight = 100;
    }
    
    // tableviewで必要なメソッド①
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _data!.count
        //return _data!.count
    }
    // tableviewで必要なメソッド②
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCell.CellStyle.default, reuseIdentifier: "cell")
        cell.textLabel?.frame.origin.y = 20
        
        //行数を合わせる
        let textArray = _data![indexPath.row].content?.split(separator: "\n")
        cell.textLabel?.numberOfLines = textArray!.count + 2
        
        cell.textLabel?.text = "\n\n" + _data![indexPath.row].content!
        cell.backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 0)
        cell.textLabel?.textColor = #colorLiteral(red: 0.2990001619, green: 0.2990001619, blue: 0.2990001619, alpha: 1)
        let date = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: cell.bounds.height))
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = #colorLiteral(red: 0.9764705896, green: 0.850980401, blue: 0.5490196347, alpha: 1)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        date.text = formatter.string(from:  _data![indexPath.row].date!)
        date.textColor = #colorLiteral(red: 0.06274510175, green: 0, blue: 0.1921568662, alpha: 1)
        cell.addSubview(date)
        return cell
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        _data?.remove(at: indexPath.row)
        self._tableView?.reloadData()
    }
    
    @IBAction func pushWriteButton(){
        self.performSegue(withIdentifier: "to_write", sender: nil);
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "to_write" {
            let nextVC = segue.destination as! WriteScene
            nextVC._presentView = self
        }
    }
    
    public func addData(todo: Todo){
        // tableのデータに追加
        _data?.insert(todo, at: 0)
        //tableの編集を開始
        _tableView?.beginUpdates()
        
        // tableに行を追加
        _tableView?.insertRows(at: [IndexPath(row: 0, section: 0)],
                               with: .automatic)
        self._tableView?.reloadData()
        // tableの編集を完了
        _tableView?.endUpdates();
        self.saveTodo()
    }
    
    @IBAction func pushEditButton(){
        if(_tableView!.isEditing){
            _tableView?.setEditing(false, animated: true)
            _editButton?.setTitle("Edit", for: UIControl.State.normal)
            print("Edit実行ずみ")
        }else{
            _tableView?.setEditing(true, animated: true)
            _editButton?.setTitle("Done", for: UIControl.State.normal)
        }
    }
    
    func loadTodo(){
        do{
            let loadPath = self.folderPath + self.fileName
            if let csvData:String = try String(contentsOfFile:loadPath, encoding: String.Encoding.utf8){
                csvData.enumerateLines(invoking: {(line,stop) -> () in
                    let canmaArray = line.components(separatedBy: ",")
                    
                    let dataFormatter:DateFormatter = DateFormatter()
                    dataFormatter.calendar = Calendar(identifier: Calendar.Identifier.gregorian)
                    dataFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                    
                    let nDate:Date = dataFormatter.date(from: canmaArray[1])!
                    
                    let nTodo = Todo.init(content: canmaArray[0], date: nDate)
                    self._data?.append(nTodo)
                    
                })
            }
        }catch{
            print("csvファイルを読み込めませんでした。")
        }
    }
    
    func saveTodo(){
        do{
            let fileManager = FileManager.default
            try fileManager.createDirectory(atPath: folderPath, withIntermediateDirectories: true, attributes: nil)
            var dataset:String = ""
            for i in 0 ..< _data!.count{
                let formatter = DateFormatter()
                formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
                dataset += _data![i].content! + "," + formatter.string(from:  _data![i].date!) + "\n"
            }
            try dataset.write(toFile: folderPath+fileName, atomically: true, encoding: String.Encoding.utf8)
        }catch _ as NSError{
            print("保存できませんでした。")
        }
    }
    
    func makeCsv(){
        let filePath = NSHomeDirectory()+"/Documents/devmemo/"
        let fileName = "todo.csv"
        
        print(filePath)
        let str:String = "あ"
        do{
            let fileManager = FileManager.default
            try fileManager.createDirectory(atPath: filePath, withIntermediateDirectories: true, attributes: nil)
            try str.write(toFile: filePath + fileName, atomically: true, encoding: String.Encoding.utf8)
        }catch _ as NSError{
            print("エラー発生")
        }
    }
}

public class Todo{
    public var content:String?
    public var date:Date?
    init(content:String,date:Date){
        self.content = content
        self.date = date
    }
}
