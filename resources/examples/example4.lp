% clingo example4.lp --output=reify | clingo - meta-telingo.lp -c horizon=3 0

%
% Temporal program
%

wprev(a).

    {b} :-        initially.
prev(c) :- not b, initially.

%
% Display
%

#show show(a). % corresponds to #show a : a.
#show show(b). % corresponds to #show b : b.
#show show(c). % corresponds to #show c : c.


%
% Externals (for all temporal atoms in the bodies)
%

#external initially.
