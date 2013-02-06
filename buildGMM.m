function[modelsMap] = buildGMM(path);


files=dir(sprintf('%s/*.model.train',path));
for(k=1:size(files))
    disp(files(k).name);
    A0 = csvread(sprintf('%s/%s',path,files(k).name));
    %obj = gmdistribution.fit(A0,1,'CovType','diagonal');
    obj = gmdistribution.fit(A0,1);
    
    if k == 1
        modelsMap = containers.Map({files(k).name},{obj});
    else
        modelsMap(sprintf('%s',files(k).name)) = obj;
    end
end
