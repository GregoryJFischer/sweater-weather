# Sweater Weather

## Overview
An application that returns weather information to a non-existant front-end application that calculates weather for a driving route and related functionality.

This application is completed following the mod 3 final project guidelines for the Turing School of Software and Design which can be found [here](https://backend.turing.edu/module3/projects/sweater_weather/).

## Setup

This application was written in Ruby 2.7.2 with Ruby on Rails version 5.2.6.

### Local Setup
1. Fork and Clone the repo
2. Install gem packages: `bundle install`
3. Set-up Figaro: `bundle exec figaro install` and add API keys (listed below) to config/application.yml
3. Setup the database: `rails db:{drop,create,migrate}`
4. Start local server to hit endpoints: `rails server`

### Required API Keys

* OpenWeather key obtained on their [website](https://openweathermap.org/). Environment variable should be called `weather_key`
* MapQuest key obtained on their [website](https://developer.mapquest.com/). Environment variable should be called `map_key`
* UnSplash key and secret obtained on their [website](https://unsplash.com/). Environment variable for the key should be called `unsplash_key` and the variable for the secret should be called `unsplash_secret`

## Endpoints
All requests should be sent with the following headers:
```
Content-Type: application/json
Accept: application/json
```
### GET `api/v1/forecast`

#### Parameters
All parameters for this request should be passed as querry parameters
* location (required): A string representing the desired city (e.g. `location=Washington,DC`)
* units (optional): A string representing the desired units. Set to imperial by default. (e.g. `units=metric`)

#### Example Response
GET `/api/v1/forecast?location=denver,co`

```
{
    "data": {
        "id": null,
        "type": "forecast",
        "attributes": {
            "current_weather": {
                "datetime": "2022-01-18 15:30:24",
                "sunrise": "2022-01-18 09:17:46",
                "sunset": "2022-01-18 19:02:38",
                "temperature": 51.73,
                "feels_like": 47.73,
                "humidity": 24,
                "uvi": 1,
                "visibility": 10000,
                "conditions": "overcast clouds",
                "icon": "04d"
            },
            "daily_weather": [
                {
                    "date": "2022-01-18",
                    "sunrise": "2022-01-18 09:17:46",
                    "sunset": "2022-01-18 19:02:38",
                    "max_temp": 51.73,
                    "min_temp": 34.83,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "date": "2022-01-19",
                    "sunrise": "2022-01-19 09:17:15",
                    "sunset": "2022-01-19 19:03:46",
                    "max_temp": 32.95,
                    "min_temp": 25.32,
                    "conditions": "light snow",
                    "icon": "13d"
                },
                {
                    "date": "2022-01-20",
                    "sunrise": "2022-01-20 09:16:43",
                    "sunset": "2022-01-20 19:04:54",
                    "max_temp": 38.79,
                    "min_temp": 24.49,
                    "conditions": "clear sky",
                    "icon": "01d"
                },
                {
                    "date": "2022-01-21",
                    "sunrise": "2022-01-21 09:16:09",
                    "sunset": "2022-01-21 19:06:03",
                    "max_temp": 35.53,
                    "min_temp": 31.5,
                    "conditions": "light snow",
                    "icon": "13d"
                },
                {
                    "date": "2022-01-22",
                    "sunrise": "2022-01-22 09:15:33",
                    "sunset": "2022-01-22 19:07:13",
                    "max_temp": 38.44,
                    "min_temp": 28.58,
                    "conditions": "few clouds",
                    "icon": "02d"
                }
            ],
            "hourly_weather": [
                {
                    "time": "15:00:00",
                    "temperature": 51.03,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "time": "16:00:00",
                    "temperature": 51.73,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "time": "17:00:00",
                    "temperature": 51.12,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "time": "18:00:00",
                    "temperature": 49.82,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "time": "19:00:00",
                    "temperature": 47.34,
                    "conditions": "overcast clouds",
                    "icon": "04d"
                },
                {
                    "time": "20:00:00",
                    "temperature": 44.67,
                    "conditions": "overcast clouds",
                    "icon": "04n"
                },
                {
                    "time": "21:00:00",
                    "temperature": 40.23,
                    "conditions": "broken clouds",
                    "icon": "04n"
                },
                {
                    "time": "22:00:00",
                    "temperature": 38.95,
                    "conditions": "scattered clouds",
                    "icon": "03n"
                }
            ]
        }
    }
}
```

### GET `/api/v1/bacgrounds`
Queries UnSplashed for a relevent photo for a given location.

#### Parameters
All parameters for this request should be passed as querry parameters
* location (required): A string representing the desired city (e.g. `location=Washington,DC`)

#### Example Response

GET `/api/v1/backgrounds?location=New York,NY`
```
{
    "data": {
        "type": "image",
        "id": null,
        "attributes": {
            "image": {
                "location": "New York,NY",
                "image_url": "https://images.unsplash.com/photo-1596491690105-2916ddc03050?ixid=MnwyOTExNzZ8MHwxfHNlYXJjaHwxfHxOZXclMjBZb3JrJTJDTll8ZW58MHx8fHwxNjQyNTM3ODM4&ixlib=rb-1.2.1&utm_source=sweater-weather-api&utm_medium=referral&utm_campaign=api-credit",
                "credit": {
                    "source": "Unsplash",
                    "source_url": "https://unsplash.com/?utm_source=sweater-weather-api&utm_medium=referral",
                    "photographer": "Steve Harvey",
                    "photographer_link": "https://unsplash.com/@trommelkopf?utm_source=sweater-weather-api&utm_medium=referral"
                }
            }
        }
    }
}
```

### POST `/api/v1/users`

Endpoint for creating a user. This endpoint requires that information in the request be sent as a JSON payload in the body of the request.

#### Example Request Body

```
{
  "email": "test@example.com",
  "password": "password",
  "password_confirmation": "password"
}
```

#### Example Response
```
{
    "data": {
        "id": "1",
        "type": "user",
        "attributes": {
            "email": "test1@example.com",
            "api_key": "your_api_key"
        }
    }
}
```

### POST `/api/v1/sessions`
Endpoint for logging in a user. This endpoint requires that information in the request be sent as a JSON payload in the body of the request.

#### Example Request Body

```
{
    "email": "test@example.com",
    "password": "password"
}
```

#### Example Response
```
{
    "data": {
        "id": "1",
        "type": "user",
        "attributes": {
            "email": "test1@example.com",
            "api_key": "your_api_key"
        }
    }
}
```

### GET `/api/v1/road_trip`
Used for getting information about a road trip. Weather information if for the destination city at the time of arrival. This endpoint requires that information in the request be sent as a JSON payload in the body of the request and requires authentication via api key, which can be obtained from either creating a user or loggin a user in.

#### Example Request Body

```
{
  "origin": "Denver,CO",
  "destination": "Pueblo,CO",
  "api_key": "your_api_key"
}
```

#### Example Response
```
    "data": {
        "id": null,
        "type": "roadtrip",
        "attributes": {
            "start_city": "Denver,CO",
            "end_city": "Pueblo,CO",
            "travel_time": "01:45:28",
            "weather_at_eta": {
                "temperature": 62.87,
                "conditions": "clear sky"
            }
        }
    }
}
```

