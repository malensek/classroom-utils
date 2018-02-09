# classroom-utils

Scripts for working with Github Classroom.

## Usage

To download assignments, use the pull-assignments script. In this example, we'll download Homework 1 (hw1) from the usf-cs220-sp18 Github organization. This will check out all repos that begin with 'hw1.'

```
./pull-assignments -a hw1 -o usf-cs220-sp18 -t ~/Documents/my_token.txt -u ~/Documents/user-map-220.txt
```

You'll also need to provide your Github token and (optionally) a user map. The Github token allows the script to download all the repos without constantly prompting for your password. To set one up, go to `Github Settings > Developer Settings > Personal Access Tokens` and generate a new token. You will need to check the entire 'repo' category as well as 'read:user' and 'user:email'. Save the token in a file (for example, `token.txt`).

The user map is a plain text file that maps Github usernames to Canvas/Institution usernames. The format is:
```
github-user-name      canvas-user-name
```
(separated by whitespace)

Assignments will be cloned to a directory called `working-dir`.

You can run the grading script on each repo with:
```
./grade-all hw1 ./demo-script
```
This will execute the commands in `demo-script` on all the repos. You'll want to check the output stored in `grade-info.md` files. If you just want an empty grade-info.md file, use the `blank-grade` script. This is good for assignments that can't be auto-graded by a script.

Finally, when the changes are ready, you can push them back to Github with:
```
./push-grades
```
