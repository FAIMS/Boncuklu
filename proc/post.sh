#!/usr/bin/env bash

cd data
tar -cvzf ../module/data.tar.gz *
cd ..

cd module

# Delete autogenerated onClickUserLogin definition.
# Overriden in "logic/user-tab-validation.bsh".
string="
loadContextFrom(String uuid) {
  String tabgroup = \"Context\";
  setUuid(tabgroup, uuid);
  if (isNull(uuid)) return;

  showTabGroup(tabgroup, uuid);
}"
replacement=""
perl -0777 -i.original -pe "s/\\Q$string/$replacement/igs" ui_logic.bsh

# Delete autogenerated onClickUserLogin definition.
# Overriden in "logic/user-tab-validation.bsh".
string="
onClickUserLogin () {
  \/\/ TODO: Add some things which should happen when this element is clicked
  newTab(\"Control\", true);
}"
replacement=""
perl -0777 -i.original -pe "s/\\Q$string/$replacement/igs" ui_logic.bsh


# Delete autogenerated onClickContextTextureHelper definition.
# Overriden in "logic/texture-helper.bsh".
string="
onClickContextSoilTextureHelper () {
  \/\/ TODO: Add some things which should happen when this element is clicked
  newTab(\"Context\/Soil_Texture_Helper\", true);
}"
replacement=""
perl -0777 -i.original -pe "s/\\Q$string/$replacement/igs" ui_logic.bsh

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

# I hate this regex so much. Anyway, what it does is match everything in the
# function definition, including the name, parens and opening curly brace, but
# excluding the closing curly brace. This allows us to stick a line right before
# the closing curly brace.
string="(new([a-zA-Z]+)\\(\\){((?!\\n}).)+)"
replacement="\\1
  inherit\\2Fields();"
perl -0777 -i.original -pe "s/$string/$replacement/igs" ui_logic.bsh

string="(newContext\\(\\){((?!\\n}).)+)"
replacement="\\1
  setContextDateOpened();"
perl -0777 -i.original -pe "s/$string/$replacement/igs" ui_logic.bsh

# The following 3 replacements are all to make the labels consistent for buttons
# used to attach sketches
string="Button_FileAttach=Attach File"
replacement="Button_FileAttach=Attach Sketch"
perl -0777 -i.original -pe "s/$string/$replacement/igs" english.0.properties

string="Button_Sketch=Attach File"
replacement="Button_Sketch=Attach Sketch"
perl -0777 -i.original -pe "s/$string/$replacement/igs" english.0.properties

string="FileAttach=FileAttach"
replacement="FileAttach=Sketch"
perl -0777 -i.original -pe "s/$string/$replacement/igs" english.0.properties

rm ui_logic.bsh.original
rm english.0.properties.original
