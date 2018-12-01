(def inputs *command-line-args*)
(def parsedInputs (map read-string inputs))
(println (reduce + parsedInputs))
