# Weather_Info
Weather App by using OpenWeatherMap, Google Map 

This is Weather Map App which fetch location from openWeatherMap API on Current User Location.

App is having following feature :
1. If user location is not available then a by default marker will be placed on Location(27,80).
2. If anytime User location is find by App then, default marker will be removed and a new marker will be placed on current user location
3. When the User tapped on the Marker, App fetch current marker position on the Google Map and call OpenWeatherApi to fetch 
  Weather data 
4. And same time user Switched to Next Screen to see details of Weather at Marker location. if the data is Available then it will be shown in carousel view.
5. User have choice to choose between Celcius, Kelvin and Forenhite Temprature.
6. Location Authorization will prompt Everytime if User has restricted to fetching user location so that they can easily turnedt it on.

Credits: 
The following third party library and icon i have used in my project 
1.https://github.com/rs/SDWebImage
2. icon from https://icons8.com

Platform -
developed using xcode 8.3.3
