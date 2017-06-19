#!/usr/bin/env bash

cd data
tar -cvzf ../module/data.tar.gz *
cd ..

cd module

# Notify the current user if they try to add relationships to the current
# context without having saved it first
string="
  newTab(\"Context_Group_Relationship\", true);"
replacement="
  String tabgroup = \"Context_Group\";
  if (isNull(getUuid(tabgroup))){
    showToast(\"{You_must_save_this_tabgroup_first}\");
    return;
  }
  $string"
perl -0777 -i.original -pe "s/\\Q$string/$replacement/igs" ui_logic.bsh

# Notify the current user if they try to add relationships to the current
# context without having saved it first
string="
  newTab(\"Relationship\", true);"
replacement="
  String tabgroup = \"Context\";
  if (isNull(getUuid(tabgroup))){
    showToast(\"{You_must_save_this_tabgroup_first}\");
    return;
  }
  $string"
perl -0777 -i.original -pe "s/\\Q$string/$replacement/igs" ui_logic.bsh

# What this regex does is match everything in the function definition, including
# the name, parens and opening curly brace, but excluding the closing curly
# brace. This allows us to stick a line right before the closing curly brace.
string="(new([a-zA-Z]+)\\(\\){((?!\\n}).)+)"
replacement="\\1
  inherit\\2Fields();"
perl -0777 -i.original -pe "s/$string/$replacement/igs" ui_logic.bsh

rm ui_logic.bsh.original
