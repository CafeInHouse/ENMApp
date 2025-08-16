//
//  App.swift
//  ENMApp
//
//  Created by linsaeng on 8/16/25.
//

import Foundation

// 내부 Module
import HomeService
import Shared

@main
final class ENMApp {

    
    static func main() {
        
        DI.register(assemblies: [
            HomeAsmely()
        ])
        
        ENMWindowApp.main()
    }
}
