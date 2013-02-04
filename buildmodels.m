clc
path='audio/AudioGenreData/extracted/features/';
genres=dir(path);

for(i=3:size(genres,1))
    disp(sprintf('genre=%s',genres(i).name));
    buildnormalizedgenre(sprintf('%s/%s/MFCC',path,genres(i).name),sprintf('%s.model',genres(i).name))
end

buildtrainingsplit(0.9)
