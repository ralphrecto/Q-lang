all:
	ocamlbuild -use-menhir -tag thread -use-ocamlfind -quiet -pkg core -I . test.native

clean:
	rm -rf _build; rm test.native
