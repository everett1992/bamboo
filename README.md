# Bamboo

Bamboo is a simple scaffolding program designed to be simpler than yeoman's
yo.

## Thoughts

A scaffold is a directory in the scaffolds directory
When a project is created with a scaffold all of the files in the
scaffold are copied to the new projects directory.
Variables within the scaffols are replaced with values taken from the project's
name, command line options, user prompts, and global settings.

## Bamboo Variables

Like handlebars expressions within `{{` and `}}` marks will be replaced with
values from the bamboo env. I think I'll use `_{` and `}_` to mark variables
to replace.

Why I chose `_{var}_`
- Expressions can appear in filenames so charecters used must
  be legal in filenames. Preferably without excaping the charectres first.
  `_`, `{`, and `}` could be used in zsh, and bash without escaping or
   qouting when I tested them. `-` worked, but programs tried to interperet
   the following `{` as a command flag.

- Bamboo could be used to scaffold many different types of projects, so it shouldn't
  use existing tags like `<var>` or `{var}`.

- Prefer charecters that imply direction `[var]` verse `|var|`
