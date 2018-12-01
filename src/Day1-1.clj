(def inputs *command-line-args*)
(def parsed-inputs (map read-string inputs))
(println (reduce + parsed-inputs))
