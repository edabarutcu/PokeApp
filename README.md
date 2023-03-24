# PokemonList-AnalyticaHouseAssignment




- A simple iOS app developed using UIKit and without the use of XIB and Storyboard.

- Development choises: I decided to not use any external framework because I preferred to develop the code alone.

- I decided to get very close to a MVVM (Model View Viewmodel) approach as an architectural pattern. 

- The application has two screens: the first one is a table view with a list of Pokemon, the second is a detail screen of the pokemon that you tapped on the first screen.

- Coordinator: I decided to use a Coordinator to move between my views.

- The application coordinator instanciate the UINavigationController and the root view controller; meanwhile the ViewControllerCoordinator pushes the PokemonDetailsView.

- For the first screen I used a simple table view and I implemented an infinite scroll: 40 items are loaded at a time.. 

- Using the Uitableviewdatasourceepreftching I was able to set the conditions so that new data can be fetched. 

- To take the data that populated my application I used the API Rest services offered by the site pokeapi.co . 

- In particular I used only 2 services: the first gives me the list of all pokemon (divided into pages to implement the infinite scroll and then load the pages only when required) the second instead gives me all the pokemon's data.

- Fetching and parsing operations (from JSON to our data structure) are all entrusted to the Parser.

-  is responsible for taking the data and converting it into our data structure.
 
- I decided to entrust the responsibility for navigation between the various screens, and their actual creation, to the Coordinator.

- The ApplicationCoordinator is the one that creates the root view, inserting it in an UINavigationController. 

- The ViewControllerCoordinator instead, is responsible for instantiate PokemonDetailsViewController tap on the given cell.
