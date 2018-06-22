isFavorite(X, Message) :- 
                        member(X, [1,2,4,8,16,32,64,128,256]),
                        Message = 'It is one of my favorite numbers!'.
isFavorite(X, Message):- 
        \+member(X, [1,2,4,8,16,32,64,128,256]),
        Message = 'It is not one of my favorite numbers!'.

% in iefficient; duplicate code
isFavorite1(X, Message) :- 
        member(X, [1,2,4,8,16,32,64,128,256]),
        !,
        member(Message, ['Message1','Message2']).
isFavorite1(X, Message):- 
            \+member(X, [1,2,4,8,16,32,64,128,256]),
            Message = 'It is not one of my favorite numbers!'.

isFavorite2(X, Message) :- 
                member(X, [1,2,4,8,16,32,64,128,256]),
                member(Message, ['Message1','Message2']),
                !.              % No backtrackable
isFavorite2(X, Message):- 
                    \+member(X, [1,2,4,8,16,32,64,128,256]),
                    Message = 'It is not one of my favorite numbers!'.