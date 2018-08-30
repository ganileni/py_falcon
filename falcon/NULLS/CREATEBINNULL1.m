% CREATEBINNULL1.m
% Part of the FALCON (Framework of Adaptive ensembLes for the Comparison Of
% Nestedness) package: https://github.com/sjbeckett/FALCON
% Last updated: 11th March 2014

function [MEASURES]=CREATEBINNULL1(MATRIX,numbernulls,measures,binNull,sortVar) %SS
%Swappable - Swappable null model
%has same dimensions and fill as original matrix,  but filled elements are
%randomly assigned independently of the initial ordering. The method presented
%ensures that matrices with zero rows/columns are not created and thus
%conserves the dimensions of the input matrix. Thus this null model is slightly more
%conservative than Test1 used in Staniczenko et al. 2013.

%PPA Staniczenko, JC Kopp, S Allesina. 2013.
%The ghost of nestedness in ecological networks
%Nature Communications 4(1391). (http://dx.doi.org/10.1038/ncomms2422)

[r,c]=size(MATRIX); %sizes of rows, columns


MEASURES = zeros(length(measures),numbernulls); %To store measure answers.


for aa = 1:numbernulls

TEST=0.*(MATRIX);% Matrix to fill in null model
LENr=1:r; %vector of rows
LENc=1:c;% vector of cols
count1=r; 
count2=c;

FILL=sum(sum(MATRIX>0));%Filled positions 
  

%stage1a - fill in 1 element for each row&col such that dimensions will be
%preserved (i.e. no chance of getting empty rows/cols and changing matrix
%dimensions).




while count1>0 && count2>0
   
    randa=randi(count1);
    randb=randi(count2);
    
    TEST(LENr(randa),LENc(randb))=1;
    
    LENr(randa)=[];
    LENc(randb)=[];
    
    count1=count1-1;
    count2=count2-1;
    FILL=FILL-1;
end

%stage1b - once all rows(cols) have something in, need to fill in cols
%(rows) with completely random rows(cols)

if count1>0
    while count1>0
        randa=1;
        randb=randi(c);
    
        TEST(LENr(randa),randb)=1;
        LENr(randa)=[];
        FILL=FILL-1;    
        count1=count1-1;
    end
elseif count2>0
    while count2>0
        randb=1;
        randa=randi(r);
    
        TEST(randa,LENc(randb))=1;
        LENc(randb)=[];
        FILL=FILL-1;  
        count2=count2-1;
    end
end

%stage2 - Once dimensions are conserved, need to add extra elements to
%preserve original matrix fill.

for d=1:FILL
    
    flag=0;
    while flag==0
       randa=randi(r);
       randb=randi(c);
       
       if TEST(randa,randb)==0
           TEST(randa,randb)=1;
           flag=1;
       end
    end
    
end



%stage 3 - sort this created matrix
[TEST,~]=sortMATRIX(TEST,binNull,sortVar);


%stage 4 - now save the measures of this matrix

for ww=1:length(measures)
    MEASURES(ww,aa) = measures{ww}(TEST);
end


end


end
