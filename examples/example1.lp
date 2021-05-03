% clingo example1.lp --output=reify | clingo - meta-tel-simple.lp -c horizon=5 0

%
% Temporal program
%

a :- initially.
b :- prev(prev(a)).
a :- prev(prev(b)).

%
% Display
%

#show show(a). % corresponds to #show a : a.
#show show(b). % corresponds to #show b : b.


%
% Externals (for all temporal atoms in the bodies)
%

#external initially.
#external prev(prev(a)).
#external prev(prev(b)).
