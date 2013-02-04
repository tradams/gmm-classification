function[] = runtest(path,modelsMap);

%modelsMap = buildGMM('./tt_models/');
models = modelsMap.keys;

testSet = transpose(csvread(sprintf('%s/%s',path,'Alternative.model.test')));

testScores = [];
numTest = length(testSet(:,1));
for(j=1:numTest)
    feature = testSet(j,:)
    scores = [];
    for(k=1:length(models))
        
        covar = modelsMap(models{k}).Sigma;
%        score = pdf(modelsMap(models{k}),feature);
        score = feature*covar*feature';
        scores = cat(2,scores,score);
    end
    if mod(j,1000) == 0
%        sprintf('%d/%d completed',j,length(testSet(:,1)))
    end
    testScores = cat(1,testScores,scores);
end

answer = [linspace(0,0,length(models))];

for(i=1:numTest)
    
    [C,I] = max(testScores(i,:));
    if I > 1 && I < length(models)
        nscore = [linspace(0,0,I-1),1,linspace(0,0,length(models)-I)];
    elseif I == length(models)
        nscore = [linspace(0,0,I-1),1];
    else
        nscore = [1,linspace(0,0,length(models)-I)];
    end 
    answer = answer+nscore;
end
answer*1/numTest
