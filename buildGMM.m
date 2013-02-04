function[modelsMap] = buildGMM(path);


files=dir(sprintf('%s/*.model.train',path));
for(i=1:size(files))
    disp(files(i).name);
    A0 = transpose(csvread(sprintf('%s/%s',path,files(i).name)));
    obj = gmdistribution.fit(A0,1);
    
    if i == 1
        modelsMap = containers.Map({files(i).name},{obj});
    else
        modelsMap(sprintf('%s',files(i).name)) = obj;
    end
end
