PREFIX:=../
DEST:=$(PREFIX)$(PROJECT)
REBAR=rebar

.PHONY: all edoc test clean

all:
	@$(REBAR) prepare-deps

edoc:
	@$(REBAR) doc

test:
	@rm -rf .eunit
	@mkdir -p .eunit
	@$(REBAR) eunit

clean:
	@$(REBAR) clean

