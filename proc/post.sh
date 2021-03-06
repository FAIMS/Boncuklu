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

# SEARCH







string="
        <select1 ref=\"Entity_Types\">
          <label>{Entity_Types}<\/label>
          <item>
            <label>Options not loaded<\/label>
            <value>Options not loaded<\/value>
          <\/item>
        <\/select1>"
replacement="
        <group ref=\"Colgroup_1\" faims_style=\"orientation\">
          <label\/>
          <group ref=\"Col_0\" faims_style=\"even\">
            <label\/>
            <select1 ref=\"Entity_Types\">
              <label>{Entity_Types}<\/label>
              <item>
                <label>Options not loaded<\/label>
                <value>Options not loaded<\/value>
              <\/item>
            <\/select1>
          <\/group>
          <group ref=\"Col_1\" faims_style=\"even\">
            <label\/>
            <select1 ref=\"Select_User\">
              <label>{Select_User}<\/label>
              <item>
                <label>Options not loaded<\/label>
                <value>Options not loaded<\/value>
              <\/item>
            <\/select1>
          <\/group>
          <group ref=\"Col_2\" faims_style=\"even\">
            <label\/>
            <select1 ref=\"Select_AreaCode\">
              <label>{Select_AreaCode}<\/label>
              <item>
                <label>Options not loaded<\/label>
                <value>Options not loaded<\/value>
              <\/item>
            <\/select1>
          <\/group>
        <\/group>"
perl -0777 -i.original -pe "s/$string/$replacement/igs" ui_schema.xml

string="
              <Entity_Types\/>"
replacement="
              <Colgroup_1>
                <Col_0>
                  <Entity_Types\/>
                <\/Col_0>
                <Col_1>
                  <Select_User\/>
                <\/Col_1>
                <Col_2>
                  <Select_AreaCode\/>
                <\/Col_2>
              <\/Colgroup_1>
              <Select_User\/>"
perl -0777 -i.original -pe "s/$string/$replacement/igs" ui_schema.xml

cat << EOF >> english.0.properties
Select_User=Select User
Select_AreaCode=Select Trench
EOF

rm ui_schema.xml.original










rm ui_logic.bsh.original
