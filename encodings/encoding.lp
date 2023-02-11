% Input:
% vertex((X,Y))
%   (X,Y) - position, or identification of vertex

% edge(P,P')
%   P   - vertex(position)
%   P'  - vertex(position)

% agent(A)
%   A   - id

% start(A,P)
%   A   - agent(id)
%   P   - start-vertex(position)

% goal(A,P)
%   A   - agent(id)
%   P   - goal-vertex(position)


% Actions:
time(0..horizon).

% make edges undirected
edge(P,P') :- edge(P',P).

% start position
position(A,P,0) :- start(A,P).

% define allowed moves
{ move(A,(P,P'),T) : edge(P,P') } 1 :- position(A,P,T-1), agent(A), time(T).

% move
position(A,P',T) :- move(A,(P,P'),T), position(A,P,T-1).

% wait
position(A,P,T) :- not move(A,_,T), position(A,P,T-1), time(T).

% vertex collision
:- position(A1,P,T), position(A2,P,T), A1!=A2.

% edge collision
:- move(A1,(P,P'),T), move(A2,(P',P),T), A1!=A2.


% Goal:
:- not position(A,P,horizon), goal(A,P).

% Output:
% path(A,P,P')
%   A   - agent(id)
%   P   - start vertex of a move
%   P'  - end vertex of a move
%   - only works for acyclic paths

% dissalow cycles for the path/3 to work
:- move(A,(P,P'),T1), move(A,(P,P'),T2), T1!=T2.

% generate path
path(A,P,P') :- move(A,(P,P'),_).

%#show path/3.


% plan(N,A,T)
%   N   - agent(id)
%   A   - performed Action
%   T   - timestep

% generate plan
plan(A,move(P,P'),T) :- move(A,(P,P'),T).
plan(A,wait(P),T) :- time(T), position(A,P,T), not move(A,_,T), not T==0.

%#show plan/3.