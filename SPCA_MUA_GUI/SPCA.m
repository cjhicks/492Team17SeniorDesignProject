%Spatial PCA Function
%11/20/07
%----------------------------------
%INPUTS:
%   data = points/epoch*epochs*subjects BY channels
%   Nfacs = integer number of components you wish to retain (use Nfacs=size(data,2) for unrestricted PCA)
%
%OUTPUTS:
%   VmxPat = varimax rotated component loadings
%   scree = eigenvalues
%   varacc = variance accounted for by each component after varimax rotation
%   PmxPat = pattern matrix of promax-rotated component loadings
%   PmxScr = promax rotated component scores
%   pmaxvaracc = variance accounted for by each component after promax rotation
%   VmxScr = varimax rotated component scores
%   scores = unrotated component scores

function [scree,scores,loadings,VmxPat,VmxScr,varacc,PmxPat,PmxScr,pmaxvaracc,pmax_coeffs]=SPCA(data,Nfacs)
%mean center the data
data=data-[mean(data,1)'*ones(1,size(data,1))]';
%compute covariance matrix (nchans X nchans)
SCOV=cov(data);
%determine size of data matrix
[N,p]=size(data);
%recover singular values (sqrt(eigenvalues))
[U,L,loadings]=svd(SCOV);
%extract the eigenvalues
scree=diag(L).^2;
%compute the component scores
scores=data*loadings;
%compute the component "loadings" (i.e. the correlation between the data and the component)
for i=1:p
    for j=1:p
        X=corrcoef([data(:,i) scores(:,j)]);
        loadings(i,j)=X(2,1);
    end
end
%junk=loadings(:,1:Nfacs)'
%Orthogonal Rotation of components
[vmaxcoeffs,VmxPat]=varimax(loadings(:,1:Nfacs)');
VmxPat=VmxPat';
%compute standardized scoring coefficients and varimax-rotated component scores
R=corrcoef(data);
std_score_coeffs=R\VmxPat;
VmxScr=data*std_score_coeffs;
%Compute variance accounted for by each component.
for i=1:Nfacs
    varacc(i)=(VmxPat(:,i)'*VmxPat(:,i))/size(data,2);
end
cumvaracc=cumsum(varacc);
%Do promax rotation of component loadings
[PmxPat, PmxStr, phi, PmxRef, PmxScr] = doPromax(VmxPat, VmxScr, 3);
pmax_coeffs=R\PmxStr;
%compute variance accounted for by each promax-rotated component
for i=1:Nfacs
    pmaxvaracc(i)=PmxPat(:,i)'*PmxPat(:,i);
end
pmaxtotalvar=sum(pmaxvaracc);
for i=1:Nfacs
   pmaxvaracc(i)=pmaxvaracc(i)/pmaxtotalvar;
end
   


