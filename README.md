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
  - [ ] Display random code name
  - [ ] Display random code name from topic
  - [ ] Display list of topics
  - [ ] Display list of code names for topic
  - [ ] Create new topic
  - [ ] Create new code names for topic
  - [ ] Delete code name
    - [ ] Are you sure? y/n
  - [ ] Delete Topic -> deletes all code names for topic
    - [ ] Are you sure? y/n

notes:
followed this tutorial: [ ratatouille_todo_app ]( https://dev.to/katafrakt/writing-tui-with-ratatouille-337g )
