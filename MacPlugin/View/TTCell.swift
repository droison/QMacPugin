//
//  TTCell.swift
//  QDaily
//
//  Created by plusub on 4/24/16.
//  Copyright © 2016 song. All rights reserved.
//

import Cocoa

class TTCell: NSTableCellView {
    
    @IBOutlet weak var titleTextView: NSTextField!
    @IBOutlet weak var urlTextField: NSTextField!
    @IBOutlet weak var voteTextField: NSTextField!
    @IBOutlet weak var commentTextField: NSTextField!

    override func awakeFromNib() {
        super.awakeFromNib()
        
        wantsLayer = true
        layer?.backgroundColor = NSColor.whiteColor().CGColor
    }
    
    
    func configureData(model: TTModel) {
        self.titleTextView.stringValue = model.title
        self.urlTextField.stringValue = model.url
        self.voteTextField.stringValue = String(model.like)
        self.commentTextField.stringValue = String(model.comment)
    }

    override func drawRect(dirtyRect: NSRect) {
        super.drawRect(dirtyRect)

    }
    
}
