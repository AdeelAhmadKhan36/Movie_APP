## ****Movie List App:****

## Description
A simple Flutter application that retrieves and displays a list of movies from a public API. The app shows a list of movies in a scrollable view, on the main screen it only shows movies poster, movie name and year of release. I have used the OOP concept and handled basic error cases.
The API key I have got from https://www.omdbapi.com/.

## Features
- Fetches a list of movies from an API.
- Displays movies in a scrollable list.
- Shows details of a selected movie.
- Handles errors with user-friendly messages.



## Installation
1.	Clone the repository:
       git clone <repository-url>
2.	Navigate to the project directory:
       cd <project-directory>
3.	Install dependencies:
       flutter pub get
4.	Run the app:
        flutter run


   
## Usage
1.	Launch the app on an emulator or physical device.
2.	The app will display a list of movies retrieved from the API.
3.	Scroll through the list to view different movies.
4.	Also view a details description of the movie of your own choice.

   
## API
The app uses the OMDB API to fetch movie data. The API endpoint used is:
https://www.omdbapi.com/?s=batman&apikey=bf273dec



## **OOP Concepts Used:**

**Encapsulation:**
Encapsulation is demonstrated by the MovieModel class, which wraps the data and methods related to movie handling. This class encapsulates all movie-related properties (e.g., title, year, poster) and provides methods for parsing data from JSON, ensuring that movie data is handled consistently and safely.

**Abstraction:**
Abstraction is showcased in the ApiService class, which hides the details of API interactions. The ApiService class provides methods for fetching movie data without exposing the complexities of the underlying HTTP requests to other parts of the application. This separation allows the app to focus on using the service without dealing with low-level HTTP operations.

**Inheritance:**
Inheritance is used in the BaseApiService class, which provides a base structure for API-related operations. The ApiService class inherits from BaseApiService, allowing it to leverage common functionality and ensure consistency across different API service implementations. This approach promotes code reuse and simplifies maintenance.


Other class objects and constructors etc all these concepts has been used

## **Error Handling:**

•Displays error messages if the API request fails or no movies are found.

•Handles common HTTP errors like bad requests and unauthorized access.

•In case of an error, a Toast Message will be shown.

•Handled every exception in a detailed way.
