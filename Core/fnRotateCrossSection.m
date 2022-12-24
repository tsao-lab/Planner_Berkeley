function [strctCrossSection, strctCrossSection1, strctCrossSection2] = ...
    fnRotateCrossSection(strctCrossSection, strctCrossSection1, strctCrossSection2, fRotAngleRad)

% [pt3iPointOnLine, afRotateDir] = fnPlanePlaneIntersection(strctCrossSection1,...
%     strctCrossSection2);
pt3iPointOnLine = strctCrossSection.m_a2fM(1:3,4);
afRotateDir = strctCrossSection.m_a2fM(1:3,3);

a2fPosTrans = eye(4);
a2fNegTrans = eye(4);
a2fPosTrans(1:3, 4) = pt3iPointOnLine';
a2fNegTrans(1:3, 4) = -pt3iPointOnLine';

R = fnRotateVectorAboutAxis(afRotateDir, fRotAngleRad);
a2fRot = zeros(4, 4);
a2fRot(1:3, 1:3) = R;
a2fRot(4, 4) = 1;

strctCrossSection.m_a2fM = a2fPosTrans*a2fRot*a2fNegTrans*strctCrossSection.m_a2fM;
strctCrossSection1.m_a2fM = a2fPosTrans*a2fRot*a2fNegTrans*strctCrossSection1.m_a2fM;
strctCrossSection2.m_a2fM = a2fPosTrans*a2fRot*a2fNegTrans*strctCrossSection2.m_a2fM;

