# pseudoscript #

Transpile pseudo code into CoffeeScript/JavaScript.

It's kind of magic...



### Purpose ###
* Write scripts and programs in natural language "pseudo" code 
* Instructional language to teach non programmers how to *think* like a programmer



### Philosophy ###
* Another layer of abstraction which allows more right brain activity. Part of larger right brain computing project.
Human language more melodic than code and being able to modify the language itself brings great freedom.
* First crowdsourced language?
* Introduce unscientific subjectivity, like an I. For example `show me length of tree` = `console.log(tree.length);`
* Allow endless sub clauses with commas (show me length of tree, multiply by three, add four and bob's your uncle)
* Functional programming is much closer to natural language than procedural languages (implicit returns especially, see above)
* Alternative: take length of tree, multiply be three, add four and show me the result
* Implicit console.log? E.g. `take length of three, multiply by three and add four` =
`console.log add(multiply(tree.length, 3), 4)`



### Business case (if any...) ###
* Beautiful open source projects enable revenue through machine learning/deep learning, which adds yet another layer of abstraction (or rather tries to get computers to recognize this layer). All of my current projects are suitable for this kind of model (giterature -> teach computers how to write books, pseudoscript -> teach computers to program
* ALWAYS declare business intentions (if any). Tell people EXACTLY what you aim to achieve.



### CLI ###
Basic usage
```
pseudo <INPUT FILE> -d <DICTIONARY FILE> -o <OUTPUT FILE>
```
Piping
```
pseudo fisk.pseudo > fisk.coffee				# transpile into coffeescript
pseudo fisk.pseudo | coffee						# transpile into coffeescript and run
pseudo fisk.pseudo | coffee --compile			# transpile into javascript (via coffeescript)
```



### misc ###
* event handling with keyword "when" (to keep async philosophy)
- when the temperature exceeds 20, turn on the fan (set listener) 




### Thanks ###
I'm a dwarf standing on the shoulders of

* the coffeescript people
* etc...