function [ponpath, stages] = load_test_files_IH(folder, job, inflflag)
ponpath = [folder '\' job];
if inflflag
    topLevelFolder = [folder '\Inflation\temp_pretest_Photos_1'];
else
    topLevelFolder = [folder '\' job '\Photos'];
end
tif_dir = dir([topLevelFolder,'\*.tif']);
stages = length(tif_dir)/2;


% % topLevelFolder = 
% % jFile = java.io.File(topLevelFolder); %java file object
% % jNames = jFile.list; %java string objects
% % for i = 1 : length(jNames)
% %     jNamesi = jNames(i);
% %     str = java.lang.String(jNamesi);
% %     if endsWith(str,'.lst')
% %         lstfile = char(str);
% %     end
% % end
% % if inflflag
% %     lstfile = [folder '\' job '\' 'temp_pretest_Photos_1\' lstfile];
% % else
% %     lstfile = [folder '\' job '\' job '_Photos_1\' lstfile];
% % end
% 
% d = dir(topLevelFolder);
% lst_ind = contains({d.name},'.lst');
% lstfile = [d(lst_ind).folder,'\',d(lst_ind).name];
% fid = fopen(lstfile);
% allText = textscan(fid,'%s','delimiter','\n');
% stages = 0.5*length(allText{1});
% fclose(fid);