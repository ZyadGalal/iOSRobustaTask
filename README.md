# Robusta iOS Task

Task Owner **Zyad Galal**.   
Technical Task for **Robusta**.

# Brief For Task

- Retrieve repositories from Github endpoint.
- Repo list include owner name, owner Image, repo name.
- Repo details include owner name, image, repo name, repo details, is private repo.
- downloading and cache images

# Architecture

 Task flow with MVVM clean architecture.
- View: subscribe to the viewModel publishers to update the UI and send user inputs to the ViewModel.
- Repo: responsible for business logic , get data from remote , convert DTO model to entity.
- ViewModel: contains view logic for preparing content for display (as received from the Repo) and dealing with user inputs (by requesting new data from the Repo).
- Entity: contains basic model objects used by the Repo.
- Router: contains navigation logic for describing which screens are shown in which order.




