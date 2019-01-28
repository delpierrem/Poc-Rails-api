## first test rails api
  with:
  - Json-api spec / Custom spec
  - Trailblazer
  - Sequel
  - Rswag

## Requirements

 * docker
 * docker-compose
 * ruby (rbenv / rvm)
 * Headers C pour postgresql

### Install postgresql dev files

**Ubuntu**

```bash
$ sudo apt install libpq-dev
```

**Mac OS**

```bash
$ brew install libpq
```

## Setup

```bash
$ cd /path/to/project
$ ./setup.sh
```

If there is a `pg` error on `bundle install`, run :

```bash
$ gem install pg -v '<version>' --source 'https://rubygems.org' -- --with-pg-dir=/usr/local/opt/libpq
$ ./setup.sh
```
