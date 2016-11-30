#Gilded Rose tech test

##Running the program
```
$ git clone https://github.com/James-SteelX/gilded_rose_ruby.git
$ cd gilded_rose_ruby
$ bundle
```
To run the tests use -
```
$ rspec
```
##Brief
I was tasked with refactoring and extending an existing code base for the Gilded Rose.

##Approach
I used Ruby and Rspec for this task. As it didn't come with any tests my first port of call was to write a test suite based on the existing (working) code. This made the refactor infinitely easier and a less daunting task. I decided to extract all the different product types into separate methods and iterate through the array just checking for a matching string. So as not to clutter up the item_check method I further extracted the strings into constants. Moving everything to separate methods makes it easier (I believe) to add more items in at a later date since you'd just need to write one method and add two lines to the item_check method.
