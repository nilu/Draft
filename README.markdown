# Draft

Hello! Here is my rendition of the project you guys sent me. I put the response of the CBS APIs under /app/assets/javascripts in 3 separate files (one for each sport).

## Setup

Prereqs:

1. A github account.
1. Latest versions of ruby and rails if you don't have it. (recommend using rvm)
1. Setup mysql (recommend using homebrew)

Setup:

1. clone repo `git@github.com:nilu/draft.git`
1. cd to repo in the terminal of your choice
1. run `bundle install` 
1. run `rake db:create`
1. run `rake db:migrate`
1. run `rails s` 

## API Details

You can Read documentation at `localhost:3000/docs/api` or simply hit the API at `localhost:3000/api/v1/players/:id`

## Tests

To run tests simply run `rspec spec` in terminal