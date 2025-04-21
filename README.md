# little-lemon


## data modeling
    use draw.io

## implementing the model (DDL physical schema)
    use data grip

## data population
    at the end: fully dump the database
    mysqldump -u user -p --routines --triggers --events --databases little_lemon > little_lemon.sql


## use python as a data client
    through it you can create prepared statements and procedures, queries and so on

## commit to this repository every time you modify the diagrams or python code