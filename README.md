# HaskellLikeFizz

Swift implement of Haskell Fizz buzz from youtube: [Haskell for JavaScript programmers - YouTube](https://www.youtube.com/watch?v=pUN3algpvMs&ab_channel=Tsoding)

[![](https://i.ytimg.com/an_webp/pUN3algpvMs/mqdefault_6s.webp?du=3000&sqp=CIbPnfsF&rs=AOn4CLC-kuhM93zT3e45m4Y9IKh9gq7Yaw)](https://www.youtube.com/watch?v=pUN3algpvMs&ab_channel=Tsoding)

## Principles

> Pure functional programming is about composing pure functions.

1. No Loops
2. No ifs 
3. Function is Single Return
4. No side-effects 
5. No Assignments in Function
6. No arrays
7. Only Functions with 0 or 1 arguments

## Result:

```swift
list2array(map(fizzbuzz(_:))(range(1)(20)))
/*
[
   "1", 
   "2",
   "fizz",      //  3 is multiple 3
   "4",
   "buzz",      //  5 is multiple 5 
   "fizz",      //  6 is multiple 3
   "7",
   "8", 
   "fizz",      //  9 is multiple 3
   "buzz",      // 10 is multiple 5
   "11", 
   "fizz",      // 12 is multiple 3
   "13",
   "14",
   "fizzbuzz",  // 15 is multiple 3 and 5
   "16",
   "17",
   "fizz",      // 18 is multiple 3
   "19",
   "buzz"       // 20 is multiple 5
]
*/
```
