# db-perm-gen

Permission generator for Database users.

This is a very small utility that you can use to generate user passwords.
Currently it only works with PostgreSQL, but it should be easy to add any DB with a similar
permission model.
It is designed to have pluggable backends, but right now it just supports
* [biscuit](https://github.com/dcoker/biscuit), a file encrypted with AWS KMS
* plain text

You should be able to create a single command PostgreSQL permission generator on top of these commands.


## Usage

You will need to setup biscuit.

    export BISCUIT_LABEL=pgpass
    biscuit kms init -f dbpass.yml

For each user run the user generator.

    ./pg/user.sh biscuit an_existing_pg_role db_user_to_create dbpass.yml aws_user

This will output a SQL statement that you can run with psql.
And it will store the db user/password in the biscuit storage backend.
For plain text

    ./pg/user.sh plain-text an_existing_pg_role db_user_to_create dbpass.txt

Additionally there is a script to generate SQL permissions for a role.

    ./role-read-only.sh role [schema]
    ./role-write.sh role [schema]


## Reproducible Environment

There is a docker image to ensure a reproducible environment, but you can look at the Dockerfile to see the very small amount of required tooling.

Running with docker involves first building the image

    ./build.sh

Then prefix any of your commands with `./docker.sh`. e.g.

    ./docker.sh echo hello world
