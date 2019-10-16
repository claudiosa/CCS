% A simple course advisor system
% The user interface

% Initialization procedures
start:-
    reconsult('temp.pl'),nl,
    reconsult('info.pl'),nl,
    reconsult('kb.pl'),nl,
    menu.

% Saves new temporary info for use by inference engine
save:-
    write('Saving data'),nl,
    tell('temp.pl'),
    listing(grade),
    listing(interest),
    told,
    write('Done'),nl.

% Clears all temporary data from temporary data file
clear:-
    abolish(grade/2),
    abolish(interest/2),
    tell('temp.pl'),
    told.

prompt_grade(Subject, Title):-
    write(Title),
    write(": "),
    read(Grade),
    assert(grade(Subject, Grade)).

% Prompts for the level of interest in specified area
prompt_interest(Interest, Title):-
    write("What is your level of interest in "),
    write(Title),
    write(" "),
    read(Interest_Level),
    assert(interest(Interest, Interest_Level)).

% Prompts for user levels of the specified attribute
prompt_levels(Interest, Title):-
    write("What is your level of "),
    write(Title),
    write(" "),
    read(Levels),
    assert(interest(Interest, Levels)).

% Gives instructions  for entering grades
grade_instructions:-
    write("Enter the grades you got for the following subjects"),nl,
    write("(A is 12 points, A- is 11 points etc...)"),nl,
    write("If you did not do the subject enter 0 for the grade"),nl,nl.

interest_instructions:-
    nl,
    write("Great, now you will answer a few more questions concerning yourself."),nl,
    write("Kindly respond with numbers from 0 to 4:"),nl,nl,
    write("0 - None"),nl,
    write("1 - Low"),nl,
    write("2 - Medium"),nl,
    write("3 - High"),nl,
    write("4 - Very high"),nl,nl.

%Displays menu to user
menu:-
    clear, /* Clear existing facts before asking for new ones */
    grade_instructions,
    prompt_grade(mat, "Mathematics"),
    prompt_grade(eng, "English"),
    prompt_grade(kis, "Kiswahili"),
    prompt_grade(chem, "Chemistry"),
    prompt_grade(phy, "Physics"),
    prompt_grade(bio, "Biology"),
    prompt_grade(geo, "Geography"),
    prompt_grade(his, "History"),
    prompt_grade(cre, "CRE"),
    prompt_grade(opt_unit, "optional unit"),

    interest_instructions,
    prompt_interest(logic, "logic?"),
    prompt_interest(management, "management activities?"),
    prompt_interest(art, "painting and drawing?"),
    prompt_interest(medicine, "medical activities?"),
    prompt_interest(food, "culinary art work(food industry)?"),
    prompt_interest(arch, "construction design and management activities?"),
    prompt_interest(business, "business activities ie economics,finance and marketing?"),
    prompt_interest(outdoor, "outdoor working area and activities?"),
    prompt_levels(tolerance, "stress tolerance?"),
    prompt_interest(history, "historical information?"),
    prompt_interest(law, "legal and criminal justice?"),
    prompt_interest(inventive, "thinking and coming up with new ideas?"),
    prompt_interest(comp, "computing?"),
    prompt_interest(social, "sociability?"),
    prompt_levels(perfectionist, "attention to details?"),
    prompt_interest(technical, "doing technical activities?"),
    prompt_interest(discovery, "discovering new things?"),
    prompt_interest(serving_people, "serving people?"),
    prompt_interest(catering, "catering?"),
    prompt_interest(sport, "physical and sporting activities?"),

    save.
