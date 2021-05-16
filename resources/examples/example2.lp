% clingo example2.lp --output=reify | clingo - meta-telingo.lp -c horizon=3 0


%
% Temporal program
%

a :- initially.

prev(b) :- prev(prev(a)).
prev(a) :- prev(prev(b)).

wprev(c) :- wprev(wprev(d)).
wprev(d) :- wprev(wprev(c)).


%
% Display
%

#show show(a). % corresponds to #show a : a.
#show show(b). % corresponds to #show b : b.
#show show(c). % corresponds to #show c : c.
#show show(d). % corresponds to #show d : d.


%
% Externals (for all temporal atoms in the bodies)
%

#external initially.
#external prev(prev(a)).
#external prev(prev(b)).
#external wprev(wprev(c)).
#external wprev(wprev(d)).
