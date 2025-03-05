# Flutter Absence Manager – Crewmeister Challenge Solution

## Solution Summary

- The Crewmeister Absence Manager app will be built with Flutter using Material Design components and the BLoC (Business Logic Component) pattern for state management. This approach ensures a clear separation between the UI and business logic. The app will read absence data from provided JSON files (simulating API calls) asynchronously, showing a loading indicator while fetching data and proper error/empty states as needed.

- **_update_** The app now is feeding form an api service. this can be setting up following instrucciont bellow or consuming the service direcly from render where 4 enpoints are exposed:

- GET https://crewmeister-absence-api.onrender.com/absences (Get all absences)

```
{
"admitterId": <int>,
"admitterNote": <string>,
"confirmedAt": <string>,
"createdAt": <string>,
"crewId": <int>,
"endDate": <string>,
"id": <int>,
"memberNote": <string>,
"rejectedAt": <string>,
"startDate": <string>,
"type": "sickness",
"userId": <int>
}
```

- GET https://crewmeister-absence-api.onrender.com/members (Get all members)

```
{
    "crewId": <int>,
    "id": <int>,
    "image": <string>,
    "name": <string>,
    "userId": <int>
},
```

### Key Features

- Pagination (showing 10 absences per page)
- Filters for absence type and date
- Filter by state (Rejected, Pending or Confirmed)
- Smooth animations/transitions for an enhanced user experience
- iCal (.ics) file export for Outlook import
- Best practices in project structure and code quality:
  - Feature-based modular architecture
  - Separate layers for data, business logic, and presentation
  - Repository and service pattern for data handling
  - BLoC for state management
  - Clean code principles
  - Unit and widget tests with `flutter_test`

---

### 2. Feature-Based Folder Structure

```

lib/
├── main.dart # Entry point, sets up MaterialApp
├── app.dart # App widget, MaterialApp with theme and routes
├── features/
│ └── absences/ # Feature: Absence Manager
│ ├── data/ # Data layer
│ │ ├── models/ # Dart data models
│ │ ├── services/ # Data providers
│ │ ├── repositories/ # Data repositories
│ ├── logic/ # Business logic (BLoC)
│ └── presentation/ # UI layer (screens, widgets)
└── core/ # (Optional) shared resources (theme, utils)

```

This separation of concerns makes the project easier to navigate and scale.

## Project Setup and Structure

### Before running the project locally

- Make sure to set up the backend locally by going to this repository and following the instructions: [Go To crewmeister api](https://github.com/b-laztornex/crewmeister-absence-api).

### How to Run the Project

```sh
git clone git@github.com:b-laztornex/crewmeister-absence-app.git
cd crewmeister-absence-app
flutter pub get
flutter run
```

- Depending on your machine, you can choose to run the project on an Android emulator, an iOS simulator, or in Chrome for web.

- The base URLs are managed in lib/config/api_config.dart based on the environment/device you select to run on.

- If you encounter any connection issues, you can manually update this file with the correct URL for your setup.

### How to Run Tests

```sh
flutter test
```
