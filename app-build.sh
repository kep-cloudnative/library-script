#!/bin/bash
cd /data/library-monolithic
gradlew build

cp ./build/libs/library-monolithic-0.0.1-SNAPSHOT.jar /data/library-monolithic.jar

