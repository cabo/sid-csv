# SID CSV conversion utility

This little tool provides for conversion between [YANG-SID][core-sid]
files as used by [YANG-CBOR][RFC9254] and corresponding human-readable
CSV files.

[![Gem Version](https://badge.fury.io/rb/sid-csv.svg)](https://badge.fury.io/rb/sid-csv)

[core-sid]: https://www.ietf.org/archive/id/draft-ietf-core-sid-20.html

## Installation

`gem install sid-csv`

## Formats

sid-csv knows the following formats:

* .sid: sid file (JSON) as defined in [draft-ietf-core-sid][core-sid]
* .csv: CSV file as defined in [RFC4180][]

[RFC9254]: http://rfc-editor.org/rfc/rfc9254
[RFC8610]: http://rfc-editor.org/rfc/rfc8610
[RFC4180]: http://rfc-editor.org/rfc/rfc4180

Sources and targets are defined by `-f csv`, `-t csv` (default: `sid`).

## Command line utilities

* `sid-csv -tcsv foo.sid > foo.csv`
* `sid-csv -fcsv foo.csv > foo.sid`

Output is to stdout, input from one or more files given as command line
arguments (use `-` for standard input).
