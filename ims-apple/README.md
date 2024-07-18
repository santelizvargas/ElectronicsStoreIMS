# IOS Mobile project

## MVVM-C Architecture

The MVVM-C architecture will be used in the project to improve the organization and management of information. The coordinator will handle the main routes, while modal presentations will be managed directly with SwiftUI navigation. This option is the most suitable for our needs.

MVVM: 
- Model: Manages business logic and data.
- View: Responsible for displaying data to the user.
- ViewModel: Manages presentation logic and prepares data for the View.
  
Coordinator: 
- Manages navigation between different views (routes) of the application. Centralizes the navigation and transition logic between screens, improving organization and reducing dependencies between views.

SwiftUI Navigation: 
- Will handle modal presentations.

> © 2024 PPLAM S.A. All Rights Reserved
