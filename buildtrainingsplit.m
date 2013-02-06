function[] = buildtrainingsplit(genreModels,outputModels,percentSplit);

path=genreModels;
spath=outputModels;

files=dir(sprintf('%s/*.model',path));
A = [];
A_T = [];
A_Test = [];
for(i=1:size(files))
    disp(files(i).name);
    A0 = csvread(sprintf('%s/%s',path,files(i).name));
    [row,col] = size(A0);
    s1 = floor(percentSplit*row);
    
    A_T = A0(1:s1,:);
    A_Test = A0((s1+1):row,:);
    csvwrite(sprintf('%s/%s.train',spath,files(i).name),A_T);
    csvwrite(sprintf('%s/%s.test',spath,files(i).name),A_Test);
    clear 'A_T' 'A_Test' 'A0';
    
end

