
context("ISO 8601 moment.js")

## http://momentjs.com/docs/#/parsing/string/
## Slightly modified, because it is _not_ allowed to
## have whitespace before the final Z.
test_that("Examples from moment.js", {

  tests <- read.table(stringsAsFactors = FALSE, header = FALSE,
                      strip.white = TRUE, row.names = NULL, sep = "|",
                      textConnection("
    2013-02-08              | 2013-02-08T00:00:00+00:00
    2013-02-08T09           | 2013-02-08T09:00:00+00:00
    2013-02-08 09           | 2013-02-08T09:00:00+00:00
    2013-02-08T09:30        | 2013-02-08T09:30:00+00:00
    2013-02-08 09:30        | 2013-02-08T09:30:00+00:00
    2013-02-08T09:30:26     | 2013-02-08T09:30:26+00:00
    2013-02-08 09:30:26     | 2013-02-08T09:30:26+00:00
    2013-02-08T09:30:26.123 | 2013-02-08T09:30:26+00:00
    2013-02-08 09:30:26.123 | 2013-02-08T09:30:26+00:00
    2013-02-08T09:30:26Z    | 2013-02-08T09:30:26+00:00
    2013-02-08 09:30:26Z    | 2013-02-08T09:30:26+00:00
    2013-W06-5              | 2013-02-08T00:00:00+00:00
    2013-W06-5T09           | 2013-02-08T09:00:00+00:00
    2013-W06-5 09           | 2013-02-08T09:00:00+00:00
    2013-W06-5T09:30        | 2013-02-08T09:30:00+00:00
    2013-W06-5 09:30        | 2013-02-08T09:30:00+00:00
    2013-W06-5T09:30:26     | 2013-02-08T09:30:26+00:00
    2013-W06-5 09:30:26     | 2013-02-08T09:30:26+00:00
    2013-W06-5T09:30:26.123 | 2013-02-08T09:30:26+00:00
    2013-W06-5 09:30:26.123 | 2013-02-08T09:30:26+00:00
    2013-W06-5T09:30:26Z    | 2013-02-08T09:30:26+00:00
    2013-W06-5 09:30:26Z    | 2013-02-08T09:30:26+00:00
    2013-039                | 2013-02-08T00:00:00+00:00
    2013-039T09             | 2013-02-08T09:00:00+00:00
    2013-039 09             | 2013-02-08T09:00:00+00:00
    2013-039T09:30          | 2013-02-08T09:30:00+00:00
    2013-039 09:30          | 2013-02-08T09:30:00+00:00
    2013-039T09:30:26       | 2013-02-08T09:30:26+00:00
    2013-039 09:30:26       | 2013-02-08T09:30:26+00:00
    2013-039T09:30:26.123   | 2013-02-08T09:30:26+00:00
    2013-039 09:30:26.123   | 2013-02-08T09:30:26+00:00
    2013-039T09:30:26Z      | 2013-02-08T09:30:26+00:00
    2013-039 09:30:26Z      | 2013-02-08T09:30:26+00:00"
  ))

  apply(tests, 1, function(x) {
    d <- format_iso_8601(parse_iso_8601(x[1]))
    expect_equal(d, unname(x[2]))
  })

})

context("ISO 8601 Pelago")

## http://www.pelagodesign.com/blog/2009/05/20/
## iso-8601-date-validation-that-doesnt-suck/
test_that("Pelago examples", {

  tests <- read.table(stringsAsFactors = FALSE, header = FALSE,
                      strip.white = TRUE, row.names = NULL, sep = "|",
                      textConnection("
    2009-12T12:34               | 2009-12-01T12:34:00+00:00
    2009                        | 2009-01-01T00:00:00+00:00
    2009-05-19                  | 2009-05-19T00:00:00+00:00
    20090519                    | 2009-05-19T00:00:00+00:00
    2009123                     | 2009-05-03T00:00:00+00:00
    2009-05                     | 2009-05-01T00:00:00+00:00
    2009-123                    | 2009-05-03T00:00:00+00:00
    2009-222                    | 2009-08-10T00:00:00+00:00
    2009-001                    | 2009-01-01T00:00:00+00:00
    2009-W01-1                  | 2008-12-29T00:00:00+00:00
    2009-W51-1                  | 2009-12-14T00:00:00+00:00
    2009-W511                   | 2009-12-14T00:00:00+00:00
    2009-W33                    | 2009-08-10T00:00:00+00:00
    2009W511                    | 2009-12-14T00:00:00+00:00
    2009-05-19 00:00            | 2009-05-19T00:00:00+00:00
    2009-05-19 14               | 2009-05-19T14:00:00+00:00
    2009-05-19 14:31            | 2009-05-19T14:31:00+00:00
    2009-05-19 14:39:22         | 2009-05-19T14:39:22+00:00
    2009-05-19T14:39Z           | 2009-05-19T14:39:00+00:00
    2009-W21-2                  | 2009-05-19T00:00:00+00:00
    2009-W21-2T01:22            | 2009-05-19T01:22:00+00:00
    2009-139                    | 2009-05-19T00:00:00+00:00
    2009-05-19 14:39:22-06:00   | 2009-05-19T20:39:22+00:00
    2009-05-19 14:39:22+0600    | 2009-05-19T08:39:22+00:00
    2009-05-19 14:39:22-01      | 2009-05-19T15:39:22+00:00
    20090621T0545Z              | 2009-06-21T05:45:00+00:00
    2007-04-06T00:00            | 2007-04-06T00:00:00+00:00
    2007-04-05T24:00            | 2007-04-05T00:00:00+00:00
    2010-02-18T16:23:48.5       | 2010-02-18T16:23:48+00:00
    2010-02-18T16:23:48,444     | 2010-02-18T16:23:48+00:00
    2010-02-18T16:23:48,3-06:00 | 2010-02-18T22:23:48+00:00
    2010-02-18T16:23.4          | 2010-02-18T16:23:24+00:00
    2010-02-18T16:23,25         | 2010-02-18T16:23:15+00:00
    2010-02-18T16:23.33+0600    | 2010-02-18T10:23:19+00:00
    2010-02-18T16.23334444      | 2010-02-18T16:14:00+00:00
    2010-02-18T16,2283          | 2010-02-18T16:13:41+00:00
    2009-05-19 143922.500       | 2009-05-19T14:39:22+00:00
    2009-05-19 1439,55          | 2009-05-19T14:39:33+00:00"
  ))

  apply(tests, 1, function(x) {
    d <- format_iso_8601(parse_iso_8601(x[1]))
    expect_equal(d, unname(x[2]))
  })

})

context("ISO 8601 Pelago non-matching")

test_that("Pelago non-matching", {

  tests <- read.table(stringsAsFactors = FALSE, header = FALSE,
                      strip.white = TRUE, row.names = NULL, sep = "|",
                      textConnection("
    200905
    2009367
    2009-
    2007-04-05T24:50
    2009-000
    2009-M511
    2009M511
    2009-05-19T14a39r
    2009-05-19T14:3924
    2009-0519
    2009-05-1914:39
    2009-05-19 14:
    2009-05-19r14:39
    2009-05-19 14a39a22
    200912-01
    2009-05-19 14:39:22+06a00
    2009-05-19 146922.500
    2010-02-18T16.5:23.35:48
    2010-02-18T16:23.35:48
    2010-02-18T16:23.35:48.45
    2009-05-19 14.5.44
    2010-02-18T16:23.33.600
    2010-02-18T16,25:23:48,444"
  ))

  apply(tests, 1, function(x) {
    d <- format_iso_8601(parse_iso_8601(x[1]))
    expect_equal(d, as.POSIXct(NA))
  })

})

context("ISO week dates")

test_that("Exotic ISO week dates are OK", {

  tests <- read.table(stringsAsFactors = FALSE, header = FALSE,
                      strip.white = TRUE, row.names = NULL, sep = "|",
                      textConnection("
    2009-W01-1              | 2008-12-29T00:00:00+00:00
    2009-W53-7              | 2010-01-03T00:00:00+00:00
    2013-W06-5              | 2013-02-08T00:00:00+00:00"
  ))

  apply(tests, 1, function(x) {
    d <- format_iso_8601(parse_iso_8601(x[1]))
    expect_equal(d, unname(x[2]))
  })

})
