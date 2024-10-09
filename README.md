# Timely

A simple calendar app built with Flutter

### Architecture diagram

![Architecture diagram](assets/images/timely_architecture.svg)

#### Explanation:

1. **Data Layer**:

- The datasources are responsible for database-related operations such as querying, creating, updating and deleting objects in either local datasources e.g. local storage or remote datasources e.g. a PostgreSQL database.

- The repositories send data transfer objects (DTOs) to the datasources to be processed by the datasources. These repositories do not need to know exactly how the data is being processed, which leads to better abstraction.

2. **Domain Layer**:
   This layer contains entities/models of objects e.g. `Task`, `Event`, `User` so that the repositories can work with them.

3. **App Layer**:
   The app layer consists of services that are accountable for the business logic of the application. They get the data retrieved from the dependent repositories to perform some additional operations on that data.

4. **Presentational Layer**:
   This layer is about displaying data processed from the app layer in the UI. The stores act as providers whose job is to retrieve and manage the data provisioned by the services in the app layer, making the states in the stores globally available for widgets to access and consume.

> In this app, the state management pattern used is [Triple](https://triple.flutterando.com.br/). A triple store consists of three main components: state, loading and error. Combining with `get_it`, we can make these stores globally accessible throughout the widgets tree.
