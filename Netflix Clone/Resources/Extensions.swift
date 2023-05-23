//
//  Extensions.swift
//  Netflix Clone
//
//  Created by J on 5/22/23.
//

import Foundation

extension String {
    // This is to programmaticaly capitalize "TV" in "Trending TV" so it doesnt read "Trending Tv"
    func capitalizeAbbreviations(str: String) -> String {
        if (str.count == 0) {return ""}
        
        let words = str.components(separatedBy: " ")
        var newWords: [String] = []
        
        for var word in words {
            if word.count <= 2 {
                word = word.uppercased()
            } else {
                word = word.capitalized
            }
            newWords.append(word)
        }
        return newWords.joined(separator: " ")
    }
}
