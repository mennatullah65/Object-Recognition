function accuracy = mknnCalcAccuracy( confusionMat,testNum )
sumDiags=sum(diag(confusionMat,0));
accuracy=(sumDiags/testNum)*100;
end

