# Smurf

This will be a simple terminal application built using ratatouille which helps you generate code names for your projects.

Terminal UI app that allows you to select a random code name for a project, as well as allows you to create lists of code names to choose from by browsing topics with their associated code names.

    -------------------------------------------------------------------
                          _______________________
                          | random code name    |
                          _______________________

      ________________________           ______________________________
      | list of topics |           | list of code names for topic |
      | list of topics |           | list of code names for topic |
      | list of topics |           | list of code names for topic |
      | list of topics |           | list of code names for topic |
      | list of topics |           | list of code names for topic |
    -------------------------------------------------------------------

- [X] Create DB
  - [X] Code Names belongs to Topic
  - [X] Topic has many Code Names
- [X] IEX App
  - [X] Create new topic
  - [X] Create new code names for topic
  - [X] Get list of topics
  - [X] Get list of all code names
  - [X] Get list of code names for topic
  - [X] Delete code name
  - [X] Delete Topic -> deletes all code names for topic
  - [X] Update code name
  - [X] Update topic name
- [.] Terminal UI
  - [X] Display random code name
  - [X] Display new random code name with spacebar
  - [ ] Display random code name from topic
  - [X] Display list of topics
  - [.] Display list of code names for topic
  - [X] Create new topic
  - [X] Create new code names for topic
    - [X] can backspace while typing code name
  - [X] Delete code name
    - [ ] Are you sure? y/n -> won't do?
  - [X] Delete Topic -> deletes all code names for topic
    - [ ] Are you sure? y/n -> won't do?

notes:
followed this tutorial: [ ratatouille_todo_app ]( https://dev.to/katafrakt/writing-tui-with-ratatouille-337g )
