(TeX-add-style-hook "CompteRendu"
 (lambda ()
    (TeX-add-symbols
     "verbatiminput")
    (TeX-run-style-hooks
     "verbatim"
     "minted"
     ""
     "styles"
     "page_garde"
     "partie_introduction"
     "partie_description_hdfs"
     "partie_description_mapreduce"
     "partie_pre_requis_config"
     "partie_installation"
     "partie_installation2"
     "parties_exemples"
     "partie_conclusion")))

