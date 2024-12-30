# <img src="https://github.com/MarekRudzki/Cinemania/assets/102899533/1be75e86-a323-476b-95b5-ed7243d92f1d" width=3% height=3%>    Cinemania - Movie App    <img src="https://github.com/MarekRudzki/Cinemania/assets/102899533/13833d95-6516-4c79-abcb-e47ec1f58ea7" width=3% height=3%>

Flutter application about movies, TV shows and actors using TMDB.

## Table of contents
* [General info](#general-info)
* [Technologies](#technologies)
* [How to run](#how-to-run)

## General info
<p align="justify"> 
An application developed using the excellent TMDB API. The user logs into the application using one of three methods (FirebaseAuth) or automatically (Hive) if he has logged in before. On the main screen, there are various categories of movies and TV shows such as Popular, Coming Soon, Recommended (only visible to users who have liked any titles) Greatest Hits, Random Decade Hits (selected randomly when the app starts), Best of Random Year and Categories (genres). Users can search for given movies, TV shows or actors and see their favorites in dedicated screens.<br />
  After clicking on a given tile, a screen with details is shown. For a given actor it include photos, a list of films and TV shows in which actor appeared, a career description and basic data such as place of birth, age and height. For movies and TV shows the following are shown: cast, description, photos, similar titles, rating, genres and detailed data (for movies - release date, runtime, budget and revenue, for TV shows - years in which the title aired, total number of seasons and episodes). For TV shows, there is also a screen with detailed information about  seasons with a list of episodes and their data (title, broadcast date, description, length, rating).
</p>


### 🎞️ What's included
- TMDB data used with over 900.000 movies, 160.000 TV Shows, 3.000.000 people and 5.000.000 images
- Various categories along with two randomly generated
- Detail screens for movies, TV shows and actors
- Seasons & Episodes lists for TV shows
- Login via Facebook, Google, Login & Password
- Authentication features (username change, password reset, password change, delete account)
- User data storage in Hive & Firestore


### :hammer_and_wrench: App created with
- BLoC
- Clean Architecture
- Dio
- dotenv
- Firebase
- GetIt, injectable
- Hive
- Hooks
- Lints
- MVVM
- Pagination
- TMDB API
- Unit tests
<br />
<p float="left">
<img src="https://github.com/MarekRudzki/Cinemania/assets/102899533/d066a819-7b89-4aa3-9c67-9178679b4b4a" hspace="10" width=25% height=25%>
<img src="https://github.com/MarekRudzki/Cinemania/assets/102899533/95995339-64bc-4dbb-8cbb-3f42e902124c" hspace="10" width=25% height=25%>
<img src="https://github.com/MarekRudzki/Cinemania/assets/102899533/a432a7d8-0f7b-4cf7-837c-98808ac6f6c1" hspace="10" width=25% height=25%>
<p>
<img src="https://github.com/MarekRudzki/Cinemania/assets/102899533/0a3d5d8d-569f-483a-8ecb-2e8cd74be6e2" hspace="10" width=25% height=25%>
<img src="https://github.com/MarekRudzki/Cinemania/assets/102899533/51d624e8-cb9e-4120-90ca-33f008a66582" hspace="10" width=25% height=25%>
<img src="https://github.com/MarekRudzki/Cinemania/assets/102899533/9da623b7-f700-4323-a56b-36b26628c85e" hspace="10" width=25% height=25%>
<p>
<img src="https://github.com/MarekRudzki/Cinemania/assets/102899533/c2b89f12-0aa5-4613-ab08-b4e504db8b92" hspace="10" width=25% height=25%>
<img src="https://github.com/MarekRudzki/Cinemania/assets/102899533/795eed74-f7f8-4816-8c6e-b249b90a9d87" hspace="10" width=25% height=25%>
<img src="https://github.com/MarekRudzki/Cinemania/assets/102899533/6201ab31-2376-4d29-81dd-d75330edc59e" hspace="10" width=25% height=25%>
<p>
<img src="https://github.com/user-attachments/assets/19a36b2f-db60-4b84-b13c-2635dbfd9bc0" hspace="10" width=25% height=25%>
</p>


https://github.com/MarekRudzki/Cinemania/assets/102899533/b6b2d41b-4d73-458e-afcf-e7b2574b0859

https://github.com/MarekRudzki/Cinemania/assets/102899533/697a6ce1-a067-4f36-97ca-5d167c1923f2

## Technologies
Project was created with:
* Flutter version: 3.27.1
* Dart version: 3.6.0

## How to run
1. Copy repository link.
   ```sh
   git clone https://github.com/MarekRudzki/Cinemania.git
   ```
2. Open command prompt and navigate to the path where you want to clone repo.
3. Paste copied link and hit enter.
4. Congrats, you have successfully cloned this repository in your computer!
5. Open project in IDE of your choice.
6. Get a free TMDB API key from the [TMDB](https://developer.themoviedb.org/reference/intro/getting-started).
7. Get a free Ninjas API key from the [Ninjas](https://api-ninjas.com/).
8. In main app folder create a file called `.env` including:
   ```sh
   TMDBkey = Your_TMDB_Key
   NinjasAPIKey = 'Your_Ninjas_Key'
   ```
9. Run the app.
   


---

<h1>
  Hey There!
  <img src="https://media.giphy.com/media/hvRJCLFzcasrR4ia7z/giphy.gif" width="30px"/>
</h1>

### <img src="https://media.giphy.com/media/WUlplcMpOCEmTGBtBW/giphy.gif" width="30"> About Me


I am a Flutter developer from Poland.
- :telescope: Started my Flutter journey in March 2022.
- :book: Learning new Flutter related stuff every day.
- :computer: In my free time, I love to read books and play video games.
- :video_game: Currently I have one app published on Google Play Store - "Słowotok - polska gra Wordle"

### :fire: My Stats
[![GitHub Streak](http://github-readme-streak-stats.herokuapp.com?user=MarekRudzki&theme=dark&background=000000)](https://git.io/streak-stats)
