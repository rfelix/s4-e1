# rmu4-e1: TV Show Episode Name CLI

## Description

Given a tv show, season, and episode number, this tool will obtain the
episode's title. An episode title can also be specified and in that case this
tool will return the season and episode numbers.

## Usage Examples

    $ tv_show "Fringe" --season 3 --episode 10
    Firefly

    $ tv_show "Fringe" --season 3 --title "abducted"
    7. The Abducted

    $ tv_show "Fringe" --season 2
    1. A New Day in the Old Town
    2. Night of Desirable Objects
    (...)
    21. Northwest Passage
    22. Over There: Part 1
    23. Over There: Part 2

    $ tv_show "Fringe" --title "night"
    1.18. Midnight Episode 18
    2.2. Night of Desirable Objects

