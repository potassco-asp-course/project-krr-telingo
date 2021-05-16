%
% Meta-encoding using hold(A,T)
%

conjunction(B,T) :- literal_tuple(B), time(T),
        hold(L,T) : literal_tuple(B, L), L > 0;
    not hold(L,T) : literal_tuple(B,-L), L > 0.

body(normal(B),T) :- rule(_,normal(B)), conjunction(B,T), time(T).
body(sum(B,G),T)  :- rule(_,sum(B,G)), time(T),
    #sum { W,L :     hold(L,T), weighted_literal_tuple(B, L,W), L > 0 ;
           W,L : not hold(L,T), weighted_literal_tuple(B,-L,W), L > 0 } >= G.

  hold(A,T) : atom_tuple(H,A)   :- rule(disjunction(H),B), body(B,T), time(T).
{ hold(A,T) : atom_tuple(H,A) } :- rule(     choice(H),B), body(B,T), time(T).

time(0..horizon).

#show.
#show (S,T) : output(show(S),_), true(S,T).


%
% Connect true/2 with hold/2
%

true(O,T) :- hold(L,T), output(O,B), literal_tuple(B,L).
hold(L,T) :- true(O,T), output(O,B), literal_tuple(B,L).

%
% the next rule is also needed to represent the facts
%  O.
% of the input logic program, for which clingo generates
%  output(O,0).
% and no literal_tuple of the form literal_tuple(0,L)
%
true(O,T) :- time(T), output(O,B), not literal_tuple(B,_).


%
% Temporal connectives using true/2
%


% formulas
formula(O) :- output(O,_).


% initially
true(initially,0) :-       formula(initially).
:- true(initially,T), T>0, formula(initially).


% finally
true(finally,horizon) :-       formula(finally).
:- true(finally,T), T<horizon, formula(finally).


% prev
formula(F) :- formula(prev(F)).
%
true(F,T-1) :- true(prev(F),T), formula(prev(F)), time(T), time(T-1).
true(prev(F),T) :- true(F,T-1), formula(prev(F)), time(T), time(T-1).
:- true(prev(F),0), formula(prev(F)).


% wprev
formula(F) :- formula(wprev(F)).
%
true(F,T-1) :- true(wprev(F),T), formula(wprev(F)), time(T), time(T-1).
true(wprev(F),T) :- true(F,T-1), formula(wprev(F)), time(T), time(T-1).
true(wprev(F),0) :- formula(wprev(F)).


% next


% wnext


% eventually
formula(F) :- formula(eventually(F)).
%
true(F,TT) : time(TT), TT>=T :- true(eventually(F),T),  formula(eventually(F)), time(T).
true(eventually(F),T)  :- time(TT), TT>=T, true(F,TT),  formula(eventually(F)), time(T).


% eventually_before


% always
formula(F) :- formula(always(F)).
%
% true(always(F),T) :- formula(always(F)), time(T), ... .


% always_before


% until
formula(F) :- formula(until(F,G)).
formula(G) :- formula(until(F,G)).
%
% true(until(F,G),T1) :- formula(until(F,G)), time(T1), ... .
%
% uses true(until(F,G),T1,T2)
% true(until(F,G),T1,T2) :- formula(until(F,G)), time(T1), time(T2), T1<=T2,
%                           ... .


% release


% while


% since


% trigger


%
% Defined predicates
%

#defined literal_tuple/1.
#defined literal_tuple/2.
#defined rule/2.
#defined atom_tuple/2.
#defined weighted_literal_tuple/3.
