function[answer] = gmmClassify(path);

modelsMap = buildGMM(path);
models = modelsMap.keys;


correct=0;
samples=0;
for(k=1:length(models))
    test = models{k};
    test = test(1:strfind(test,'.train'));
    an = runtest(modelsMap,sprintf('%s/%stest',path,test));
    testSamples = sum(an);
    correct = correct + an(k);
    samples = samples + testSamples;
end
sprintf('correct percentage: %f',correct/samples*100)
