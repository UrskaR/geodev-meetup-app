# sample Shiny app


Assuming you have all the packages installed*, starting with `shiny`, you can run this piece of code and you're off.
```r
shiny::runGitHub(repo = "geodev-meetup-app", username = "zkuralt")
```

`*` you can install packages listed in the [`app.R`](https://github.com/zkuralt/geodev-meetup-app/blob/master/app.R) using something along the lines of

```
install.packages(c("shiny", "shinydashboard", "leaflet", "shinyjs"))
```
