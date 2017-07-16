//
//  ToolBoxNode.swift
//  
//
//  Created by Ethan on 7/15/17.
//
//

import SpriteKit

enum ToolBarNodeState {
    case ToolBarNodeStateActive, ToolBarNodeStateHidden
}

class ToolBarNode: SKSpriteNode {
    
    
    var state: ToolBarNodeState = .ToolBarNodeStateActive
    {
        didSet {
            switch state {
            case .ToolBarNodeStateActive:
                /* Enable touch */
                self.isUserInteractionEnabled = true
                /*Visible */
                self.alpha = 1
                
                break
            case .ToolBarNodeStateHidden:
                /* Disable touch */
                self.isUserInteractionEnabled = false
                
                /* Hide */
                self.alpha = 0
                break
            }
        }
    }
    
    /* Support for NSKeyedArchiver (loading objects from SK Scene Editor */
    required init?(coder aDecoder: NSCoder) {
        
        /* Call parent initializer e.g. SKSpriteNode */
        super.init(coder: aDecoder)
        
        /* Enable touch on button node */
        self.isUserInteractionEnabled = true
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        state = .ToolBarNodeStateActive
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        state = .ToolBarNodeStateActive
    }
    
    
    
}
