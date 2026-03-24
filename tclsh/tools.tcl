
proc suspend {} {
  global *
  while { 1 } {
    set cmd [gets stdin]
    if { "$cmd" == "resume" } {
      break
    }
    eval $cmd
  }
}

