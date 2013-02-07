function [mMap] = transformGMM(modelsMap);
mMap = containers.Map();
models = modelsMap.keys;
featureLength = 13;
for(k=1:length(models))
    sigma = modelsMap(models{k}).Sigma;
    [row,col] = size(sigma);
    featureLength = col;
    sigmaInv = inv(sigma);
    mu = modelsMap(models{k}).mu';
    wi = sigmaInv * mu;
    wi0 = -1/2* mu' * sigmaInv * mu - 1/2 * log(det(sigma)) + log(1/length(models));
    wi = cat(1,wi,wi0);
    sigmaInv = cat(1,(-1/2)*sigmaInv,linspace(0,0,featureLength));
    sigmaInv = cat(2,sigmaInv,wi);
    mMap(models{k}) = sigmaInv;
end
