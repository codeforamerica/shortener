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
     "$ref": "http://localhost:3000/links/NYczp",
     "uses": []
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
     "first_used_at": "2020-08-06T02:34:31.741Z",
     "last_used_at": "2020-08-06T02:34:31.741Z",
     "$ref": "/links/NYczp",
     "uses": [
       {
         "id": 7,
         "link_id": 3,
         "created_at": "2020-08-06T02:34:31.741Z",
         "identity": "e6a1f38d3567af97a388b25b2dd3700c",
         "user_agent": "Mozilla/5.0 (Macintosh; Intel Mac OS X 10_15_6) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/83.0.4103.106 Safari/537.36"
       }
     ]
   }
   ```

# Installation and Usage

A vanilla Ruby on Rails application.

- Must set `SHORTENER_API_KEY` environment variable.
