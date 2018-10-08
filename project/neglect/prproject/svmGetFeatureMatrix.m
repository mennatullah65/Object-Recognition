function [finalMat,finalGroup]=svmGetFeatureMatrix(firstClassFeaturesMat,secondClassFeaturesMat,groupMat1,groupMat2)
finalMat=[firstClassFeaturesMat;secondClassFeaturesMat];
finalGroup=[groupMat1;groupMat2];
end