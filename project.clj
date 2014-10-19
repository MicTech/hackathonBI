(defproject sandbox "0.1.0-SNAPSHOT"
  :description "FIXME: write description"
  :url "http://example.com/FIXME"
  :license {:name "Eclipse Public License"
            :url "http://www.eclipse.org/legal/epl-v10.html"}
  :dependencies [[org.clojure/clojure "1.7.0-alpha2"]
                 [org.clojure/data.csv "0.1.2"]
                 [com.cognitect/transit-clj "0.8.259"]
                 [incanter "1.5.5"]
                 [clj-time "0.8.0"]]
  :main hackathon-bi.core
  :jvm-opts ["-Xmx6g"])
