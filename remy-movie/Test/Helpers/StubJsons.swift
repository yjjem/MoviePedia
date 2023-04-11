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
    
    static let videoList  = """
{
  "id": 550,
  "results": [
    {
      "iso_639_1": "en",
      "iso_3166_1": "US",
      "name": "Fight Club - Theatrical Trailer Remastered in HD",
      "key": "6JnN1DmbqoU",
      "site": "YouTube",
      "size": 1080,
      "type": "Trailer",
      "official": false,
      "published_at": "2015-02-26T03:19:25.000Z",
      "id": "5e382d1b4ca676001453826d"
    },
    {
      "iso_639_1": "en",
      "iso_3166_1": "US",
      "name": "Fight Club | #TBT Trailer | 20th Century FOX",
      "key": "BdJKm16Co6M",
      "site": "YouTube",
      "size": 1080,
      "type": "Trailer",
      "official": true,
      "published_at": "2014-10-02T19:20:22.000Z",
      "id": "5c9294240e0a267cd516835f"
    }
  ]
}
""".data(using: .utf8)
    
    static let providersInfo = """
{
    "id": 550,
    "results": {
        "KR": {
            "link": "https://www.themoviedb.org/movie/550-fight-club/watch?locale=KR",
            "buy": [{
                    "display_priority": 2,
                    "logo_path": "/8N0DNa4BO3lH24KWv1EjJh4TxoD.jpg",
                    "provider_id": 356,
                    "provider_name": "wavve"
                },
                {
                    "display_priority": 3,
                    "logo_path": "/p3Z12gKq2qvJaUOMeKNU2mzKVI9.jpg",
                    "provider_id": 3,
                    "provider_name": "Google Play Movies"
                }
            ],
            "rent": [{
                    "display_priority": 2,
                    "logo_path": "/8N0DNa4BO3lH24KWv1EjJh4TxoD.jpg",
                    "provider_id": 356,
                    "provider_name": "wavve"
                },
                {
                    "display_priority": 3,
                    "logo_path": "/p3Z12gKq2qvJaUOMeKNU2mzKVI9.jpg",
                    "provider_id": 3,
                    "provider_name": "Google Play Movies"
                }
            ],
            "flatrate": [{
                "display_priority": 1,
                "logo_path": "/68MNrwlkpF7WnmNPXLah69CR5cb.jpg",
                "provider_id": 119,
                "provider_name": "Amazon Prime Video"
            }]
        }
    }
}
""".data(using: .utf8)
}
