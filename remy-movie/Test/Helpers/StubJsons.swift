//
//  StubJsons.swift
//  remy-movie
//
//  Copyright (c) 2023 Jeremy All rights reserved.


import Foundation

enum MovieServiceStubJsons {
    static let movieList = """
    {
      "page": 1,
      "results": [
        {
          "poster_path": "/e1mjopzAS2KNsvpbpahQ1a6SkSn.jpg",
          "adult": false,
          "overview": "From DC Comics comes the Suicide Squad, an antihero team of incarcerated supervillains who act as deniable assets for the United States government, undertaking high-risk black ops missions in exchange for commuted prison sentences.",
          "release_date": "2016-08-03",
          "genre_ids": [
            14,
            28,
            80
          ],
          "id": 297761,
          "original_title": "Suicide Squad",
          "original_language": "en",
          "title": "Suicide Squad",
          "backdrop_path": "/ndlQ2Cuc3cjTL7lTynw6I4boP4S.jpg",
          "popularity": 48.261451,
          "vote_count": 1466,
          "video": false,
          "vote_average": 5.91
        }
    ]
}
""".data(using: .utf8)
    
    static let reviewList = #"""
{
    "id": 11,
    "page": 1,
    "results": [{
        "author": "Cat Ellington",
        "author_details": {
            "name": "Cat Ellington",
            "username": "CatEllington",
            "avatar_path": "/uCmwgSbJAcHqNwSvQvTv2dB95tx.jpg",
            "rating": null
        },
        "content": "(As I'm writing this review, Darth Vader's theme music begins to build in my mind...)\r\n\r\nWell, it actually has a title, what the Darth Vader theme. And that title is \"The Imperial March\", composed by the great John Williams, whom, as many of you may already know, also composed the theme music for \"Jaws\" - that legendary score simply titled, \"Main Title (Theme From Jaws)\".\r\n\r\nNow, with that lil' bit of trivia aside, let us procede with the fabled film ",
        "created_at": "2017-02-13T22:23:01.268Z",
        "id": "58a231c5925141179e000674",
        "updated_at": "2017-02-13T23:16:19.538Z",
        "url": "https://www.themoviedb.org/review/58a231c5925141179e000674"
    }],
    "total_results": 19629,
    "total_pages": 982
}
"""#.data(using: .utf8)
}
