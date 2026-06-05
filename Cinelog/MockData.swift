//
//  MockData.swift
//  Cinelog
//
//  Created by Isabella Sulisufi on 05/06/2026.
//

let watchedFilms: [FilmDetail] = [
    FilmDetail(
        id: 11,
        title: "Star Wars",
        posterPath: "/6FfCtAuVAW8XJjZ7eWeLibRLWTw.jpg",
        releaseDate: "1977-05-25",
        voteAverage: 8.2,
        voteCount: 22061,
        genreIds: [28, 12, 878],
        runtime: 121,
        genres: [Genre(id: 28, name: "Action"), Genre(id: 12, name: "Adventure")],
        overview: "A long time ago in a galaxy far, far away...",
        tagline: "May the force be with you"
    ),
    FilmDetail(
        id: 350,
        title: "The Devil Wears Prada",
        posterPath: "/8912AsVuS7Sj915apArUFbv6F9L.jpg",
        releaseDate: "2006-06-29",
        voteAverage: 7.4,
        voteCount: 13170,
        genreIds: [18, 35],
        runtime: 109,
        genres: [Genre(id: 18, name: "Drama"), Genre(id: 35, name: "Comedy")],
        overview: "A young woman gets more than she bargained for.",
        tagline: nil
    ),
    FilmDetail(
        id: 447332,
        title: "A Quiet Place",
        posterPath: "/nAU74GmpUk7t5iklEp3bufwDq4n.jpg",
        releaseDate: "2018-04-03",
        voteAverage: 7.4,
        voteCount: 15310,
        genreIds: [27, 18],
        runtime: 90,
        genres: [Genre(id: 27, name: "Horror")],
        overview: "A family is forced to live in silence while hiding from creatures that hunt by sound.",
        tagline: nil
    ),
    FilmDetail(
        id: 453,
        title: "A Beautiful Mind",
        posterPath: "/rEIg5yJdNOt9fmX4P8gU9LeNoTQ.jpg",
        releaseDate: "2001-12-14",
        voteAverage: 7.9,
        voteCount: 11058,
        genreIds: [18, 10749],
        runtime: 135,
        genres: [Genre(id: 18, name: "Drama")],
        overview: "From the heights of notoriety to the depths of depravity, John Forbes Nash Jr. experiences it all.",
        tagline: nil
    ),
    FilmDetail(
        id: 62,
        title: "2001: A Space Odyssey",
        posterPath: "/ve72VxNqjGM69Uky4WTo2bK6rfq.jpg",
        releaseDate: "1968-04-02",
        voteAverage: 8.1,
        voteCount: 12562,
        genreIds: [878, 9648, 12],
        runtime: 149,
        genres: [Genre(id: 878, name: "Science Fiction")],
        overview: "Humanity finds a mysterious object buried beneath the lunar surface.",
        tagline: "An epic drama of adventure and exploration"
    )
]
