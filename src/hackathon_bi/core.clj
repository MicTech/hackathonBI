(ns hackathon-bi.core
  (:require [clojure.java.io :as io]
            [clojure.data.csv :as csv]
            [clj-time.core :as t]
            [clj-time.coerce :as c]
            [cognitect.transit :as transit]
            [incanter.core :as i]
            [incanter.io :as iio])
  (:import [java.io File ByteArrayInputStream]))

(defn data [uri]
  (iio/read-dataset uri :delim \;))

(defn in [x] (ByteArrayInputStream. (.getBytes x)))
(defn reader [in] (transit/reader in :json))

(defn process [data]
  (->> data :rows
       (map #(transit/read (reader (in (:col2 %)))))
       (map (fn [x]
              (assoc x
                (str "uir_type_" (get x "uir_type"))
                (get x "uir_name"))))
       (map #(assoc % "country" "Czech republic"))
       (map (fn [x] (select-keys x ["country" "uir_type_address" "where" "what" "source_facility" "from" "size" "uir_type_city" "uir_type_city_part" "uir_type_street" "uir_type_urban_district" "uir_type_district" "uir_type_region"])))
       (mapv vals )))

(defn -main [& [in out]]
  (with-open [out-file (io/writer out)]
    (csv/write-csv out-file (process (data in)))))
