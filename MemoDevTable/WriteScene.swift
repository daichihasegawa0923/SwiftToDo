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
    var _presentView:ViewController?
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        designDefine()
    }
    
    func designDefine(){
        _textView?.layer.borderWidth = 1
        _textView?.layer.borderColor = #colorLiteral(red: 0.2990001619, green: 0.2990001619, blue: 0.2990001619, alpha: 1)
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
