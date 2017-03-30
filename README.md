# WebCalculator
A web calculator using RESTful API principles in a Haskell environment

## Using the calculator

In order to setup this application you must have stack, yesod and cabal installed on your machine.

To launch type the following into the terminal:

```
> cd WebCalculator
> stack build
> stack exec webcalculator
```
This will intialise the web application on ```localhost:3000```, and will default you to the / route.

These are the commands allowed by the api:


```
/add/Int/Int
/subtract/Int/Int
/multiply/Int/Int
/divide/Int/Int
/calculations
```
ex.
```
/add/5/10
```


