function fnAddGridGroupUsingTwoPoints(strctStartPoint, strctEndPoint)

strctCrossSection = fnAxesHandleToStrctCrossSection(strctStartPoint.m_hAxes);
fnAddGridGroupUsingTwoPointsAux(fnCrossSection_Image_To_MM_3D(strctCrossSection, strctStartPoint.m_pt2fPos), ...
    fnCrossSection_Image_To_MM_3D(strctCrossSection, strctEndPoint.m_pt2fPos));
