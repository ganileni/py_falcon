% NODF.m
% Part of the FALCON (Framework of Adaptive ensembLes for the Comparison Of
% Nestedness) package: https://github.com/sjbeckett/FALCON
% Last updated: 21st December 2013

function [MEASURE]=NODF(MATRIX)
%NODF stands for nestedness by overlap and decreasing fill and is described
%in Almeida-Neto et al., 2008.

%M Almeida‐Neto, P Guimaraes, PR Guimaraes Jr, RD Loyola, W Ulrich. 2008.
%A consistent metric for nestedness analysis in ecological systems: reconciling concept and measurement
%Oikos 117(8): 1227 - 1239. (http://dx.doi.org/10.1111/j.0030-1299.2008.16644.x)


rows=size(MATRIX,1);
cols=size(MATRIX,2);



colN=zeros(cols,cols);
rowN=zeros(rows,rows);

%Find NODF column score
for i=1:cols-1
	for j=i+1:cols
		if sum(MATRIX(:,i)>0)>sum(MATRIX(:,j)>0)
		count=0;
			for k=1:rows
				if MATRIX(k,i)>0 && MATRIX(k,j)>0
                    count=count+1;
                end   
            end
		colN(i,j)=count/(sum(MATRIX(:,j)>0));
		end
	end
end

colN=100.*colN;

NODF_COL = 2*sum(sum(colN))/(cols*(cols-1));

%Find NODF row score
for i=1:rows-1
	for j=i+1:rows
		if sum(MATRIX(i,:)>0)>sum(MATRIX(j,:)>0)
		count=0;
			for k=1:cols
				if MATRIX(i,k)>0 && MATRIX(j,k)>0					
					count=count+1;
				end
            end
		rowN(i,j)=count/(sum(MATRIX(j,:)>0));
		end
	end
end


rowN=rowN.*100;

NODF_ROW = 2*sum(sum(rowN))/(rows*(rows-1));

%Find NODF
NODF=2*(sum(sum(rowN))+sum(sum(colN)))/(cols*(cols-1) +rows*(rows-1) );


MEASURE=NODF;

end
