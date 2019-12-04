# Animal Shelter

Animal Shelter is a website that handles users viewing pets for adoption, joining the waiting list, and donating. It has a volunteer view that allows for tracking animals, including their adoption process and training progress.

## Installation

Requires Ruby 2.4.1, Sinatra, and PG to run.

Also Requires Pry and MiniTest for testing.

```bash
Ruby: https://www.ruby-lang.org/en/downloads/
Sinatra: gem install sinatra -v 1.4.7
PG: gem install pg
```

```bash
Pry: gem install pry
MiniTest: gem install minitest
```

## Usage

```bash
git clone git@github.com:charliepja/animal-shelter.git

psql -d shelter -f db/shelter.sql

ruby db/seed.rb

ruby controller.rb

```

## Brief
The Scottish Animal Shelter accepts orphaned or stray animals and takes care of them until they can be adopted by a new owner. The shelter has a list of potential new owners for the animals. Animals may take a while to be trained up and made healthy before being available for adoption.

They are looking for a management system to keep track of their animals and owners.

## Functionality
* Separate Public and Volunteer View
* Ability for public to view all animals and filter by type, breed, training status
* Ability for public to join the waiting list to adopt animals, and donate to the shelter
* Ability for volunteers to update pet details, training status, and adoption status
* Ability for volunteers to add new pets to the shelter
* Ability for volunteers to view those who have adopted animals, and those who are waiting to adopt on separate pages
* Ability for volunteers to update customers details

## License
[MIT](https://choosealicense.com/licenses/mit/)
