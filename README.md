# README

Simple, dynamic link shortener. Inspired by [Shorti](https://github.com/scottwater/shorti).

# Usage

1. Start the server:
    ```bash
    $ SHORTENER_API_KEY=secret bin/rails s
    ```
2. Create a shortened link:
    ```bash
    $ curl -d "api_key=secret&url=https://www.codeforamerica.org&description=website" localhost:3000/links
    ```
   
   Which will return a JSON object:
   ```json
   {
     "id": 3,
     "slug": "NYczp",
     "description": "website",
     "url": "https://www.codeforamerica.org",
     "shortened_url": "http://localhost:3000/NYczp",
     "uses_count": 0,
     "first_used_at": null,
     "last_used_at": null,
     "$ref": "http://localhost:3000/links/NYczp"
   }
   ```
3. Visit the `shortened_url` to be redirected.
4. Check the status of the URL:
    ```bash
    $ curl "http://localhost:3000/links/NYczp?api_key=secret"
    ```
   
   Which will return a JSON object:
   ```json
   {
     "id": 3,
     "slug": "NYczp",
     "description": "website",
     "url": "https://www.codeforamerica.org",
     "shortened_url": "http://localhost:3000/NYczp",
     "uses_count": 1,
     "first_used_at": "2020-08-05T00:42:32.840Z",
     "last_used_at": "2020-08-05T00:42:32.840Z",
     "$ref": "/links/NYczp"
   }
   ```

# Installation and Usage

A vanilla Ruby on Rails application.

- Must set `SHORTENER_API_KEY` environment variable.
