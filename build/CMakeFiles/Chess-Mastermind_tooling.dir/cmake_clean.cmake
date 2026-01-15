file(REMOVE_RECURSE
  "main/main.qrc"
  "main/qml/main.qml"
)

# Per-language clean rules from dependency scanning.
foreach(lang )
  include(CMakeFiles/Chess-Mastermind_tooling.dir/cmake_clean_${lang}.cmake OPTIONAL)
endforeach()
