****Movie List App:****

**Description**
A simple Flutter application that retrieves and displays a list of movies from a public API. The app shows a list of movies in a scrollable view, on the main screen it only shows movies poster, movie name and year of release. I have used the OOP concept and handled basic error cases.
The API key I have got from https://www.omdbapi.com/.

**Features:**
•	Fetches a list of movies from an API.
•	Displays movies in a scrollable list.
• Displays the details of the movie of your own choice
•	Handles errors gracefully with a user-friendly message


**Installation**
1.	Clone the repository:
       git clone <repository-url>
2.	Navigate to the project directory:
       cd <project-directory>
3.	Install dependencies:
       flutter pub get
4.	Run the app:
        flutter run


   
**Usage**
1.	Launch the app on an emulator or physical device.
2.	The app will display a list of movies retrieved from the API.
3.	Scroll through the list to view different movies.

   
**API**
The app uses the OMDB API to fetch movie data. The API endpoint used is:
https://www.omdbapi.com/?s=batman&apikey=bf273dec



**OOP Concepts Used:**
Encapsulation: Data and methods related to movie handling are encapsulated in the MovieModel class.
Abstraction: The ApiService class abstracts the details of API interactions.
inheritance: BaseApiService provides a base for API-related operations.

**Error Handling**
•	Displays error messages if the API request fails or no movies are found.
•	Handles common HTTP errors like bad requests and unauthorized access.
• In case of error, Toast Message will be shown.
• Handled every exception in a detailed way.
