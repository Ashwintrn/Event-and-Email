**Pre-Requisites**:
- Git, Docker

**How to run**:
- Clone the project
- Add API_KEY by entering it manually in the "docker-compose.yml" file. The file is present in the root source itself. In that File, navigate to the " source -> web -> environment " section and replace the "```INSERT YOU KEY```" with your _iterable-api-key_.
- Followed by that, Just run the "```docker-compose up```" command, the server should be active in your localhost. Proceed further with using the application. For further info, check the "_Workflows in our Application_" section.


**Workflows in our Application**:
- Creating a management system for users.
- User creates an account in our application.
- We make sure the user is authenticated.
- Since Iterable doesn't have any user creation API. we don't create it there, we create it only in our side.
- When "_Event A_" or "_Event B_" Button is clicked we use "```track your event```" in the Iterable Event API and track the events correspondingly.
- When we create an event it is stored with association to the users in our DB storage.
- We will only have these two events,and these events will be used by different users that log in and these events are tracked with "track your event" Iterable API.
- We assume Iterable tracks the event and the user, with "track your event" Iterable API for some analytical purpose.
- When "Event B Button" is created, we follow it with an email to the user.
- Email is sent via Iterable Email API.
