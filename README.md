# MovieFan

IOS App written using Swift 5.0 with VIPER architecture. 

### Prerequisites

Xcode 10.5
Swift 5.0
[The Movie Database API](https://developers.themoviedb.org/3/getting-started/introduction)

## Implemented UserStories

### Required:

#### FF-1
As a customer, I want to be able to view a list of movies that are now playing
`ACCEPTANCE CRITERIA`

- The list should include the title of the movie, the release date, the vote average and the movie poster
- The list should show only the first page of results q The list should be sorted alphabetically

#### FF-2
As a customer, I want to be able to select a movie and view more details
`ACCEPTANCE CRITERIA`

- The movie detail page should include the movie title, the year of release, an overview of the movie, the genre, the rating and the movie poster
- The movie detail page should show the list of the actors and their characters in the movie

#### FF-3
As a customer I want to be able to vote for a movie
`ACCEPTANCE CRITERIA`
- On the detailed movie page, there should be a set of stars that the user can use to rate the movie
- The rating should be posting back to the API

NOTE: Currently TMDB API doesn't allow for posting users rating as of Authentication privilege for the current API user.

### Optional:

#### FF-5
As a customer I want to be able to add a movie to ‘My Favourites’

`ACCEPTANCE CRITERIA`
- Each movie in the list and details page should have a button for adding to favourites
- The list of currently added favourites should be displayed in a list either on a page or on a dropdown

## Features

* Now Playing movies List
* Search Now Playing movies
* Show movie details
* Favourite movie.

## More features to be added

* Recommended Movies
