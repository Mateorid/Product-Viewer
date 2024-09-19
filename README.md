# Product Viewer

Product Viewer is a simple mobile application built with Flutter that allows users to view a list of
products fetched from the [Fake Store API](https://fakestoreapi.com/). Users can also view detailed
information about each product, including an image, description, price, and rating. The app uses the
BLoC (Business Logic Component) architecture to manage the app's state, and it includes local
caching of products to ensure offline access.

## Features

- **Product List:** Fetch and display a list of products from the Fake Store API, showing the
  product's title, price, and a thumbnail image.
- **Product Detail View:** Click on any product to view detailed information, including an image,
  description, price, and rating.
- **Offline Mode:** Data is cached locally using Hive, so the product list is available even when
  there is no internet connection.
- **Error Handling:** Handles potential network errors and shows appropriate messages to the user.
- **BLoC Architecture:** The app uses BLoC to manage the state, ensuring that the UI is updated
  efficiently and cleanly.

## Table of Contents

- [Installation](#installation)
- [Project Structure](#project-structure)
- [API Integration](#api-integration)
- [Cache Implementation](#cache-implementation)
- [Performance Optimization](#performance-optimization)
- [Development Tools](#development-tools)
- [How to Run](#how-to-run)
- [Notes](#notes)

## Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/Mateorid/Product-Viewer.git
   cd product_viewer
   ```

2. Install Flutter if you don't already have it installed. You can find installation instructions on
   the [Flutter website](https://flutter.dev/docs/get-started/install).

3. Install the required dependencies by running:
   ```bash
   flutter pub get
   ```

4. Run the code generator:
   ```bash
   flutter packages pub run build_runner build
   ```

## Project Structure

The app follows a clean architecture using BLoC and is structured into logical modules:

```
├───products
│   ├───bloc                        # Contains BLoC classes for managing app state
│   ├───models                      # Contains data models
│   ├───repository                  # Repository layer for fetching data from API and cache
│   └───ui                          # Contains all widgets ad UI elements
│       ├───common                  # Contains reusable UI elements
│       ├───product_detail_page
│       └───product_list_page
└───util                            # Contains utility functions and files
```

### Key Files

- **BLoC (`bloc/`)**: Manages the state of the app in response to user actions and API calls.
- **Models (`models/`)**: Defines the structure of the product data, including Hive data structures
  for caching.
- **Repository (`repository/`)**: Manages fetching data from the Fake Store API and
  storing/retrieving data in the local cache.
- **UI (`ui/`)**: Contains the UI components for the product list and detail view.

## API Integration

The app uses the [Fake Store API](https://fakestoreapi.com/) to fetch product data. The
repository (`ProductRepository`) handles the API requests using the `dio` package.

API Endpoints used:

- **GET** `/products?limit=x`: Fetches `x` amount of products.
  In case the API call fails, the app retrieves the products from the local cache using Hive.

## Cache Implementation

The app uses the **Hive** package for local data storage, enabling offline access to products.

- Data fetched from the API is stored in a Hive box named `products`.
- If the app detects no internet connection, it loads products from the local cache.
- The product model is serialized into Hive using a Hive adapter (`ProductAdapter`), allowing
  efficient binary storage of objects.

## Performance Optimization

To ensure smooth performance:

- **ListView.builder** is used to efficiently render large lists of products.
- BLoC architecture minimizes unnecessary rebuilds of UI components by managing state changes in an
  optimal way.
- The `Hive` database is used for fast local storage and retrieval of product data, reducing the
  need for repeated API calls.

## Development Tools

During development, the following tools were used to ensure performance and stability:

- **Flutter DevTools**: Used to monitor and optimize app performance.
- **Hive**: Lightweight, high-performance NoSQL database for storing product data.
- **BLoC**: State management pattern that separates UI from business logic.

## How to Run

1. Ensure that Flutter is installed and your device (or emulator) is properly set up.

2. Run the app:
   ```bash
   flutter run
   ```

   This will build and run the app either on a connected device or an emulator.

3. To run the app in debug mode, use:
   ```bash
   flutter run --debug
   ```

4. If you'd like to run it in release mode for better performance:
   ```bash
   flutter run --release
   ```

## Notes

- **Flutter version** The project was written with Flutter version: 3.24.1 & Dart: 3.5.1
- **Offline Mode:** If you start the app with no internet connection, the app will attempt to load
  the product list from the local cache. Be aware that if no products have been previously fetched,
  no data will be available.
- **Error Handling:** If the API request fails or the data is invalid, an error message will be
  displayed to the user.
- **State Management:** BLoC ensures the app handles state changes predictably, such as when
  switching between the product list and product details.
