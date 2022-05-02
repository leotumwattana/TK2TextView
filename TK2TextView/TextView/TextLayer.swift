//
//  TextLayer.swift
//  TK2TextView
//
//  Created by Leo Tumwattana on 23/4/2022.
//

import UIKit

class TextLayer: CALayer {
    override class func defaultAction(forKey event: String) -> CAAction? {
        // Suppress default animation of opacity when adding comment bubbles.
        return NSNull()
    }
}
