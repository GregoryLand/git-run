# git run

`git run` runs commands in git revisions

## Getting started

Install git run through Rubygems:

``` console
$ gem install git-run
```
    
After installing, you'll have the `git run` subcommand for `git`:

``` console
$ git run
Usage: git run [options] <revision> <command>
    -h, --help                       Show this message
```

Time to try it out. Let's say you have passing test:

``` console
$ ruby test.rb
.....
```
    
You want to know if the test was passing in ealier revision, so you use `git run` to quickly switch to the revision and run the test:
  
``` console
$ git run ad1211 ruby test.rb
...FF
```

Now you know.
