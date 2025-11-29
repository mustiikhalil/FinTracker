bazel query --notool_deps --noimplicit_deps "deps(//:macos)" --output graph | dot -Tpng > output.png
