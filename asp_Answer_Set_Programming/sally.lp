% instance
motive(harry).
motive(sally).
guilty(harry).

% encoding
%innocent(Suspect) :- motive(Suspect), not guilty(Suspect).
innocent(Suspect) :- motive(Suspect), not guilty(Suspect), Suspect == harry.

%%%#hide motive.