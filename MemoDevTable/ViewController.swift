//
//  ViewController.swift
//  MemoDevTable
//
//  Created by Daichi Hasegawa on 2019/06/23.
//  Copyright © 2019 Daichi Hasegawa. All rights reserved.
//

import UIKit

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    
    // UI
    @IBOutlet weak var _textView : UITextView?
    @IBOutlet weak var _button : UIButton?
    @IBOutlet weak var _tableView : UITableView?
    @IBOutlet weak var _editButton:UIButton?
    
    var _todo:Todo? = Todo.init(content: "a", date: Date())
    var _data :[Todo]? = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self._tableView?.dataSource = (self as UITableViewDataSource)
        designDefine()
        // Do any additional setup after loading the view.
    }
    
    func designDefine(){
        // 入力するところのデザイン
        _textView?.layer.borderColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
        _textView?.layer.borderWidth = 0.3
        _textView?.layer.cornerRadius = 12
        
        // ボタンのデザイン
        _button?.backgroundColor = #colorLiteral(red: 0.3970779445, green: 0.9150340026, blue: 0.8999217573, alpha: 1)
        _button?.layer.cornerRadius = 12
        _button?.setTitleColor(#colorLiteral(red: 1.0, green: 1.0, blue: 1.0, alpha: 1.0), for: UIControl.State.normal)
        
        // テーブルビューのデザイン
        _tableView?.separatorStyle = .none
        _tableView?.rowHeight = 100
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
        cell.textLabel?.text = _data![indexPath.row].content
        cell.backgroundColor = #colorLiteral(red: 0.978754053, green: 1, blue: 0.7671488737, alpha: 1)
        let date = UILabel(frame: CGRect(x: 0, y: 0, width: 200, height: cell.bounds.height))
        cell.layer.borderWidth = 0.5
        cell.layer.borderColor = #colorLiteral(red: 0.9607843161, green: 0.7058823705, blue: 0.200000003, alpha: 1)
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        date.text = formatter.string(from:  _data![indexPath.row].date!)
        cell.addSubview(date)
        return cell
    }
    
    @IBAction func pushButton(){
        
        let todo = Todo.init(content: _textView!.text, date: Date())
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
