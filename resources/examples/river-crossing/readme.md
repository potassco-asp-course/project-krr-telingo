# Fox, goose and bag of beans puzzle

Encodes the [fox, goose and bag of beans puzzle][wgc].

## Example calls

    clingo encoding.lp --output=reify | clingo - meta-telingo.lp -c horizon=6 0
    clingo encoding.lp --output=reify | clingo - meta-telingo.lp -c horizon=7 0

[wgc]: https://en.wikipedia.org/wiki/Fox,_goose_and_bag_of_beans_puzzle
