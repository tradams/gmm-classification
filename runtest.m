function[answer] = runtest(modelsMap,genreTest);

%modelsMap = buildGMM('./tt_models/');
models = modelsMap.keys;

testSet = csvread(genreTest);

testScores = [];
numTest = length(testSet(:,1));
answer = [linspace(0,0,length(models))];
for(j=1:numTest)
    feature = [testSet(j,:) 0];
    scores = [];
    for(k=1:length(models))
        
        W = modelsMap(models{k});
%        score = pdf(modelsMap(models{k}),feature);
        score = feature*W*feature';

        scores = cat(2,scores,score);
    end
    if mod(j,1000) == 0
        sprintf('%d/%d completed',j,length(testSet(:,1)))
    end
    [C,I] = max(scores);
    if I > 1 && I < length(models)
        nscore = [linspace(0,0,I-1),1,linspace(0,0,length(models)-I)];
    elseif I == length(models)
        nscore = [linspace(0,0,I-1),1];
    else
        nscore = [1,linspace(0,0,length(models)-I)];
    end 
    answer = answer+nscore;
end

