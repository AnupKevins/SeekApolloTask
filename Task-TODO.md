### Tasks completed

* Add a login screen to authenticate a user with the application
  - Needed Input fields: Username & Password and a Login Button
* The logged-in session needs to be stored
  - The form of the Session will be a JWT-Token
* Add Logout capabilities
* Show list of active (where the status is `PUBLISHED`) job ads (with pagination or lazy loading)
* Add an indicator to the list screen whether the currently authenticated user already applied to a specific job
* Display job ads details with API integration
* Created only `My Profile` Tab
* When clicking on an available job, show a new screen with more details and the option to apply

### Tasks not done

* In `My Profile` Tab, via which candidates can adjust profile attributes (for example name)
  - Also requires Backend Work
* Add Password Change Capabilities
  - Also requires Backend Work
- Add search capabilities
  - Also requires Backend Work
* In `Show My Applications`, which should show all the current authenticated users applications (need to create a new backend endpoint as well)
  - Also requires Backend Work

### Stack used

* Architecture Pattern - Employing the `MVVM With Coordinator` Architecture Pattern to segregate presentation logic from business logic.
* Reposity Design Pattern - Implementing the Repository Design Pattern to adhere to the SOLID Principles.
* Factory Design Pattern - Utilizing the Factory Design Pattern for object creation and instantiation.
* Added AppConstants file for all constants variables.
* For UIDevelopment - Used UIKit Programmatically.
* Created Protocol for Repository, Network and ViewModel to Follow Protocol-Oriented Programming
* CompactMap - Incorporating the CompactMap for decoding Response data.
* UserDefault - Utilizing UserDefault for secure storage of JWT tokens.
* `Unit Test And UITest Cases` -  Developing Unit Test Cases with `95% code coverage`, including testing API responses for specific classes and employing a mocking approach for testing `Coordinators.`


### Items That Can be Improved 

  
* Enhance UI/UX and optimize app performance/
