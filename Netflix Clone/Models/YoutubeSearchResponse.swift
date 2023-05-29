//
//  YoutubeSearchResponse.swift
//  Netflix Clone
//
//  Created by J on 5/28/23.
//

import Foundation

struct YoutubeSearchResponse: Codable {
    
    let items: [VideoElement]
    
}

struct VideoElement: Codable {
    let id: VideoElementId
}

struct VideoElementId: Codable {
    let kind: String
    let videoId: String
}


/*
 items =     (
             {
         etag = hXlwFgMNBcfQ1yaBHIKgaNCMuBk;
         id =             {
             kind = "youtube#video";
             videoId = Lx3MGrafykU;
         };
         kind = "youtube#searchResult";
     },
 */
