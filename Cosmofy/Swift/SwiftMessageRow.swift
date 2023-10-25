//
//  SwiftMessageRow.swift
//  Cosmofy
//
//  Created by Arryan Bhatnagar on 10/24/23.
//

import Foundation
import SwiftUI

struct SwiftMessageRow: Identifiable {
    
    let id = UUID()
    var isInteractingWithChatGPT: Bool
    
    let sendImage: String
    let sendText: String
    
    let responseImage: String
    var responseText: String?
    
    var responseError: String?
    
}
