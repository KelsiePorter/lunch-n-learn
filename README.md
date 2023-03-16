# 🍽 Lunch and Learn
The goal of this project is to create a backend service that will be used by a frontend team to create an application. The app will allow users to search for recipes by country, favorite recipes, and learn more about a particular country. This backend service will expose several endpoints for the frontend team to use including getting recipes and learning resources for a particular country, creating users, and also creating and tracking a user's favorite recipes.

## 📝 Learning Goals 
* Expose an API that aggregates data from multiple external APIs
* Expose an API that requires an authentication token 
* Expose an API for CRUD functionality
* Determine completion criteria based on the needs of other developers 
* Test both API consumption and exposure, making use of at least one mocking tool (VCR, Webmock, etc)

## 🔗 API Information
This project comsumes external APIs that require API Keys. The Figaro gem was used to create a hidden .yml file to save the env files (you can use any gem to accomplish this). The gem is already listed in Gemfile but you need to follow the additional steps listed [here](https://github.com/laserlemon/figaro#:~:text=Figaro%20installation%20is%20easy%3A). Start at `bundle exec figaro install`

The variable names of your api keys must follow this pattern: 

[Edamam API](https://developer.edamam.com/edamam-recipe-api)
* recipe_app_id: YOUR EDAMAM API ID
* recipe_app_key: YOUR EDAMAM APP KEY

[YouTube API](https://developers.google.com/youtube/v3/docs/search/list)
* youtube_api: YOUR YOUTUBE API KEY

[Unsplash API](https://unsplash.com/documentation#search-photos)
* unsplash_api_key: YOUR UNSPLASH API KEY
* unsplash_secret_key: YOUR UNSPLASH SECRET KEY

[Places API](https://apidocs.geoapify.com/docs/places/#about)
* places_api_key: 'YOUR PLACES API KEY'

[REST Countries API](https://restcountries.com/#api-endpoints-v3-all)
* This API was also consumed, but does not require an API Key.

## ✅ Setup
This project requires Ruby 2.7.4

1. Fork and clone this repository.
2. `cd` into the root directory
3. Run `bundle install`
4. Run `rails db:{drop,create,migrate}`
5. To run the test suite, run `bundle exec rspec`
6. To run this server, enter `rails s`
7. You should now be able to hit the API endpoints using Postman or a similar tool

## 📍Enpoints 
All endpoints start with url: `http://localhost:3000`

### Get Recipes
**Request:** `GET /api/v1/recipes?country=<country name>`

**Response:**
```
{
    "data": [
        {
            "id": null,
            "type": "recipe",
            "attributes": {
                "title": "Andy Ricker's Naam Cheuam Naam Taan Piip (Palm Sugar Simple Syrup)",
                "url": "https://www.seriouseats.com/recipes/2013/11/andy-rickers-naam-cheuam-naam-taan-piip-palm-sugar-simple-syrup.html",
                "country": "thailand",
                "image": "https://edamam-product-images.s3.amazonaws.com..."
            }
        },
        {
            "id": null,
            "type": "recipe",
            "attributes": {
                "title": "Sriracha",
                "url": "http://www.jamieoliver.com/recipes/vegetables-recipes/sriracha/",
                "country": "thailand",
                "image": "https://edamam-product-images.s3.amazonaws.com/."
            }
        },
        {...},
        {...},
        {...},
        {etc},
    ]
}
```

### Get Learning Resources
**Request:** `GET /api/v1/learning_resources?country=<country name>` 

**Response:** 
```
{
    "data": {
        "id": null,
        "type": "learning_resource",
        "attributes": {
            "country": "laos",
            "video": {
                "title": "A Super Quick History of Laos",
                "youtube_video_id": "uw8hjVqxMXw"
            },
            "images": [
                {
                    "alt_tag": "standing statue and temples landmark during daytime",
                    "url": "https://images.unsplash.com/photo-1528181304800-259b08848526?ixid=MnwzNzg2NzV8MHwxfHNlYXJjaHwxfHx0aGFpbGFuZHxlbnwwfHx8fDE2Njc4Njk1NTA&ixlib=rb-4.0.3"
                },
                {
                    "alt_tag": "five brown wooden boats",
                    "url": "https://images.unsplash.com/photo-1552465011-b4e21bf6e79a?ixid=MnwzNzg2NzV8MHwxfHNlYXJjaHwyfHx0aGFpbGFuZHxlbnwwfHx8fDE2Njc4Njk1NTA&ixlib=rb-4.0.3"
                },
                {
                    "alt_tag": "orange temples during daytime",
                    "url": "https://images.unsplash.com/photo-1563492065599-3520f775eeed?ixid=MnwzNzg2NzV8MHwxfHNlYXJjaHwzfHx0aGFpbGFuZHxlbnwwfHx8fDE2Njc4Njk1NTA&ixlib=rb-4.0.3"
                },
                {...},
                {...},
                {...},
                {etc},
              ]
        }
    }
}
```

### Create a User 
**Request:** 
```
POST /api/v1/users
Content-Type: application/json
Accept: application/json

{
  "name": "Betsy Jett",
  "email": "betsy@example.com"
}
```

**Response:** 
```
{
  "data": {
    "type": "user",
    "id": "1",
    "attributes": {
      "name": "Betsy Jett",
      "email": "betsy@example.com",
      "api_key": "jgn983hy432432jij2343kjih2"
    }
  }
}
```

### Create User Favorites
**Request:**
```
POST /api/v1/favorites
Content-Type: application/json
Accept: application/json

{
    "api_key": "jgn983hy432432jij2343kjih2",
    "country": "thailand",
    "recipe_link": "https://www.tastingtable.com/.....",
    "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)"
}
```

**Response:**
```
{
    "success": "Favorite added successfully"
}
```

### Get a User's Favorites
**Request:** `GET /api/v1/favorites?api_key=<user api key>`

**Response:**
```
{
    "data": [
        {
            "id": "1",
            "type": "favorite",
            "attributes": {
                "recipe_title": "Recipe: Egyptian Tomato Soup",
                "recipe_link": "http://www.thekitchn.com/recipe-egyptian-tomato-soup-weeknight....",
                "country": "egypt",
                "created_at": "2022-11-02T02:17:54.111Z"
            }
        },
        {
            "id": "2",
            "type": "favorite",
            "attributes": {
                "recipe_title": "Crab Fried Rice (Khaao Pad Bpu)",
                "recipe_link": "https://www.tastingtable.com/.....",
                "country": "thailand",
                "created_at": "2022-11-07T03:44:08.917Z"
            }
        }
    ]
 }
```

### Get Tourist Sights 
**Request:** `GET /api/v1/tourist_sights?country=<country_name>`

**Response:**
```
{
    "data": [
        {
            "id": null,
            "type": "tourist_sight",
            "attributes": {
                "name": "Tour de l'horloge",
                "address": "Tour de l'horloge, Allée de l'Horloge, 23200 Aubusson, France",
                "place_id": "51d28..."
            }
        },
        {
            "id": null,
            "type": "tourist_sight",
            "attributes": {
                "name": "Le Château",
                "address": "Le Château, D 18, 23150 Ahun, France",
                "place_id": "51934..."
            }
        },
        {
            "id": null,
            "type": "tourist_sight",
            "attributes": {
                "name": "Le Chapître",
                "address": "Le Chapître, Rue du Chapitre, 23200 Aubusson, France",
                "place_id": "517182..."
            }
        },
        ...,
        ...,
    ]
}
```
