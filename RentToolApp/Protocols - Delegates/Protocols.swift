//
//  Protocols.swift
//  RentToolApp
//
//  Created by Huseyin Jafarli on 06.08.25.
//

import Foundation

protocol ToolSelectionDelegate: AnyObject {
    func didOrderTool(_ tool: Tool)
}

protocol AddToFavoritesDelegate: AnyObject {
    func didAddToolToFavorites(_ tool: Tool)
}
