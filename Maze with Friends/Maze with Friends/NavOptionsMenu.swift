//
//  NavOptionsMenu.swift
//  Maze with Friends
//
//  Created by Ethan on 8/7/17.
//  Copyright © 2017 Ethan. All rights reserved.
//

import SpriteKit
import Firebase
import FirebaseAuthUI
import FirebaseAuth

class NavOptionsMenu: SKNode {
    
    var navOptionsBackground: ToolBarNode!
    var ThirdButton: MSButtonNode!
    var logoutButton: MSButtonNode!
    var returnButton: MSButtonNode!

    
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    
    func addChildren() {
        navOptionsBackground = self.childNode(withName: "//navOptionsBackground") as! ToolBarNode
        ThirdButton = self.childNode(withName: "//ThirdButton") as! MSButtonNode
        logoutButton = self.childNode(withName: "//logoutButton") as! MSButtonNode
        returnButton = self.childNode(withName: "//returnButton") as! MSButtonNode
        
        returnButton.selectedHandler = {  [unowned self] in
            self.alpha = 0
        }
        
        logoutButton.selectedHandler = { [unowned self] in
            do {
                try Auth.auth().signOut()
            } catch let error as NSError {
                assertionFailure("Error signing out: \(error.localizedDescription)")
            }
            }
        }

        
}
    
    

