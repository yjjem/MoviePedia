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
}
