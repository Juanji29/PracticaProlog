/* vehicle(Brand, Reference, Type, Price, Year) */
vehicle(ford, fiesta, sport, 15000, 2018).
vehicle(ford, f150, pickup, 50000, 2020 ).
vehicle(ford, mustang, sport, 30000, 2020).
vehicle(renault, clio, sport, 12000, 2017).
vehicle(renault, megane, sport, 18000, 2018).
vehicle(renault, kadjar, suv, 25000, 2019).
vehicle(bmw, serie1, sedan, 25000, 2018).
vehicle(bmw, serie3, sedan, 35000, 2019).
vehicle(bmw, x5, suv, 60000, 2020).
vehicle(audi, a3, sport, 28000, 2018).
vehicle(audi, a4, sedan, 35000, 2019).
vehicle(audi, q5, suv, 55000, 2020).
vehicle(volkswagen, amarok, pickup, 43000, 2023).
vehicle(volkswagen, passat, sedan, 28000, 2019).
vehicle(volkswagen, tiguan, suv, 40000, 2020).
vehicle(mercedes, claseA, sport, 30000, 2018).
vehicle(mercedes, claseC, sedan, 40000, 2019).
vehicle(mercedes, glc, suv, 70000, 2020).
vehicle(toyota, hilux, pickup, 38000, 2018).
vehicle(toyota, camry, sedan, 25000, 2019).
vehicle(toyota, rav4, suv, 35000, 2020).
vehicle(honda, civic, sport, 20000, 2018).
vehicle(honda, accord, sedan, 28000, 2019).
vehicle(honda, crv, suv, 40000, 2020).
vehicle(nissan, sklyline, sport, 35000, 2018).
vehicle(nissan, silvia, sport, 30000, 2019).
vehicle(nissan, qashqai, suv, 25000, 2020).
vehicle(chevrolet, camaro, sport, 40000, 2018).
vehicle(chevrolet, malibu, sedan, 25000, 2019).
vehicle(chevrolet, tracker, suv, 30000, 2020).

meet_budget(Reference, BudgetMax) :-       
    vehicle(_, Reference, _, Price, _),       
    Price =< BudgetMax.  

vehicles_by_brand(Brand, References) :-
    findall(Reference, vehicle(Brand, Reference, _, _, _), References).

group_by_type_and_year(Brand, Grouped) :-
    bagof((Type, Year, Ref), vehicle(Brand, Ref, Type, _, Year), Grouped).


generate_report(Brand, Type, Budget, Result) :-
    findall(
        (Reference, Price),
        (vehicle(Brand, Reference, Type, Price, _), Price =< Budget),
        Vehicles
    ),
    total_value(Vehicles, Total),
    (Total =< 1000000 ->
        Result = report{vehicles: Vehicles, total: Total}
    ;
        % Si excede el millón, filtra los mas baratos
        sort(2, @=<, Vehicles, Sorted),  % ordena por precio
        filter_under_limit(Sorted, 1000000, [], Filtered, 0, NewTotal),
        Result = report{vehicles: Filtered, total: NewTotal}
    ).

total_value([], 0).
total_value([(_, Price) | T], Total) :-
    total_value(T, SubTotal),
    Total is Price + SubTotal.

filter_under_limit([], _, Acc, Acc, Total, Total).
filter_under_limit([(R, P) | T], Limit, Acc, Result, Running, Total) :-
    NewTotal is Running + P,
    (NewTotal =< Limit ->
        filter_under_limit(T, Limit, [(R, P) | Acc], Result, NewTotal, Total)
    ;
        filter_under_limit([], Limit, Acc, Result, Running, Total)
    ).