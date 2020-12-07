function [scenario, egoVehicle] = Prasad()
% createDrivingScenario Returns the drivingScenario defined in the Designer

% Generated by MATLAB(R) 9.7 (R2019b) and Automated Driving Toolbox 3.0 (R2019b).
% Generated on: 07-Dec-2020 17:19:04

% Construct a drivingScenario object.
scenario = drivingScenario;

% Add all road segments
roadCenters = [0 20 0;
    110 20 0];
marking = [laneMarking('Solid', 'Color', [0.98 0.86 0.36], 'Width', 1e-05, 'Strength', 0)
    laneMarking('Dashed')];
laneSpecification = lanespec(1, 'Width', 20, 'Marking', marking);
road(scenario, roadCenters, 'Lanes', laneSpecification);

% Add the ego vehicle
egoVehicle = vehicle(scenario, ...
    'ClassID', 1, ...
    'Position', [103.994048300763 13.077549886967 0], ...
    'FrontOverhang', 0.9);
waypoints = [0 15 0;
    0.737702112473053 14.9684725634052 0;
    1.22032835717502 14.9992297185093 0;
    1.70259939386345 15.0807780388341 0;
    2.23519388521971 15.2120725386262 0;
    2.83875179179071 15.3850999677341 0;
    3.51189230488879 15.5907772265749 0;
    4.25146423078202 15.8208156315116 0;
    5.05382796918469 16.0679556178215 0;
    5.9150850072087 16.32592139042 0;
    6.83118223822655 16.5893439227506 0;
    7.79799418096933 16.8536824013128 0;
    8.81139194713236 17.1151473553591 0;
    9.8673006063447 17.3706263699566 0;
    10.9617461506023 17.6176129831687 0;
    12.0908931686667 17.8541392117274 0;
    13.2510742760102 18.0787120229604 0;
    14.4388122826591 18.2902539627627 0;
    15.6508360158422 18.4880480569316 0;
    16.8840906473527 18.6716870246755 0;
    18.135743308118 18.8410267772733 0;
    19.4031847056357 18.9961441204729 0;
    20.684027394509 19.1372985351027 0;
    21.9761012869435 19.2648978754026 0;
    23.2774469292969 19.3794677977 0;
    24.5863070129829 19.4816247122814 0;
    25.9011165335297 19.572052037704 0;
    27.2204919605659 19.6514795285166 0;
    28.5432197340753 19.7206654436212 0;
    29.8682443584787 19.7803813226016 0;
    31.1946563259403 19.8313991406254 0;
    32.5216800637193 19.8744806184028 0;
    33.8486620672763 19.9103684716566 0;
    35.1750593510869 19.9397793941436 0;
    36.5004283225427 19.9633985790799 0;
    37.8244141607758 19.9818755954948 0;
    39.1467407615277 19.9958214482733 0;
    40.4672012911172 20.0058066631759 0;
    41.7856493769427 20.0123602507319 0;
    43.1019909485821 20.015969415393 0;
    44.4161767322422 20.0170798885665 0;
    45.7281953918599 20.0160967759859 0;
    47.0380673023925 20.013385821235 0;
    48.3458389345705 20.0092749980334 0;
    49.6515778254683 20.004056354076 0;
    50.9553681055011 19.9979880387473 0;
    52.2573065497535 19.9912964558883 0;
    53.5574991197303 19.9841784909717 0;
    54.8560579605815 19.9768037695362 0;
    56.1530988184706 19.969316910563 0;
    57.4487388429186 19.9618397446531 0;
    58.7430947395793 19.9544734724234 0;
    60.0362812398951 19.9473007434942 0;
    61.3284098553677 19.9403876408362 0;
    62.6195878856911 19.9337855591089 0;
    63.9099176516803 19.9275329689939 0;
    65.1994959257242 19.921657062437 0;
    66.4884135343645 19.9161752762104 0;
    67.7767551095081 19.9110966933118 0;
    69.0645989666882 19.9064233234804 0;
    70.3520170906742 19.9021512655569 0;
    71.6390752105678 19.8982717555791 0;
    72.9258329482973 19.8947721054247 0;
    74.2123440261194 19.8916365375046 0;
    75.4986565203483 19.8888469215168 0;
    76.7848131500439 19.8863834196062 0;
    78.0708515908084 19.8842250464662 0;
    79.3568048051519 19.8823501509899 0;
    80.6427013820942 19.8807368260456 0;
    81.928565879781 19.8793632528327 0;
    83.2144191658931 19.878207986089 0;
    84.5002787515398 19.8772501861771 0;
    85.7861591151402 19.8764698037971 0;
    87.0720720135232 19.8758477227526 0;
    88.3580267781167 19.8753658658662 0;
    89.6440305946628 19.8750072687859 0;
    90.9300887653826 19.8747561260707 0;
    92.2162049529382 19.8745978135836 0;
    93.5023814058992 19.8745188908724 0;
    94.7886191657246 19.8745070868696 0;
    96.0599734241947 19.8596064405891 0;
    97.2908573624199 19.8042209301588 0;
    98.4711516708796 19.6982237913961 0;
    99.5931352492182 19.5338880259895 0;
    100.651187919678 19.3055889341456 0;
    101.641514262374 19.0095277805713 0;
    102.56188881691 18.6434768386809 0;
    103.396477728511 18.2214905540369 0;
    104.119929801489 17.7693891284784 0;
    104.723293565319 17.2984567324129 0;
    105.200775078272 16.8183380739481 0;
    105.549286389878 16.3371815796834 0;
    105.768032754942 15.861779064826 0;
    105.858137756519 15.3977005624201 0;
    105.822305115658 14.9494232718483 0;
    105.664515666792 14.5204538425804 0;
    105.389757749947 14.1134434327084 0;
    105.003789105607 13.730295175463 0;
    104.512928246833 13.3722638530306 0;
    103.923873218608 13.0400477179209 0];
speed = 10;
trajectory(egoVehicle, waypoints, speed);

% Add the non-ego actors
actor(scenario, ...
    'ClassID', 5, ...
    'Length', 2.4, ...
    'Width', 0.76, ...
    'Height', 0.8, ...
    'Position', [75 15 0]);

