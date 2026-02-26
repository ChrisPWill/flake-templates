# Flake Templates

I intend these to serve as a set of sane and clean templates for starting new projects.
I'll go back and update these as I discover cleaning ways of setting up code.

## Usage (typical)

1. Optionally set up a new repo with your preferred VCS (I prefer jujutsu, so `jj git init --colocate` is my goto command)
1. Run:
    ```sh
    nix flake init -t github:chrispwill/flake-templates#<template-name>
    ```
1. ???
1. PROFIT
