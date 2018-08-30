% InteractiveMode.m
% Part of the FALCON (Framework of Adaptive ensembLes for the Comparison Of
% Nestedness) package: https://github.com/sjbeckett/FALCON
% Last updated: 15th April 2014


% SHORT SCRIPT WHICH QUESTIONS USER TO ASSESS THE COMPUTATIONS THEY WISH TO
% RUN
g = genpath('../');
addpath(g);

%Q1. WHERE IS YOUR MATRIX? WHAT IS IT'S VARIABLE NAME?
flagQ1=1;

while flagQ1==1
reply1 = input('\n- Enter the variable name of the matrix you wish to test.\n If a variable is not yet assigned type "restart" and create\n a matrix variable before continuing, or type \n "generate" to generate a random matrix to test the code:\n\n', 's');

if strcmp(reply1,'restart')==1
    error('Exiting to allow user to create/import matrix.')
elseif strcmp(reply1,'generate')==1
    testflag=0; %generate a random matrix that is not degenerate - does not reduce to a empty/scalar/vector
    while testflag==0
    MATRIX=1.*rand(4,5)>0.45;
    TEST = sortMATRIX(MATRIX,1,1);
    testflag=1;
	if min(size(TEST))<=1 %If empty/scalar/vector - don't want!
            testflag = 0;
    	end
    end
    flagQ1=0;
else
    MATRIX=eval(reply1);
    flagQ1=0;
end
end

disp(MATRIX);

clear MEASURE

%Q - sort. Do you wish to sort the matrix or use predetermined sorting?
flagQsort=1;

while flagQsort==1
replyS = input('\n- Do you wish to use the current matrix ordering or sort to maximise nestedness?\n The way the matrix is ordered makes a difference to the NODF, DISCREPANCY\n and MANHATTAN DISTANCE measures.\n This choice is applied both to the input and null model matrices.\n Select 1 to sort or 0 to use current matrix ordering:\n\n', 's');

SORT = str2double(replyS);

if (SORT == 0) || (SORT == 1)
    flagQsort=0;
else
     disp(['Please answer the question properly.'])
end
    
end


%Q2. WHICH MEASURE(s) DO YOU WISH TO TEST?
flagQ2=1;
count=0;

while flagQ2==1
reply2 = input('\n- Which measure do you wish to use to measure nestedness? \n If unsure we suggest using NODF, one of the more popular nestedness measures.\n Select 1 for NODF , 2 for SPECTRAL RADIUS, 3 for MANHATTAN DISTANCE \n (used to calculate TAU-TEMPERATURE), 4 for JDMnestedness, 5 for NTC \n or 6 for DISCREPANCY.\n\n ', 's');

CHECKER=str2double(reply2);




if CHECKER==1
    count=count+1;
    MEASURE{count}='NODF';
    
    flag2a=1;
    while flag2a==1
	    reply2a = input('\n- Do you want to add another measure? (Y/N)', 's');
	    if strcmp(reply2a,'n') || strcmp(reply2a,'N') || strcmp(reply2a,'no') || strcmp(reply2a,'No') || strcmp(reply2a,'NO')
        	flagQ2=0;
            flag2a=0;
	    elseif strcmp(reply2a,'y') || strcmp(reply2a,'Y') || strcmp(reply2a,'yes') || strcmp(reply2a,'Yes') || strcmp(reply2a,'YES')
            flagQ2a=0;
	    else
		    disp('Please answer (Y/N)')
	    end
    end
elseif CHECKER==2
    count=count+1;
    MEASURE{count}='SPECTRAL_RADIUS';
    
    flag2a=1;
    while flag2a==1
        reply2a = input('\n- Do you want to add another measure? (Y/N)', 's');
        if strcmp(reply2a,'n') || strcmp(reply2a,'N') || strcmp(reply2a,'no') || strcmp(reply2a,'No') || strcmp(reply2a,'NO')
            flagQ2=0;
            flag2a=0;
        elseif strcmp(reply2a,'y') || strcmp(reply2a,'Y') || strcmp(reply2a,'yes') || strcmp(reply2a,'Yes') || strcmp(reply2a,'YES')
            flagQ2a=0;
        else
            disp('Please answer (Y/N)')
        end
    end
elseif CHECKER==3
    count=count+1;
    MEASURE{count}='MANHATTAN_DISTANCE';
    
    flag2a=1;
    while flag2a==1
        reply2a = input('\n- Do you want to add another measure? (Y/N)', 's');
        if strcmp(reply2a,'n') || strcmp(reply2a,'N') || strcmp(reply2a,'no') || strcmp(reply2a,'No') || strcmp(reply2a,'NO')
            flagQ2=0;
            flag2a=0;
        elseif strcmp(reply2a,'y') || strcmp(reply2a,'Y') || strcmp(reply2a,'yes') || strcmp(reply2a,'Yes') || strcmp(reply2a,'YES')
            flagQ2a=0;
        else
            disp('Please answer (Y/N)')
        end
    end
elseif CHECKER==4
    count=count+1;
    MEASURE{count}='JDMnestedness';
    
    flag2a=1;
    while flag2a==1
        reply2a = input('\n- Do you want to add another measure? (Y/N)', 's');
        if strcmp(reply2a,'n') || strcmp(reply2a,'N') || strcmp(reply2a,'no') || strcmp(reply2a,'No') || strcmp(reply2a,'NO')
            flagQ2=0;
            flag2a=0;
        elseif strcmp(reply2a,'y') || strcmp(reply2a,'Y') || strcmp(reply2a,'yes') || strcmp(reply2a,'Yes') || strcmp(reply2a,'YES')
            flagQ2a=0;
        else
            disp('Please answer (Y/N)')
        end
    end
elseif CHECKER==5
    count=count+1;
    MEASURE{count}='NTC';
    
    flag2a=1;
    while flag2a==1
        reply2a = input('\n- Do you want to add another measure? (Y/N)', 's');
        if strcmp(reply2a,'n') || strcmp(reply2a,'N') || strcmp(reply2a,'no') || strcmp(reply2a,'No') || strcmp(reply2a,'NO')
            flagQ2=0;
            flag2a=0;
        elseif strcmp(reply2a,'y') || strcmp(reply2a,'Y') || strcmp(reply2a,'yes') || strcmp(reply2a,'Yes') || strcmp(reply2a,'YES')
            flagQ2a=0;
        else
            disp('Please answer (Y/N)')
        end
    end
elseif CHECKER==6
    count=count+1;
    MEASURE{count}='DISCREPANCY';
    
    flag2a=1;
    while flag2a==1
        reply2a = input('\n- Do you want to add another measure? (Y/N)', 's');
        if strcmp(reply2a,'n') || strcmp(reply2a,'N') || strcmp(reply2a,'no') || strcmp(reply2a,'No') || strcmp(reply2a,'NO')
            flagQ2=0;
            flag2a=0;
        elseif strcmp(reply2a,'y') || strcmp(reply2a,'Y') || strcmp(reply2a,'yes') || strcmp(reply2a,'Yes') || strcmp(reply2a,'YES')
            flagQ2a=0;
        else
            disp('Please answer (Y/N)')
        end
    end

else
    disp(['Please answer the question properly.'])
end
end

% create text object of various measures
MEASURETEXT=[];
for pp= 1:length(MEASURE)
    MEASURETEXT = strcat(MEASURETEXT,{' '},MEASURE(pp));
end


%Q3. WHICH NULL MODELS DO YOU WISH TO TEST?
flagQ3=1;
null=[];
COUNT=0;
NULLTEXT={};

while flagQ3==1
reply3 = input('\n- Which null model do you wish to use to measure nestedness? \n If unsure you could try using 1, where size and fill are conserved but uniformly randomly shuffled.\n Select 1 for SS , 2 for FF, 3 for CC, 4 for DD, 5 for EE.\n\n ', 's');

CHECKER=str2double(reply3);

if CHECKER==1
    null=[null 1];
    COUNT=COUNT+1;
    NULLTEXT{COUNT} =  'SS';
    
    flag3a=1;
    while flag3a==1
        reply3a = input('\n- Do you want to add another null model? (Y/N)', 's');
        if strcmp(reply3a,'n') || strcmp(reply3a,'N') || strcmp(reply3a,'no') || strcmp(reply3a,'No') || strcmp(reply3a,'NO')
            flagQ3=0;
            flag3a=0;
        elseif strcmp(reply3a,'y') || strcmp(reply3a,'Y') || strcmp(reply3a,'yes') || strcmp(reply3a,'Yes') || strcmp(reply3a,'YES')
            flagQ3a=0;
        else
            disp('Please answer (Y/N)')
        end
    end
elseif CHECKER==2
    null=[null 2];
    COUNT=COUNT+1;
    NULLTEXT{COUNT} =  'FF';
    
    flag3a=1;
    while flag3a==1
        reply3a = input('\n- Do you want to add another null model? (Y/N)', 's');
        if strcmp(reply3a,'n') || strcmp(reply3a,'N') || strcmp(reply3a,'no') || strcmp(reply3a,'No') || strcmp(reply3a,'NO')
            flagQ3=0;
            flag3a=0;
        elseif strcmp(reply3a,'y') || strcmp(reply3a,'Y') || strcmp(reply3a,'yes') || strcmp(reply3a,'Yes') || strcmp(reply3a,'YES')
            flagQ3a=0;
        else
            disp('Please answer (Y/N)')
        end
    end
elseif CHECKER==3
    null=[null 3];
    COUNT = COUNT +1;
    NULLTEXT{COUNT} =  'CC';
   
    flag3a=1;
    while flag3a==1
        reply3a = input('\n- Do you want to add another null model? (Y/N)', 's');
        if strcmp(reply3a,'n') || strcmp(reply3a,'N') || strcmp(reply3a,'no') || strcmp(reply3a,'No') || strcmp(reply3a,'NO')
            flagQ3=0;
            flag3a=0;
        elseif strcmp(reply3a,'y') || strcmp(reply3a,'Y') || strcmp(reply3a,'yes') || strcmp(reply3a,'Yes') || strcmp(reply3a,'YES')
            flagQ3a=0;
        else
            disp('Please answer (Y/N)')
        end
    end
elseif CHECKER==4
    null=[null 4];
    COUNT= COUNT+1;
    NULLTEXT{COUNT} =  'DD';
    
    flag3a=1;
    while flag3a==1
        reply3a = input('\n- Do you want to add another null model? (Y/N)', 's');
        if strcmp(reply3a,'n') || strcmp(reply3a,'N') || strcmp(reply3a,'no') || strcmp(reply3a,'No') || strcmp(reply3a,'NO')
            flagQ3=0;
            flag3a=0;
        elseif strcmp(reply3a,'y') || strcmp(reply3a,'Y') || strcmp(reply3a,'yes') || strcmp(reply3a,'Yes') || strcmp(reply3a,'YES')
            flagQ3a=0;
        else
            disp('Please answer (Y/N)')
        end
    end
elseif CHECKER==5
    null=[null 5];
    COUNT=COUNT+1;
    NULLTEXT{COUNT} = 'EE';
    
    flag3a=1;
    while flag3a==1
        reply3a = input('\n- Do you want to add another null model? (Y/N)', 's');
        if strcmp(reply3a,'n') || strcmp(reply3a,'N') || strcmp(reply3a,'no') || strcmp(reply3a,'No') || strcmp(reply3a,'NO')
            flagQ3=0;
            flag3a=0;
        elseif strcmp(reply3a,'y') || strcmp(reply3a,'Y') || strcmp(reply3a,'yes') || strcmp(reply3a,'Yes') || strcmp(reply3a,'YES')
            flagQ3a=0;
        else
            disp('Please answer (Y/N)')
        end
    end
else
    disp(['Please answer the question properly.'])
end
end



%Q4. WHICH SOLVER DO WANT TO USE?

flagQ4=1;
while flagQ4==1
    
reply4 =input('\n- Are you happy to use the adaptive solver? Adaptive solver (Y), Fixed solver (N).\n\n','s');


    if strcmp(reply4,'y') || strcmp(reply4,'Y') || strcmp(reply4,'yes') || strcmp(reply4,'Yes') || strcmp(reply4,'YES')
        SOLVER='ADAPTIVE';
        ensembleNum=[];
        flagQ4=0;
    elseif strcmp(reply4,'n') || strcmp(reply4,'N') || strcmp(reply4,'no') || strcmp(reply4,'No') || strcmp(reply4,'NO')
        SOLVER='FIXED';
        flagQ5=1;
        
        while flagQ5==1
        reply = input('\n- How many null models do you want to test against?\n Literature tends to use between 1,000 and 10,000.\n\n');
        ensembleNum=reply;
    
            if ensembleNum>0
            flagQ5=0;
            else
            disp(['Please answer the question properly.'])
            end
        end
    
        flagQ4=0;
    else
        disp(['Please answer the question properly.'])
    end

end


text =(strcat('Now performing the calculations on ',{' '}, reply1, ' to find the ',{' '}, MEASURETEXT, ' score(s); and test it against null model(s) ',{' '}, NULLTEXT ,' using the ',{' '}, SOLVER ,' solver.'));
disp(text{1})
disp('Hold on whilst your output is calculated!')

ind=PERFORM_NESTED_TEST(MATRIX,1,SORT,MEASURE,null,ensembleNum,1);


text=strcat('Measure shows the ', MEASURETEXT, ' score(s), whilst pvalue shows how likely a more nested measure can be achieved by following the rules of the selected null model( 1 every time, 0 never).Mean shows the average measure from the null ensemble. Other statistics are also shown.');
disp(text{1})

for jj = 1:length(null)
    strcat('Output for binary null model',{' '},num2str(null(jj)),' (',NULLTEXT(jj),') is as follows:')
OUTPUT_top=eval(['ind.Bin_t' num2str(null(jj))])

for pp =1:length(MEASURE)
    OUTPUT = eval(['ind.Bin_t' num2str(null(jj)) '.measures{' num2str(pp) '}'])
end
end


if str2num(reply2)==3
    disp('The Tau-Temperature is shown here as the NormalisedTemperature and is calculated as Measure divided by Mean.')
    disp('Tau-Temperature above 1 indicates the matrix was less nested than expected, whilst below 1 indicates it was')
    disp('more nested than expected under the null ensemble.')
end

pause(2)

disp('The nested configuration of your input matrix is:')


NESTEDCONFIGURATION=ind.NestedConfig.DegreeMatrix

disp('You can access everything by typing in "ind" and navigating its structure')


