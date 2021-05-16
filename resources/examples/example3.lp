% clingo example3.lp --output=reify | clingo - meta-telingo.lp -c horizon=3 0

%
% Temporal program
%

eventually(a) :- initially.

eventually(b) :- initially.
b :- prev(b).


%
% Display
%

#show show(a). % corresponds to #show a : a.
#show show(b). % corresponds to #show b : b.


%
% Externals (for all temporal atoms in the bodies)
%

#external initially.
#external prev(a).
#external prev(b).
