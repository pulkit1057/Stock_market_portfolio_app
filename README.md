# Stock Market Portfolio App

## Overview
The Stock Market Portfolio App is a mobile application built using Flutter and Dart, with a backend powered by Node.js and Express.js, and a MySQL database. The app allows users to search for Indian stocks, manage their portfolio by adding, editing, or deleting stocks, visualize their holdings using a pie chart, and stay updated with trending stock market news. It also includes a light and dark theme toggle using the Provider package.

## Features
- **Stock Search**: Search for different Indian stocks and add them to your portfolio.
- **Portfolio Management**: Add, edit, and delete stocks from your portfolio.
- **Data Visualization**: View a pie chart representation of your holdings.
- **Trending News**: Stay updated with real-time stock market news.
- **Theming**: Switch between light and dark themes using the Provider package.

## Technologies Used
### Frontend
- Flutter
- Dart
- Provider (for state management and theming)

### Backend
- Node.js
- Express.js

### Database
- MySQL

## Installation and Setup
### Prerequisites
- Flutter SDK installed
- Node.js and npm installed
- MySQL database set up

### Steps
1. Clone the repository:
   ```sh
   git clone https://github.com/your-repo-url.git
   cd stock-market-portfolio
   ```
2. Install dependencies for the Flutter app:
   ```sh
   flutter pub get
   ```
3. Navigate to the backend folder and install dependencies:
   ```sh
   cd backend
   npm install
   ```
4. Set up the MySQL database and update the database credentials in the backend `.env` file.
5. Start the backend server:
   ```sh
   node server.js
   ```
6. Run the Flutter app:
   ```sh
   flutter run
   ```


## Future Enhancements
- Implement user authentication.
- Add stock price tracking and alerts.
- Improve UI/UX with animations and interactive elements.

## License
This project is licensed under the MIT License.

## Contact
For any queries, feel free to reach out at [your email/contact info].

