//
//  SafariExtensionViewController.swift
//  Password Generator Extension
//
//  Created by Alexander Novikov on 03.02.2020.
//  Copyright © 2020 novikovav. All rights reserved.
//

import SafariServices

class SafariExtensionViewController: SFSafariExtensionViewController {
    @IBOutlet weak var passwordLabel: NSPasswordTextField!
    
    let len = 6
    let pswdChars = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ1234567890"
    
    static let shared: SafariExtensionViewController = {
        let shared = SafariExtensionViewController()
        shared.preferredContentSize = NSSize(width:320, height:60)
        return shared
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewDidAppear() {
        self.passwordLabel.stringValue = self.getNewPassword()
        self.passwordLabel.selectText(nil)
    }
    
    private func getNewPasswordPart() -> String {
        return String((0..<len).compactMap{ _ in pswdChars.randomElement() })
    }
    
    private func getNewPassword() -> String {
        return "\(self.getNewPasswordPart())-\(self.getNewPasswordPart())-\(self.getNewPasswordPart())-\(self.getNewPasswordPart())"
    }
}

class NSPasswordTextField: NSTextField {
    override func performClick(_ sender: Any?) {
        super.performClick(sender)
        self.selectText(nil)
    }
    
    override func selectText(_ sender: Any?) {
        super.selectText(sender)
        let pasteBoard = NSPasteboard.general
        pasteBoard.clearContents()
        pasteBoard.setString(self.stringValue, forType: .string)
    }
}
