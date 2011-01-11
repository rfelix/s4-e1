# rmu4-e1: TV Show Episode Name CLI

## Description

Given a tv show, season, and episode number, this tool will obtain the
episode's title. An episode title can also be specified and in that case this
tool will return the season and episode numbers.

## Usage Examples

    $ tv_show "Fringe" --season 3 --episode 10
    Firefly

    $ tv_show "Fringe" --season 3 --title "abducted"
    Season 3 Episode 7

    $ tv_show "Fringe" --season 2
    Season 2 Episode 1 A New Day in the Old Town
    Season 2 Episode 2 Night of Desirable Objects
    (...)
    Season 2 Episode 21 Northwest Passage
    Season 2 Episode 22 Over There: Part 1
    Season 2 Episode 23 Over There: Part 2

    $ tv_show "Fringe" --title "night"
    Season 1 Episode 18
    Season 2 Episode 2

