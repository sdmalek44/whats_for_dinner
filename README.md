# WhatsForDinner API

## Endpoints

- [Users](#Users)
- [Login](#Login)

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
