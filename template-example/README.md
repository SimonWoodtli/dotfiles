# Example of `chezmoi` template usage

`chezmoi` uses go text/template pkg and sprig pkg functions and some custom functions do handle templates.  
This file is just an example of things you can do with it.

## simple variable usage:

twittername=SimonWoodtliDev

## Arrays 

### Looping over Arrays

I speak:
 
* German 
 
* English 
 
* Chinese 
 
* Spanish 


Trimming White Space:

I speak: 
* German 
* English 
* Chinese 
* Spanish 


Sorting printed result alphabetically:

* Chinese
* English
* German
* Spanish


### Accessing Array Element

* select element 2 from language array: ***Chinese***
* with go text/template pkg: My first language is Swiss-German
* with sprig pkg: My first language is Swiss-German

### Count Array Elements

* amount of elements in language array: ***4***

### Differentiate Singular Plural Array Element(s)

* Hardcoded example: I speak 4 language(s)
* Dynamic example: I speak 4 languages

## Objects

### Looping over Objects:

You'll find me on:
* key: email value: simonwoodtli@posteo.net
* key: github value: https://github.com/SimonWoodtli
* key: homepage value: https://simonwoodtli.com
* key: linkedin value: https://linkedin.com
* key: name value: Simon D. Woodtli
* key: twitter value: SimonWoodtliDev



## Math

* print random number from 0-4: ***1***
* pick random language from language array: ***Chinese***

## Text Manipulation

* with nested functions indent:     Success isn't determined by how many times you win, but by how you play the
    week after you lose. -- Pele
* with pipes indent::     Success isn't determined by how many times you win, but by how you play the
    week after you lose. -- Pele

--------------------------------------------------------------------------------
  You have the right to remain silent. Anything you say will be misquoted then
  used against you.
--------------------------------------------------------------------------------

## Conditionals, Variable Assignment & Initializing

* Example 1: (Generated on linux-fedora)
* Example 2: (Generated on some Linux Distro)


## Date

* Current Timzone Timestamp: 12:24 on Mar 14 2023
* Current Timezone Timestamp: 2023-03-14 12:24
* UTC Timezone Timestamp: 2023-03-14 17:24
* UTC ISO Timestamp: 2023-03-14T17:24:01Z

## More Useful functions

1. `quote` — wrap the input in quotation marks and escape any quotation marks within the string.
1. `squote` — same as quote but uses single quotes, also known as apostrophes.
1. `js` — convert the passed value to a valid JavaScript variable definition.
1. `toJson` — convert the passed value to a valid JSON string.
1. `toPrettyJason` — convert the passed value to nicely formatted JSON string.
1. `default` —  to set a simple default value
1. `coalesce` — to set a default value, from a list of given values it accepts the first one that is not empty
1. `ternary` — takes two values, and a test value, if test is true first value gets returned otherwise second value. similar to the c ternary operator

When it comes to shells, I'm oldschool!

Related:

* <https://pbs.bartificer.net/pbs123.html>
* <https://pbs.bartificer.net/pbs124.html>
* <https://pbs.bartificer.net/pbs125.html>
* <https://pkg.go.dev/text/template#section-documentation>
* <https://masterminds.github.io/sprig/>
* <https://www.chezmoi.io/reference/templates/>
