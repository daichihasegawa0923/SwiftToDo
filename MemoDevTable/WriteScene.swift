//
//  WriteScene.swift
//  MemoDevTable
//
//  Created by Daichi Hasegawa on 2019/07/03.
//  Copyright © 2019 Daichi Hasegawa. All rights reserved.
//

import Foundation
import UIKit

class WriteScene:UIViewController{
    
    @IBOutlet weak var _textView:UITextView?
    @IBOutlet weak var _addButton:UIButton?
    var _presentView:ViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designDefine()
    }
    
    func designDefine(){
        
        _addButton?.setTitleColor(#colorLiteral(red: 1, green: 1, blue: 1, alpha: 1), for: UIControl.State.normal)
        _addButton?.backgroundColor = #colorLiteral(red: 0.1764705926, green: 0.4980392158, blue: 0.7568627596, alpha: 1)
        _addButton?.layer.cornerRadius = (_addButton?.bounds.width)!/4
        
        _textView?.layer.borderWidth = 1
        _textView?.layer.borderColor = #colorLiteral(red: 0.7937036042, green: 0.9859999912, blue: 1, alpha: 1)
        _textView?.backgroundColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
    }
    
    public func setPresentView(presentView:ViewController){
        self._presentView? = presentView
    }
    
    @IBAction func Add(){
        if(_textView?.text != "")
        {
            let todo = Todo.init(content: _textView!.text, date: Date())
            _presentView?.addData(todo: todo)
        }
        self.Cancel()
    }
    
    @IBAction func Cancel(){
        self.dismiss(animated: true, completion: nil)
    }
}
