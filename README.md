# README
This is the API backend for lov3time mobile app. A dating app that don't try to
make you lost your time by making more easy to connect with people.

You can read the [vision here](VISION.md)

## DEVELOPMENT
This repo has a `docker-compose.yml` where goes Rails, PostgreSQL and Redis.
Normally everything run inside Docker by running `docker-compose up`


## TESTS
I want to run tests with `Guard` and there's an issue with Guard running
inside Docker so for that reason I run Rails from outside but connecting to the
PostgreSQL that's in the container. To test this connection you can use `psql`.
In my case I have `PostgreSQL` in my Mac OS X running and also a standalone
version of `psql` which is installed this way:
```
brew install libpq
```
But then I have an alias called `spsql` to use it defined in my dotfiles.

