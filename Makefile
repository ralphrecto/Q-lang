all:
	ocamlbuild -use-menhir -tag thread -use-ocamlfind -quiet -pkg core test.native

clean:
	rm -rf _build; rm test.native