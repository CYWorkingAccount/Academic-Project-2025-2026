#!/bin/bash
set -e

#FX_PATH=~/javafx-21.0.7/lib
FX_PATH=/home/public/javafx-sdk-21.0.7/lib
MODULES=javafx.controls,javafx.fxml

rm -rf bin
mkdir -p bin/res

javac --module-path "$FX_PATH" --add-modules "$MODULES" -cp "lib/*:bin" src/*.java -d bin

cp res/* bin/res/

jar -cvfm app.jar manifest.mf -C bin .

java --module-path "$FX_PATH" --add-modules "$MODULES" -cp "app.jar:lib/*" Main
