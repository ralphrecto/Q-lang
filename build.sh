#!/bin/bash 

rm -rf _build
rm test.native
ocamlbuild -use-menhir -tag thread -use-ocamlfind -quiet -pkg core test.native
