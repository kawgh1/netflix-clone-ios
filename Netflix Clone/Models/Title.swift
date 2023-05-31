//
//  Movie.swift
//  Netflix Clone
//
//  Created by J on 5/21/23.
//

import Foundation

struct TitleResponse: Codable {
    
    let results: [Title]
}

struct Title: Codable {
    let id: Int
    let media_type: String?
    let original_name: String?
    let original_title: String?
    let poster_path: String?
    let overview: String?
    let vote_count: Int
    let release_date: String?
    let vote_average: Double
}

    /*
     {
 adult = 0;
 "backdrop_path" = "/pbMbDlOAkVuvnxovBA2ENin59xH.jpg";
 "genre_ids" =             (
     12,
     10751,
     14,
     10749
 );
 id = 447277;
 "media_type" = movie;
 "original_language" = en;
 "original_title" = "The Little Mermaid";
 overview = "The youngest of King Triton\U2019s daughters, and the most defiant, Ariel longs to find out more about the world beyond the sea, and while visiting the surface, falls for the dashing Prince Eric. With mermaids forbidden to interact with humans, Ariel makes a deal with the evil sea witch, Ursula, which gives her a chance to experience life on land, but ultimately places her life \U2013 and her father\U2019s crown \U2013 in jeopardy.";
 popularity = "594.907";
 "poster_path" = "/ym1dxyOk4jFcSl4Q2zmRrA5BEEN.jpg";
 "release_date" = "2023-05-18";
 title = "The Little Mermaid";
 video = 0;
 "vote_average" = "6.274";
 "vote_count" = 31;
}
     */

