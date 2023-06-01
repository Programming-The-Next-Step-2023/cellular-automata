# livelycells
An R Shiny App for Conway´s Game of Life  
[click here to play it in your browser](<https://vincentott.shinyapps.io/livelycells/>)

## Description
This is an R package which contains an R Shiny App for
[Conway´s Game of Life](<http://wikipedia.org/wiki/Conway's_Game_of_Life>).  
<br>
<br>
Rules:  
1. A live cell with two or three live neighbours survives - otherwise it dies.  
2. A dead cell with three live neighbours becomes a live cell.
<br>
<br>
At time point zero, the player uses their mouse to click some cells to life.  
Then, the cells evolve over time and show all sorts of interesting behavior.  
There are also preset patterns which can be loaded.


# Dependencies, Credits, Copyright
Aside from shiny, livelycells has no dependencies.  
However, this app was built with the help of code under the MIT license from the
[pixeltrix package](<http://github.com/matt-dray/pixeltrix>) by [Matt Dray](<http://matt-dray.com/>).
