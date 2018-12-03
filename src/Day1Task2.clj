(def inputs *command-line-args*)
(def parsed-inputs (map read-string inputs))
(def infinite-stream (flatten (repeat parsed-inputs)))
(defn first-duplicate-index [coll]
  (reduce
    (fn [acc [idx x]]
      (if-let [v (get acc x)]
        (reduced (conj v idx))
        (assoc acc x [idx])
      )
    )
    {} (map-indexed #(vector % %2) coll))
)

(def duplicate-index (last (first-duplicate-index (reductions + infinite-stream))))
(println (last (take (+ duplicate-index 1) (reductions + infinite-stream))))
