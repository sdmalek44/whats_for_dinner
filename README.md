# WhatsForDinner API

## Endpoints

- [Users](#Users)
- [Login](#Login)
- [User Search](#User_Search)

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

## User_Search

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
