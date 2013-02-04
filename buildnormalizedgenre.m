function[] = buildnormalizedgenre(pathName,outputfile);


% -----------------------------------------------------------
% Builds normalized genre models, run once per genre path
%	Copyright (C) 2012  Drexel University
%
%	Author : Kamelia Aryafar
% -----------------------------------------------------------

oldpwd = cd(pathName);

dataMatrix = [];
%temp_2=[];
%temp=[];
mfccFiles = dir('*.mfcc');
for k=1: length (mfccFiles)
	temp_2=[];
	filename = mfccFiles(k).name;
	temp = csvread(filename);
	[temp_x,temp_y] = size(temp);
	random= randperm(temp_x);
	for i=1 : 500
		temp_2=[temp_2;temp(random(i),:)];
	end;
		
	dataMatrix = [dataMatrix;temp_2];
	clear temp temp_2 temp_x temp_y
end;

[m,n]= size(dataMatrix)

if (n == 13 )
	fprintf('Build the genre matrix\n');
else
	fprintf('ERROR: MFCC dimension mismatched\n');
end


cd(oldpwd)
csvwrite(sprintf('genre_models/%s',outputfile),dataMatrix);

fprintf('!!!!!!!!!!!!!!Done!!!!!!!!!!!!!!');
