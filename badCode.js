// badCode.js

var name = "John"

function sayHello(name) {
    if(name){
        console.log("Hello " + name)
    }
    else {
        console.log("Hello stranger")
    }
}

sayHello()
sayHello("Alice")

const numbers = [1,2,3,4,5]
for (var i = 0; i < numbers.length; i++) {
  console.log(numbers[i])
}

function unusedFunction() {
    return "This function is never used"
}

eval("console.log('This is unsafe')")

const obj = {
  foo: "bar",
  foo: "baz"  // Duplicate key
}
