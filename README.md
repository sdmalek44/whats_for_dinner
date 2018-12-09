# :hamburger: **WhatsForDinner API**

## About

- This is an API for an application that allows users to quickly and easily find something to make for dinner.
- Add all [Endpoints](#Endpoints) to this base URL https://api-whats-for-dinner.herokuapp.com

## External APIs

- Yummly API

## Local Setup

- First make sure you have Ruby version 2.4.3 and Rails 5.2.1 installed on your machine
- `$ git clone https://github.com/sdmalek44/whats_for_dinner.git`
- `$ cd whats_for_dinner`
- `$ bundle install`
- `$ figaro install`
- Open `config/application.yml` file
- Go request an api key from yummly.com
- Put the following in that file:

```
YUMMLY_ID: <id obtained from yummly.com>
YUMMLY_KEY: <key obtained from yummly.com>
```

- `$ rake db:{create,migrate}`
- `$ rails s` to run server
- go to [localhost:3000](https://localhost:3000/) to use API

## Run Tests

- `$ rspec`

## Endpoints

- [Users](#Users)
- [Login](#Login)
- [Searches](#Searches)
- [Recipes](#Recipes)

## Users

#### POST /api/v1/users

- creates a new user and returns the users email and auth token
- returns 400 if user already exists or incomplete payload

Submit following json payload in body of request:

```json
{
  "user": {
    "email": "bobjones@email.com",
    "password": "bobbytime"
  }
}
```

Will receive following json:

```json
{
  "email": "bobjones@email.com",
  "token": "talskdjfieoi23jljlk4j5kl4kjl"
}
```

## Login

#### POST /api/v1/login

- Authenticates the user and returns users email and authentication token
- Will respond with 400 if password is incorrect or user not found

Submit following JSON in body of request:

```json
{
  "user": {
    "email": "bobjones@email.com",
    "password": "bobbytime"
  }
}
```

Will return in body of response:

```json
{
  "email": "bobjones@email.com",
  "token": "talskdjfieoi23jljlk4j5kl4kjl"
}
```

## Searches

#### POST /api/v1/users/:token/searches

- uses user auth token, search keyword, allergies, and max cook time to search for recipes
- Will save users search in database
- Will return 400 if not all parameters are given
- Possible allergies are: wheat, gluten, peanut, tree nut, dairy, egg, seafood, sesame, soy, sulfite (all lower case)

  Example request:

  - POST /api/v1/users/leisfkdjfoisjhusdf29lk4t4k5/searches

JSON in body:

```json
{
  "keyword": "sliders",
  "allergies": ["peanut", "dairy"],
  "max_cook_time": "35"
}
```

JSON returned:

```json
[
  {
    "name": "Shanghai Sliders",
    "image":
      "https://lh3.googleusercontent.com/EZIlBobdy3aVoIRSSZ-CBPqtbIXlIFNtryd510Xj7sPSZJV18-3UiopuxUSGgEy0TjieS7JCLswilDkASsx9=s90",
    "recipe_id": "Shanghai-Sliders-2017148",
    "cook_time": 35
  }
]
```

#### GET /api/v1/users/:token/searches

- Allows you to find a users past searches
- you can order starting with oldest, newest
- returns 404 if user not found

Example request:

```
/api/v1/users/20394jklwkj34232432/searches?order=newest
```

Example JSON response:

```json
[
  {
    "max_time": 35,
    "allergies": "dairy, soy",
    "keyword": "chicken"
  },
  {
    "max_time": 15,
    "allergies": "egg",
    "keyword": "soup"
  }
]
```

## Recipes

#### GET /api/v1/recipes/:recipe_id

- Allow you to view a single recipe
- Will return 404 if recipe not found

Example request:

```
GET /api/v1/recipes/Quick-chicken-enchilada-soup-350936
```

Example JSON response:

```json
{
  "name": "Quick Chicken Enchilada Soup",
  "minutes": 25,
  "servings": 4,
  "image":
    "http://lh4.ggpht.com/IVpIyL7sXXwoG8tl6lKKyY7vvDR7aLI4Ro40xhEwrh5EFgjk4yBXyaL0NeERBYZaPq0GfY_0cTbG_VoDW2PcTCk=s360",
  "ingredients": [
    "1 (15 oz) can of corn, drained",
    "1 (15 oz) can black beans, drained and rinsed",
    "1 14.5-ounce can diced tomatoes (I used the kind with sweet onion in it)",
    "1 (12.5 oz) can Swanson Premium Chunk Chicken, drained and broken up",
    "1 (10 oz) can enchilada sauce",
    "1 (10¾ oz) can Campbell’s cream of mushroom soup",
    "1½ cups milk (I used skim)",
    "tortilla chips",
    "shredded cheese"
  ]
}
```
