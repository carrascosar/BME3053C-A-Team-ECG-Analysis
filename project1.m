clear;clc;
%importing data
ECG = input('Sample:','s');
T = readtable(ECG,'PreserveVariableNames',true);
T = table2array(T);
x = T(:,1)*(1/360);
y = T(:,2);
y_trim = y;
max_y = max(y_trim);
mean_y = mean(y);
thresh = mean_y + ((max_y-mean_y)/2);


%finding average BPM
num_peaks = length(findpeaks(y,'MinPeakDistance',120,'MinPeakProminence',150,'MaxPeakWidth',35));
bpm_avg = round(num_peaks/30);
fprintf('BPM: %d\n',bpm_avg);

%identifying brady/tachycardia
if bpm_avg > 100
    fprintf('Patient has tachycardia, Fast Heartrate\n')
elseif bpm_avg< 60
    fprintf('Patient has bradycardia, Slow Heartrate\n')
end

%finding running BPM for 10 second intervals, storing in vector bpms
bpms = [];
for ii = 2:1:180
    y10 = y(find(x==((ii-1)*10)):find(x==(ii*10)));
    peaks10 = findpeaks(y10);
    bpms(ii) = length(peaks10(peaks10>thresh))*6;
end
bpms(1)=[];

%identifying Atrial Premature Beat

bpm_high = max(bpms);
bpm_high_loc  = find(bpms == bpm_high);

if bpm_high >= bpm_avg*2
    fprintf('Patient has Irrregularity in Heart Rhythm, Shown in Figure\n')
    %plotting premature beat
    figure
    plot(x(find(x == 10*(bpm_high_loc-1)):find(x == 10*(bpm_high_loc+1))),y(find(x == 10*(bpm_high_loc-1)):(find(x == 10*(bpm_high_loc+1)))))
    title('Irregularity ECG')
    xlabel('Seconds')
    ylabel('MLII Millivolts')

    %begin text interaction
    pause(4)
    fprintf('Possible Conditions:')
    pause(1)
    fprintf('\nAtrial Premature Beat')
    pause(1)
    fprintf('\nAtrial Flutter')
    pause(1)
    fprintf('\nAtrial Fibrillation')
    pause(1)
    fprintf('\nVentricular Premature Beat')
    pause(1)
    fprintf('\nVentricular Flutter')
    pause(2)
    fprintf('\n\nRecommend Seeing a Doctor')
    pause(2)
    
    
%Conditon Info
check1 = 0;
check2 = 0;

while check1 == 0
ans1 = input('\n\nWould you like more information on any of the conditions above? Yes or No:','s');
        if isequal(ans1,'Yes')
        check1 = 1;
        while check2 == 0
        ans2 = input('\nWhich condition?:','s');
        check3 = 0;
                if isequal(ans2,'Atrial Premature Beat')
                fprintf('An atrial premature beat is an irregular heartbeat originating in one of the heart''s two nupper \nchambers, or Atria, which feed blood to the rest of the heart.It occurs when the heart''s electrical \nsystem does not return back to baseline after a beat, and instead triggers another one out of sync. \nCommonly referred to as the heart ''skipping a beat''. They can be completely harmless, with most \npeople experiencing them at some point in their life, but they can be of concern if they occur regularly \nas they can lead to other heart conditions.')
                pause(5)
                while check3 == 0
                    ans3 = input('\nWould you like information on another condition? Yes or No:','s');
                        if isequal(ans3,'Yes')
                        check3 = 1;
                        pause(1)
                        elseif isequal(ans3,'No')
                        check2 = 1; 
                        check3 = 1;
                        else
                        fprintf('Invalid Input')
                        pause(1)
                        end
                end
                elseif isequal(ans2,'Atrial Flutter')
                fprintf('Atrial flutter is described as a rhythmic, but rapid beating of one or more of the heart''s \nupper two chambers. When this occurs, the heart''s upper chambers do not work in sync with the lower \nchambers, causing a decrease in cardiac output, despite an increased heart rate. Though common, \nthis condition can be dangerous as it can spread to the heart''s lower chambers and eventually lead to \nstroke or heart failure, and thus must be corrected. Patients often describe feeling heart palpitations, \ndizziness, and shortness of breath.')
                pause(5)
                while check3 == 0
                ans3 = input('\nWould you like information on another condition? Yes or No:','s');
                    if isequal(ans3,'Yes')
                    check3 = 1;
                    pause(1)
                    elseif isequal(ans3,'No')
                    check3 = 1;
                    check2 = 1;
                    else
                    fprintf('Invalid Input')
                    pause(1)
                    end
                end
                elseif isequal(ans2,'Atrial Fibrillation')
                fprintf('Atrial fibrillation is described as an uncontrolled twitching of one or more of the heart''s \ntwo upper chambers, or Atria, and is caused by disorganized electrical signals in the heart. This \ncauses the upper chambers of the heart to not work in coordination with the lower chambers, leading \nto a significant decrease in cardiac output. This condition can be very dangerous as it can lead to \nheart failure or stroke. Patients often describe feeling chest pains, heart palpitations, fatigue, \nand shortness of breath.')
                pause(5)
                while check3 == 0
                ans3 = input('\nWould you like information on another condition? Yes or No:','s');
                    if isequal(ans3,'Yes')
                    pause(1)
                    check3 = 1;
                    elseif isequal(ans3,'No')
                    check3 = 1;
                    check2 = 1;
                    else
                    fprintf('Invalid Input')
                    pause(1)
                    end
                end
                elseif isequal(ans2,'Ventricular Premature Beat')
                fprintf('A ventricular premature beat is an irregular heartbeat originating in one of the heart''s lower \ntwo chambers, or Ventricles, which pump blood to the body. Patients commonly describe feeling a \nskipping or pounding in their chest. This condition is typically harmless, but can become dangerous \nif it is a regular occurrence as it can lead to other conditions or aggravate them.')
                pause(5)
                while check3 == 0
                ans3 = input('\nWould you like information on another condition? Yes or No:','s');
                    if isequal(ans3,'Yes')
                    check3 = 1;
                    pause(1)
                    elseif isequal(ans3,'No')
                    check3 = 1;
                    check2 = 1;
                    else
                    fprintf('Invalid Input')
                    pause(1)
                    end
                end
                elseif isequal(ans2,'Ventricular Flutter')
                fprintf('Ventricular flutter is described as the uncontrolled, rapid beating of the heart''s lower two \nchambers, or ventricles, which pump blood to the body. It is very dangerous, with the heart''s \nelectrical system losing most, if not all definition. Patients often describe feeling heart palpitations, \ndizziness, and shortness of breath. This condition is dangerous and it can often devolve into ventricular \nfibrillation, or a complete loss of coordination to the heart''s lower chambers. This can lead to death due \nto insufficient blood flow or heart failure.')
                pause(5)
                while check3 == 0
                ans3 = input('\nWould you like information on another condition? Yes or No:','s');
                    if isequal(ans3,'Yes')
                    check3 = 1;
                    pause(1)
                    elseif isequal(ans3,'No')
                    check3 = 1;
                    check2 = 1;
                    else
                    fprintf('Invalid Input')
                    pause(1)
                    end
                end
                else
                fprintf('Invalid Input')
                pause(1)
                end
                end
         elseif isequal(ans1,'No')
         check1=1;
         pause(1)
         else
         fprintf('Invalid Input')
         pause(1)
         end
         
end

fprintf('\nOkay thank you\n')

  
   
else
    %plotting normal ECG if healthy
    figure
    plot(x(1:7201),y(1:7201))
    title('ECG')
    xlabel('Seconds')
    ylabel('MLII Millivolts')
    fprintf('No Arrhythmias Detected!\n')
        
end

%for testing peaks
%findpeaks(y(100000:110800),'MinPeakDistance',120,'MinPeakProminence',180,'MaxPeakWidth',20)
