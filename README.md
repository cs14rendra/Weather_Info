# Weather_Info
Weather App by using OpenWeatherMap, Google Map 

## ScreenShots

<p align="center">
  <img src="http://i.imgur.com/D6RRoZP.png" width="350"/>
  <img src="http://i.imgur.com/WWehtXb.png" width="350"/>
</p>


## Installation
1. clone the repo
2. run "pod install" in project directory
3. open "Weather Info.xcworkspace"

## Features

App is having following feature :
- If user location is not available then a by default marker will be placed on Location(27,80).
- If anytime User location is find by App then, default marker will be removed and a new marker will be placed on current user       location
- When the User tapped on the Marker, App fetch current marker position on the Google Map and call OpenWeatherApi to fetch 
  Weather data 
- And same time user Switched to Next Screen to see details of Weather at Marker location. if the data is Available then it will be shown in carousel view.
- User have choice to choose between Celcius, Kelvin and Forenhite Temprature.
- Location Authorization will prompt Everytime if User has restricted to fetching user location so that they can easily turnedt it on.

## Credits
The following third party library and icon i have used in my project 
1.https://github.com/rs/SDWebImage
2. icon from https://icons8.com

## Requirements
developed using xcode 8.3.3
pod version 1.1.1

## License
Dark is available under the MIT license. See the LICENSE file for more info.
