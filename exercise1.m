clearvars
clc

%  The measured components of the magnetic field:
Bx = 31080; % nT
By = 28714; % nT
Bz = -9204; % nT
B = [Bx; By; Bz];

% Normalize B
B_norm = B / norm(B);

% The detected sun direction (unit vector) along the following direction:
Sx = 0.2165;
Sy = -0.6250;
Sz = -0.7500;
S = [Sx; Sy; Sz];

% Define ECI frame vectors.
% Using IGRF model for modeling Earth?s magnetic field.
% https://www.ngdc.noaa.gov/geomag-web/?model=igrf#igrfwmma
% Model Used:	IGRF12	More information
% Latitude:     67.8558 N
% Longitude:    20.2253 E
% Elevation:	500 km Mean Sea Level
% Date: 2018-03-20

% North Comp.
In = 9490.7; % nT

% East Comp.
Ie = 1102.6; % nT

% Vertical Comp.
Iv = 42235.4; % nT

Ib = [9490.7; 1102.6; 42235.4];
Ib_norm = Ib / norm(Ib);

Is = [1; 0; 0];

% Calculate the units b1, b2, b3.
b1 = cross(S, B) / norm(cross(S, B));
b2 = cross(b1, S);
b3 = S; 

Bb = [b1, b2, b3];

% Calculate euler vectors
e1 = cross(Is, Ib) / norm(cross(Is, Ib));
e2 = cross(e1, Is);
e3 = Is;

e = [e1, e2, e3];

% Direction cosine matrix
C = Bb * inv(e);

% Euler angles
theta = radtodeg(acos(C(3,3)))

psi = radtodeg(atan(C(3,1) / -C(3,2)));
psi = 360 + psi % Positive angle.

phi = radtodeg(atan(C(1,3) / C(2,3)))

