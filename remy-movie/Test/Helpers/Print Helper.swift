//
//  Print Helper.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.
    

import Foundation

func printErrorWithDetailsOfFunction(name: String, error: Error) {
    print("""
    --------------------------
    
    [ EXPECTED ERROR of ] : \(name)
    
    [ Reason ] : \(error.localizedDescription)
    
    [ Error ] : \(error)
    
    --------------------------
    """)
}
