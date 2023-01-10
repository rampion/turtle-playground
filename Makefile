repl: turtle-playground.cabal
	cabal repl

turtle-playground.cabal: package.yaml
	hpack
