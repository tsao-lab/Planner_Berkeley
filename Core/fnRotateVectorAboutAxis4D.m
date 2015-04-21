function R = fnRotateVectorAboutAxis4D(afAxis, fAngle)
afAxis = afAxis / norm(afAxis);
C = cos(fAngle);
S = sin(fAngle);
T = 1-C;
X = afAxis(1);
Y = afAxis(2);
Z = afAxis(3);
R = [T * X^2 + C, T*X*Y-S*Z, T*X*Z+S*Y,0;
     T*X*Y+S*Z, T*Y^2+C, T*Y*Z-S*X,0;
     T*X*Z-S*Y, T*Y*Z+S*X,T*Z^2+C,0;
     0 0 0 1];

