# pseudoscript #

Transpile your pseudo code to CoffeeScript and JavaScript.

It's kind of magic...

### pseudo - the new sudo ###
* pseudo sounds like "SUDO" - GET IT! Synchronicities ahoy!
* sudo is magic

### misc ###
* event handling with keyword "when" (to keep async philosophy)
- when the temperature exceeds 20, turn on the fan (set listener) 

 

### Uses ###
* Write code in your native language
* Educational

### Philosophy ###
* Another layer of abstraction which allows more right brain activity. Part of larger right brain computing project. Human language more melodic than code and being able to modify the language itself brings even greater freedom.
* First crowdsourced language?
* Introduce unscientific subjectivity, like an I. console.log(tree.length); -> show me length of tree
* Allow endless sub clauses with commas (show me length of tree, multiply by three, add four and bob's your uncle)
* Functional programming is much closer to natural language (implicit returns especially, see above)
* New attempt: take length of tree, multiply be three, add four and show me the result
* (implicit console.log) take length of three, multiply by three and add four:
console.log add(multiply(tree.length, 3), 4)


### Business ###
* Being allowed to create beautiful open source things makes revenue through deep learning possible. Works for giterature, pseudoscript, deepsource... all these ideas.




### CLI ###
```
pseudo <INPUT FILE> -d <DICTIONARY FILE> -o <OUTPUT FILE>
```

### Examples ###
```
# Dictionary (cson)
swedish:
  "for": "för varje"
  "in": "i"
  "visa": "console.log"

# PseudoScript (Swedish)
för varje fisk i sjön
  visa fisk.art
  
# Generated CoffeScript
for fisk in sjön
  console.log fisk.art

# Generated JavScript
for (i = 0, len = sjön.length; i < len; i++) {
    fisk = sjön[i];
    console.log(fisk.art);
  }
```

### Works on ###

Flow controllers such as 'if', 'for'

Even works on variables, e.g.
```
# Dictionary 
dict =
  "for": "for every"
  "theLake": "the lake"
  "console.log": "show me"
  
# PseudoScript
for every fish in the lake
  show me fish.species
  
# Generated CoffeeScript
for fish in lake
  console.log fish.species
```



### Thanks ###
I'm a dwarf standing on the shoulders of

* coffeescript people