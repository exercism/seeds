# Seeds

Exercism seed data generator.

Developing locally can be a challenge without data.

Placeholder data is often not varied enough or interesting enough
to run into weird edge-cases.

In order to create fake but real-ish data, this project:

* creates fake users with nice avatars from the [uifaces](http://uifaces.com/)
  project
* uses real (random) code examples from exercism.
* [wip] fake nitpicks generated from markov chains using real exercism comments.

## Usage

At the moment, most of this can only be used if you have access to the a copy of
the exercism.io production database.

It also makes a ton of assumptions about database names, usernames, etc.

If you have access, this will fetch and restore a dump:

```
heroku pgbackups:capture
curl -o latest.dump `heroku pgbackups:url`
pg_restore --verbose --clean --no-acl --no-owner -h localhost -U exercism -d exercism_development latest.dump
echo "UPDATE users SET email=NULL" | psql -d exercism_development
```

To generate the basic seed data, run:

```
rake seeds:generate
```

This creates all the data, using a placeholder for comments.

### Generating exercismarkov nitpicks

Extract all the exercism comments to text files:

```
rake extract:nitpicks
```

Then get a build of the [exercism/arkov](https://github.com/exercism/arkov) project to create
the underlying data structures that the nitpicks can be created from:

```
rake generate:markov
```

## TODO

Must finish the part where it generates the fake comments and stores them back in place of the
nitpick placeholder.

