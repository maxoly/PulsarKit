//
//  UIImage.swift
//  PulsarKitExample
//
//  Created by Massimo Oliviero on 01/03/2019.
//  Copyright © 2019 Nacoon. All rights reserved.
//

import UIKit

extension UIImage {
    // move
    static let itemsMove    = UIImage(named: "grip-vertical-solid")?.withRenderingMode(.alwaysTemplate)
    static let sectionsMove = UIImage(named: "object-ungroup-solid")?.withRenderingMode(.alwaysTemplate)
    
    // insert
    static let addItems      = UIImage(named: "table-solid")?.withRenderingMode(.alwaysTemplate)
    static let addSections  = UIImage(named: "layer-group-solid")?.withRenderingMode(.alwaysTemplate)
    
    // menu
    static let insertIcon   = UIImage(named: "plus-square-regular")?.withRenderingMode(.alwaysTemplate)
    static let deleteIcon   = UIImage(named: "eraser-solid")?.withRenderingMode(.alwaysTemplate)
    static let moveIcon     = UIImage(named: "arrows-alt-solid")?.withRenderingMode(.alwaysTemplate)
    static let pluginIcon   = UIImage(named: "plug-solid")?.withRenderingMode(.alwaysTemplate)
    static let binderIcon   = UIImage(named: "puzzle-piece-solid")?.withRenderingMode(.alwaysTemplate)
    static let sizesIcon    = UIImage(named: "ruler-solid")?.withRenderingMode(.alwaysTemplate)
}
