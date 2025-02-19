//
//  RenderContainerView.swift
//  Philter
//
//  Created by Philip Price on 9/17/16.
//  Copyright © 2016 Nateemma. All rights reserved.
//
import UIKit
import Neon
import GPUImage


// View that contains a RenderView with a label underneath. Intended for use in galleries etc.

class RenderContainerView: UIView {
    var renderView : RenderView? = RenderView()
    let label : UILabel = UILabel()
    
    let defaultWidth:CGFloat = 64.0
    //let defaultHeight:CGFloat = 64.0 * 4.0 / 3.0
    let defaultHeight:CGFloat = 64.0
    

    
    convenience init(){
        self.init(frame: CGRect.zero)
        
        self.backgroundColor = UIColor.black
        self.layer.cornerRadius = 2.0
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor(white: 0.68, alpha: 1.0).cgColor
        self.clipsToBounds = true
        
        renderView?.contentMode = .scaleAspectFill
        renderView?.clipsToBounds = true
        renderView?.frame.size = CGSize(width:defaultWidth, height:defaultHeight)
        self.addSubview(renderView!)
        
        label.textAlignment = .center
        label.textColor = UIColor.white
        label.backgroundColor = UIColor.flatMint.withAlphaComponent(0.6)
        label.font = UIFont.boldSystemFont(ofSize: 12.0)
        self.addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        renderView?.anchorAndFillEdge(.top, xPad: 0, yPad: 2, otherSize: self.height * 0.8)
        label.alignAndFill(.underCentered, relativeTo: renderView!, padding: 0)
    }
    

}

