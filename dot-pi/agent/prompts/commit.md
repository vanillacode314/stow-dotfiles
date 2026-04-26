## Goal
Generate changeset description based on output of `jj diff --color=never --no-pager`

## Format
- The title of the commit should say what the change was
- The rest should explain why the change was made and the rationale behind it, and in the end it can include a comprehensive list of changes if the title wasn't enough

## Rules
- Ask user for context if you need details
- Should follow conventional commits
- Confirm before updating the changeset description

## Workflow
- Generate a description
- Use `jj desc -m '<message here>'` to update the description after the user confirms
