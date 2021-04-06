:- bundle(ciao_tcltk).
version('1.0').
depends([
    core-[version>='1.15']
]).
alias_paths([
    library = 'lib'
]).
lib('lib').
manual('ciao_tcltk', [main='doc/SETTINGS.pl']).
