:- dynamic grade/2.
:- dynamic interest/2.

%confirm the interest
confirm_interest(Interest,Threshold):-
	interest(Interest, InterestLevel), InterestLevel >= Threshold.

% fields knowledge base.
field(law):-
	confirm_interest(law,4),
	confirm_interest(logic,2).
field(business):-
	confirm_interest(business, 4),
	confirm_interest(management, 2),
	confirm_interest(tolerance, 4).
field(social_science):-
	confirm_interest(social, 3),
	confirm_interest(art, 2).
field(natural_resource):-
	confirm_interest(outdoors, 3),
	confirm_interest(discovery,2).
field(special_needs):-
	confirm_interest(serving_people,4),
	confirm_interest(tolerance, 3).
field(kiswahili):-
	confirm_interest(tolerance, 2).
field(engineering):-
	confirm_interest(technical, 3),
	confirm_interest(inventive, 3),
	confirm_interest(logical, 3).
field(architecture):-
	confirm_interest(arch, 4),
	confirm_interest(inventive, 1).
field(it):-
	confirm_interest(inventive, 1),
	confirm_interest(technical, 2),
	confirm_interest(comp,4).
field(agribusiness):-
	confirm_interest(business, 2),
	confirm_interest(food, 2).
field(science):-
	confirm_interest(discovery, 4),
	confirm_interest(perfectionist, 3).
field(finance):-
	confirm_interest(business, 4),
	confirm_interest(stress, 1).
field(design):-
	confirm_interest(art,4),
	confirm_interest(inventive,2),
	confirm_interest(discovery,1).
field(sports):-
	confirm_interest(outdoor, 3),
	confirm_interest(sport,4),
	confirm_interest(tolerance,2).
field(medical):-
	confirm_interest(medical, 4),
        confirm_interest(tolerance, 3),
	confirm_interest(serving_people, 2),
	confirm_interest(perfectionist, 4).
field(history):-
	confirm_interest(history, 4).
field(agriculture):-
	confirm_interest(outdoor,3),
	confirm_interest(food,3).
field(geography):-
	confirm_interest(outdoor, 3),
	confirm_interest(discovery, 2).
field(catering):-
	confirm_interest(serving_people, 3),
	confirm_interest(catering, 4).


% Confirms if the grade for the specified unit meets the minimum
% requirement

confirm_grade(Unit, Threshold):-
    grade(Unit, GradePoints), GradePoints >= Threshold.


% Confirms whether any of the units provided meets the
% specified threshold

any_meets_threshold(Unit1, Unit2, Unit3, Unit4, Unit5, Unit6, Threshold):-
    grade(Unit1, Unit1Points), Unit1Points >= Threshold;
    grade(Unit2, Unit2Points), Unit2Points >= Threshold;
    grade(Unit3, Unit3Points), Unit3Points >= Threshold;
    grade(Unit4, Unit4Points), Unit4Points >= Threshold;
    grade(Unit5, Unit5Points), Unit5Points >= Threshold;
    grade(Unit6, Unit6Points), Unit6Points >= Threshold.

% Advices on courses one should take
should_take(X):-
    setof(X, can_take(X), Courses), member(X, Courses),
    info(X).


% Define conditions necessary to take given courses

%cluster 1
can_take(law):-
    confirm_grade(eng, 12),
    any_meets_threshold(mat,bio,chem,phy,_,_, 10),
    any_meets_threshold(his,geo,cre,_,_,_, 10),
    any_meets_threshold(kis,chem,his,cre,geo,opt_unit,10 ),
    field(law).

%cluster 2
can_take(catering_and_hotel_management):-
    any_meets_threshold(eng,kis,_,_,_,_, 10),
    confirm_grade(mat, 10),
    any_meets_threshold(bio,chem,phy,geo,his,cre,9),
    any_meets_threshold(bio,chem,geo,his,cre,opt_unit, 9),
    field(catering).

can_take(entrepreneurship):-
    any_meets_threshold(eng,kis,_,_,_,_, 10),
    confirm_grade(mat, 10),
    any_meets_threshold(bio,chem,phy,geo,his,cre,9),
    any_meets_threshold(bio,chem,geo,his,cre,opt_unit, 9),
    field(business).

can_take(commerce):-
    any_meets_threshold(eng,kis,_,_,_,_, 10),
    confirm_grade(mat, 11),
    any_meets_threshold(bio,chem,phy,geo,his,cre,10),
    any_meets_threshold(bio,chem,geo,his,cre,opt_unit, 9),
    field(business).

can_take(hotel_and_hospitality_management):-
    any_meets_threshold(eng,kis,_,_,_,_, 9),
    confirm_grade(mat, 8),
    any_meets_threshold(bio,chem,phy,geo,his,cre,9),
    any_meets_threshold(bio,chem,geo,his,cre,opt_unit, 9),
    field(catering).

can_take(procurement_and_contract_management):-
    any_meets_threshold(eng,kis,_,_,_,_, 9),
    confirm_grade(mat, 8),
    any_meets_threshold(bio,chem,phy,geo,his,cre,9),
    any_meets_threshold(bio,chem,geo,his,cre,opt_unit, 9),
    field(business).


can_take(hospitality_and_tourism_management):-
    any_meets_threshold(eng,kis,_,_,_,_, 9),
    confirm_grade(mat, 9),
    any_meets_threshold(bio,chem,phy,geo,his,cre,9),
    any_meets_threshold(bio,chem,geo,his,cre,opt_unit, 9),
    field(catering).

can_take(tourism_and_hotel_management):-
    any_meets_threshold(eng,kis,_,_,_,_, 9),
    confirm_grade(mat, 9),
    any_meets_threshold(bio,chem,phy,geo,his,cre,9),
    any_meets_threshold(bio,chem,geo,his,cre,opt_unit, 9),
    field(catering).

%cluster 3
can_take(development_studies):-
    any_meets_threshold(eng,kis,_,_,_,_, 9),
    any_meets_threshold(mat,bio,chem,phy,_,_, 9),
    any_meets_threshold(his,geo,cre,_,_,_, 8),
    any_meets_threshold(bio,chem,phy,opt_unit,_,_, 8),
    field(social_science).

can_take(arts):-
    any_meets_threshold(eng,kis,_,_,_,_, 9),
    any_meets_threshold(mat,bio,chem,phy,_,_, 9),
    any_meets_threshold(his,geo,cre,_,_,_, 8),
    any_meets_threshold(bio,chem,phy,opt_unit,_,_, 8),
    field(social_science).

can_take(education):-
    any_meets_threshold(eng,kis,_,_,_,_, 9),
    any_meets_threshold(mat,bio,chem,phy,_,_, 9),
    any_meets_threshold(his,geo,cre,_,_,_, 8),
    any_meets_threshold(bio,chem,phy,opt_unit,_,_, 8),
    field(social_science).

can_take(mass_communication):-
    any_meets_threshold(eng,kis,_,_,_,_, 9),
    any_meets_threshold(mat,bio,chem,phy,_,_, 9),
    any_meets_threshold(his,geo,cre,_,_,_, 8),
    any_meets_threshold(bio,chem,phy,opt_unit,_,_, 8),
    field(social_science).

can_take(journalism):-
    any_meets_threshold(eng,kis,_,_,_,_, 9),
    any_meets_threshold(mat,bio,chem,phy,_,_, 9),
    any_meets_threshold(his,geo,cre,_,_,_, 8),
    any_meets_threshold(bio,chem,phy,opt_unit,_,_, 8),
    field(social_work).

can_take(broadcast_jornalism):-
    any_meets_threshold(eng,kis,_,_,_,_, 9),
    any_meets_threshold(mat,bio,chem,phy,_,_, 9),
    any_meets_threshold(his,geo,cre,_,_,_, 8),
    any_meets_threshold(bio,chem,phy,opt_unit,_,_, 8),
    field(social_science).

can_take(criminology):-
    any_meets_threshold(eng,kis,_,_,_,_, 9),
    any_meets_threshold(mat,bio,chem,phy,_,_, 9),
    any_meets_threshold(his,geo,cre,_,_,_, 8),
    any_meets_threshold(bio,chem,phy,opt_unit,_,_, 8),
    field(social_science).

can_take(phychology):-
    any_meets_threshold(eng,kis,_,_,_,_, 9),
    any_meets_threshold(mat,bio,chem,phy,_,_, 9),
    any_meets_threshold(his,geo,cre,_,_,_, 8),
    any_meets_threshold(bio,chem,phy,opt_unit,_,_, 8),
    field(social_science).

%cluster 4
can_take(meteorology):-
    confirm_grade(mat, 11),
    confirm_grade(phy, 11),
    any_meets_threshold(bio,chem,geo,_,_,_, 11),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(natural_resource).

can_take(geomatic_and_geospatial_information_systems):-
    confirm_grade(mat, 11),
    confirm_grade(phy, 11),
    any_meets_threshold(bio,chem,geo,_,_,_,11),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(natural_resource).

can_take(geology):-
    confirm_grade(mat, 11),
    confirm_grade(phy, 11),
    any_meets_threshold(bio,chem,geo,_,_,_,11),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(natural_resource).

can_take(geospatial_engineering):-
    confirm_grade(mat, 11),
    confirm_grade(phy, 11),
    any_meets_threshold(bio,chem,geo,_,_,_,11),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(natural_resource).

can_take(astronomy_and_astrophysics):-
    confirm_grade(mat, 11),
    confirm_grade(phy, 11),
    any_meets_threshold(bio,chem,geo,_,_,_,11),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(natural_resource).


%cluster 5
can_take(special_needs_education):-
    any_meets_threshold(eng,kis,_,_,_,_,9),
    confirm_grade(bio, 10),
    any_meets_threshold(his,cre,geo,_,_,_,9),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(special_needs).

%cluster 6
can_take(kiswahili):-
    confirm_grade(kis, 11),
    any_meets_threshold(mat,eng,_,_,_,_,11),
    any_meets_threshold(his,cre,geo,_,_,_,11),
    any_meets_threshold(bio,chem,phy,cre,geo,opt_unit,10 ),
    field(kiswahili).

%cluster 7
can_take(civil_engineering):-
    confirm_grade(mat, 12),
    confirm_grade(phy, 11),
    confirm_grade(chem, 11),
    any_meets_threshold(bio,his,cre,geo,opt_unit,_,11),
    field(engineering).

can_take(electrical_and_electronics_engineering):-
    confirm_grade(mat, 12),
    confirm_grade(phy, 11),
    confirm_grade(chem, 11),
    any_meets_threshold(bio,his,cre,geo,opt_unit,_,11),
    field(engineering).

can_take(mechanical_engineering):-
    confirm_grade(mat, 12),
    confirm_grade(phy, 11),
    confirm_grade(chem, 11),
    any_meets_threshold(bio,his,cre,geo,opt_unit,_,11),
    field(engineering).

can_take(electronic_and_computer_engineering):-
    confirm_grade(mat, 12),
    confirm_grade(phy, 11),
    confirm_grade(chem, 11),
    any_meets_threshold(bio,his,cre,geo,opt_unit,_,11),
    field(engineering).

can_take(medical_engineering):-
    confirm_grade(mat, 12),
    confirm_grade(phy, 11),
    confirm_grade(chem, 11),
    any_meets_threshold(bio,his,cre,geo,opt_unit,_,11),
    field(engineering).

can_take(marine_engineering):-
    confirm_grade(mat, 12),
    confirm_grade(phy, 11),
    confirm_grade(chem, 11),
    any_meets_threshold(bio,his,cre,geo,opt_unit,_,11),
    field(engineering).

can_take(control_and_instrumentation):-
    confirm_grade(mat, 12),
    confirm_grade(phy, 11),
    confirm_grade(chem, 11),
    any_meets_threshold(bio,his,cre,geo,opt_unit,_,11),
    field(engineering).

can_take(petroleum_engineering):-
    confirm_grade(mat, 12),
    confirm_grade(phy, 11),
    confirm_grade(chem, 11),
    any_meets_threshold(bio,his,cre,geo,opt_unit,_,11),
    field(engineering).


%cluster 8
can_take(architecture):-
    confirm_grade(mat, 12),
    confirm_grade(phy, 11),
    any_meets_threshold(his,cre,geo,_,_,_,11),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,11),
    field(architecture).

can_take(architecture):-
    confirm_grade(mat, 12),
    confirm_grade(phy, 11),
    any_meets_threshold(his,cre,geo,_,_,_,11),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,11),
    field(architecture).

can_take(landscape_architecture):-
    confirm_grade(mat, 12),
    confirm_grade(phy, 11),
    any_meets_threshold(his,cre,geo,_,_,_,11),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,11),
    field(architecture).

can_take(construction_management):-
    confirm_grade(mat, 12),
    confirm_grade(phy, 11),
    any_meets_threshold(his,cre,geo,_,_,_,11),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,11),
    field(architecture).

%cluster 9
can_take(computer_science):-
    confirm_grade(mat, 12),
    confirm_grade(chem, 11),
    confirm_grade(phy, 10),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(it).

can_take(mathematics_and_computer_science):-
    confirm_grade(mat, 11),
    confirm_grade(chem, 11),
    confirm_grade(phy, 10),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(it).

can_take(computer_technology):-
    confirm_grade(mat, 10),
    confirm_grade(chem, 11),
    confirm_grade(phy, 10),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(it).

can_take(information_technology):-
    confirm_grade(mat, 12),
    confirm_grade(chem, 11),
    confirm_grade(phy, 10),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(it).

can_take(business_information_technology):-
    confirm_grade(mat, 10),
    confirm_grade(chem, 10),
    confirm_grade(phy, 10),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(it).

can_take(business_computing):-
    confirm_grade(mat, 10),
    confirm_grade(chem, 10),
    confirm_grade(phy, 10),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(it).

%cluster 10
can_take(agribusiness_management):-
    confirm_grade(mat, 12),
    confirm_grade(bio, 11),
    any_meets_threshold(phy,chem,_,_,_,_,10 ),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(agribusiness).

can_take(agribusiness):-
    confirm_grade(mat, 12),
    confirm_grade(bio, 11),
    any_meets_threshold(phy,chem,_,_,_,_,10 ),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(agribusiness).

can_take(agricultural_economics):-
    confirm_grade(mat, 12),
    confirm_grade(bio, 11),
    any_meets_threshold(phy,chem,_,_,_,_,10 ),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(agribusiness).

can_take(agricultural_resource_management):-
    confirm_grade(mat, 12),
    confirm_grade(bio, 11),
    any_meets_threshold(phy,chem,_,_,_,_,10 ),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(agribusiness).

%cluster 11
can_take(science):-
    confirm_grade(mat, 12),
    any_meets_threshold(phy,chem,bio,_,_,_,10 ),
    any_meets_threshold(phy,chem,bio,_,_,_,10 ),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(science).

can_take(science_with_education):-
    confirm_grade(mat, 12),
    any_meets_threshold(phy,chem,bio,_,_,_,10 ),
    any_meets_threshold(phy,chem,bio,_,_,_,10 ),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(science).

%cluster 12
can_take(actuarial_science):-
    confirm_grade(mat, 12),
    any_meets_threshold(phy,chem,bio,_,_,_,11 ),
    any_meets_threshold(his,cre,geo,_,_,_,11),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,11 ),
    field(finance).

can_take(economics):-
    confirm_grade(mat, 12),
    any_meets_threshold(phy,chem,bio,_,_,_,10 ),
    any_meets_threshold(his,cre,geo,_,_,_,10 ),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(finance).

can_take(finance):-
    confirm_grade(mat, 12),
    any_meets_threshold(phy,chem,bio,_,_,_,10 ),
    any_meets_threshold(his,cre,geo,_,_,_,10 ),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(finance).

can_take(industrial_mathematics):-
    confirm_grade(mat, 12),
    any_meets_threshold(phy,chem,bio,_,_,_,10 ),
    any_meets_threshold(his,cre,geo,_,_,_,10 ),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(finance).

can_take(real_estate):-
    confirm_grade(mat, 12),
    any_meets_threshold(phy,chem,bio,_,_,_,10 ),
    any_meets_threshold(his,cre,geo,_,_,_,10 ),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(finance).

can_take(statistics):-
    confirm_grade(mat, 12),
    any_meets_threshold(phy,chem,bio,_,_,_,10 ),
    any_meets_threshold(his,cre,geo,_,_,_,10 ),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(finance).

can_take(mathematics):-
    confirm_grade(mat, 12),
    any_meets_threshold(phy,chem,bio,_,_,_,10 ),
    any_meets_threshold(his,cre,geo,_,_,_,10 ),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(finance).

%cluster 13
can_take(arts_interior_design):-
    confirm_grade(chem, 12),
    any_meets_threshold(phy,mat,_,_,_,_,10 ),
    any_meets_threshold(bio,opt_unit,_,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(design).

can_take(fashion_design):-
    confirm_grade(chem, 12),
    any_meets_threshold(phy,mat,_,_,_,_,10 ),
    any_meets_threshold(bio,opt_unit,_,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(design).

can_take(clothing_textile_and_interior_design):-
    confirm_grade(chem, 12),
    any_meets_threshold(phy,mat,_,_,_,_,10 ),
    any_meets_threshold(bio,opt_unit,_,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(design).

can_take(textile_and_apparel_design_and_fashion):-
    confirm_grade(chem, 12),
    any_meets_threshold(phy,mat,_,_,_,_,10 ),
    any_meets_threshold(bio,opt_unit,_,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(design).

%cluster 14
can_take(physical_education_and_sports):-
    confirm_grade(bio, 10),
    confirm_grade(mat, 10),
    any_meets_threshold(bio,chem,phy,his,geo,cre,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(sports).

can_take(sports_science_and_management):-
    confirm_grade(bio, 10),
    confirm_grade(mat, 10),
    any_meets_threshold(bio,chem,phy,his,geo,cre,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(sports).

can_take(sports_management):-
    confirm_grade(bio, 10),
    confirm_grade(mat, 10),
    any_meets_threshold(bio,chem,phy,his,geo,cre,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(sports).

can_take(exercise_and_sport_science):-
    confirm_grade(bio, 10),
    confirm_grade(mat, 10),
    any_meets_threshold(bio,chem,phy,his,geo,cre,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(sports).

%cluster 15
can_take(dental_surgery):-
    confirm_grade(bio, 10),
    confirm_grade(chem, 10),
    any_meets_threshold(mat,phy,_,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(medical).

can_take(medicine_and_surgery):-
    confirm_grade(bio, 10),
    confirm_grade(chem, 10),
    any_meets_threshold(mat,phy,_,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(medical).

can_take(pharmacy):-
    confirm_grade(bio, 10),
    confirm_grade(chem, 10),
    any_meets_threshold(mat,phy,_,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(medical).

can_take(forensic_science):-
    confirm_grade(bio, 10),
    confirm_grade(chem, 10),
    any_meets_threshold(mat,phy,_,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(medical).

can_take(nursing):-
    confirm_grade(bio, 10),
    confirm_grade(chem, 10),
    any_meets_threshold(mat,phy,_,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(medical).

can_take(clinical_medicine):-
    confirm_grade(bio, 10),
    confirm_grade(chem, 10),
    any_meets_threshold(mat,phy,_,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(medical).

can_take(microbiology):-
    confirm_grade(bio, 10),
    confirm_grade(chem, 10),
    any_meets_threshold(mat,phy,_,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(medical).

can_take(biology):-
    confirm_grade(bio, 10),
    confirm_grade(chem, 10),
    any_meets_threshold(mat,phy,_,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(medical).

can_take(biochemistry):-
    confirm_grade(bio, 10),
    confirm_grade(chem, 10),
    any_meets_threshold(mat,phy,_,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(medical).

can_take(physiotherapy):-
    confirm_grade(bio, 10),
    confirm_grade(chem, 10),
    any_meets_threshold(mat,phy,_,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(medical).

can_take(public_health):-
    confirm_grade(bio, 10),
    confirm_grade(chem, 10),
    any_meets_threshold(mat,phy,_,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(medical).

can_take(geonomic_science):-
    confirm_grade(bio, 10),
    confirm_grade(chem, 10),
    any_meets_threshold(mat,phy,_,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(medical).

can_take(radiography):-
    confirm_grade(bio, 10),
    confirm_grade(chem, 10),
    any_meets_threshold(mat,phy,_,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(medical).

%cluster 16
can_take(history_and_archaeology):-
    confirm_grade(his, 10),
    any_meets_threshold(eng,kis,_,_,_,_,10 ),
    any_meets_threshold(mat,bio,chem,phy,_,_,10 ),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(history).

can_take(history):-
    confirm_grade(his, 10),
    any_meets_threshold(eng,kis,_,_,_,_,10 ),
    any_meets_threshold(mat,bio,chem,phy,_,_,10 ),
    any_meets_threshold(bio,chem,his,cre,geo,opt_unit,10 ),
    field(history).

%cluster 17
can_take(food_science_and_nutrition):-
    confirm_grade(bio, 10),
    confirm_grade(chem, 10),
    any_meets_threshold(mat,phy,geo,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(agriculture).

can_take(food_science_and_technology):-
    confirm_grade(bio, 10),
    confirm_grade(chem, 10),
    any_meets_threshold(mat,phy,geo,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(agriculture).

can_take(nutrition_and_diatetics):-
    confirm_grade(bio, 10),
    confirm_grade(chem, 10),
    any_meets_threshold(mat,phy,geo,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(agriculture).

can_take(agriculture):-
    confirm_grade(bio, 10),
    confirm_grade(chem, 10),
    any_meets_threshold(mat,phy,geo,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(agriculture).

can_take(horticulture):-
    confirm_grade(bio, 10),
    confirm_grade(chem, 10),
    any_meets_threshold(mat,phy,geo,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(agriculture).

can_take(botany):-
    confirm_grade(bio, 10),
    confirm_grade(chem, 10),
    any_meets_threshold(mat,phy,geo,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(agriculture).

can_take(animal_science):-
    confirm_grade(bio, 10),
    confirm_grade(chem, 10),
    any_meets_threshold(mat,phy,geo,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(agriculture).

%cluster 18
can_take(geography):-
    confirm_grade(geo, 10),
    confirm_grade(mat, 10),
    any_meets_threshold(bio,phy,chem,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(geography).

can_take(environmental_planning_and_management):-
    confirm_grade(geo, 10),
    confirm_grade(mat, 10),
    any_meets_threshold(bio,phy,chem,_,_,_,10 ),
    any_meets_threshold(eng,kis,his,cre,geo,opt_unit,10 ),
    field(geography).
