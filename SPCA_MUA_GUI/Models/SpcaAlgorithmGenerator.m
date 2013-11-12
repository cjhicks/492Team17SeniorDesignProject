classdef SpcaAlgorithmGenerator
    %SPCAALGORITHMGENERATOR Summary of this class goes here
    %   Detailed explanation goes here
    
    properties
    end
    
    methods(Static)
        function [ spca_ncomps ] = doParallelAnalysis( dataset )
            [realeval, evals, means, percentiles, spca_ncomps]=SpcaAlgorithmGenerator.rawpar(dataset, 1, 2, 100, 90);
        end
        
        % Parallel Analysis Program For Raw Data and Data Permutations.
        function [realeval, evals, means, percentiles, ncomps]=rawpar(raw, kind, randtype, ndatsets, percent)
            tic;
            %  This program conducts parallel analyses on data files in which
            %  the rows of the data matrix are cases/individuals and the
            %  columns are variables; There can be no missing values;
            %  You must also specify:
            %   -- the # of parallel data sets for the analyses;
            %   -- the desired percentile of the distribution and random
            %      data eigenvalues;
            %   -- whether principal components analyses or principal axis/common
            %      factor analysis are to be conducted, and
            %   -- whether normally distributed random data generation or 
            %      permutations of the raw data set are to be used in the
            %      parallel analyses;

            %the next command can be used to set the state of the random # generator
            randn('state',1953125)
            
            % End of required user specifications.
            [ncases,nvars] = size(raw);

            % principal components analysis & random normal data generation
            if (kind == 1 & randtype == 1)
                realeval = flipud(sort(eig(corrcoef(raw))));%used to be corrcoef(raw)
                for nds = 1:ndatsets; evals(:,nds) = eig(corrcoef(randn(ncases,nvars)));end
            end
            
            % principal components analysis & raw data permutation
            if (kind == 1 & randtype == 2)
                wBar = waitbar(0,'Please wait, Performing Parallel Analysis...');
                count = 0;
                
                realeval = flipud(sort(eig(corrcoef(raw))));%used to be corrcoef(raw)
                for nds = 1:ndatsets; 
                    %nds
                    x = raw;
                    for lupec = 1:nvars;
                        for luper = 1:(ncases -1);
                            k = fix( (ncases - luper + 1) * rand(1) + 1 )  + luper - 1;
                            d = x(luper,lupec);
                            x(luper,lupec) = x(k,lupec);
                            x(k,lupec) = d;
                        end
                    end
                    evals(:,nds) = eig(corrcoef(x));
                    
                    count = count + 1;
                    waitbar(count/ndatsets);
                end
                close(wBar);
            end
            
            evals = flipud(sort(evals,1));
            means = (mean(evals,2));   % mean eigenvalues for each position.
            evals = sort(evals,2);     % sorting the eigenvalues for each position.
            percentiles = (evals(:,round((percent*ndatsets)/100)));  % percentiles.

            % figure
            % plot(realeval, 'r');
            % hold on
            % plot(means, 'b');
            % plot(percentiles, 'k');
            % title('Results of the Parallel Test')
            for i=1:length(realeval)
                if realeval(i)-means(i)<=0
                    ncomps=i-1;
                    break
                end
            end
        end
        
        % SpatioTemporal PCA function, calls spca (stripped of temporal for 
        % our purposes only
        function [STPCAresults]=STPCA(pcadata,Nsubs,Nconds)
            %Script to run spatiotemporal PCA
            %Author: Paul Kieffaber
            %Date:   2-26-04
            %NOTE:   SPCA and TPCA call varimax.m (written by Scott Makeig and
            %available through the EEGLab package) and doPromax.m (written by Joseph
            %Dien and available in Dien's PCA package)
            %------------------------------------------------------------------------
            %       MAKE SURE...
            %           1) data is named "pcadata"
            %           2) data structure is points([sub1condition1; sub1condition2 etc.]) X channels
            %------------------------------------------------------------------------
            %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %    USER DEFINED VARIABLES
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            % ms_start=0;%time (in ms) your data epoch starts
            % ms_stop=1000;%time your data epoch stops
            % srate=250;%sampling rate
            % analyze_start=0;%time (in ms) you want analysis to start
            % analyze_stop=1000;%time you want analysis window to stop
            pointspertrial=length(pcadata.time)%250;%# of points per epoch
            numsubjects=Nsubs;%103;%self explanatory
            numconditions=Nconds;%6;%also self explanatory
            nchans=size(pcadata.data,2)%129;%you guessed it!

            STPCAresults=struct;
            STPCAresults.time=pcadata.time;
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %Step 1:  Determine the number of components to retain based on Parallel Analysis
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %Step 2:  Run the Spatial PCA
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%5
            spca_ncomps=size(pcadata.data,2);%3;
            [STPCAresults.Spatial.scree,STPCAresults.Spatial.scores,STPCAresults.Spatial.loadings,STPCAresults.Spatial.VmxPat,STPCAresults.Spatial.VmxScr,STPCAresults.Spatial.varacc,STPCAresults.Spatial.PmxPat,STPCAresults.Spatial.PmxScr,STPCAresults.Spatial.pmaxvaracc,STPCAresults.Spatial.pmax_coeffs]=SpcaAlgorithmGenerator.SPCA(pcadata.data,spca_ncomps);

            %Compute grand-mean scores for each component
            PmxScr_mean=STPCAresults.Spatial.PmxScr';
            PmxScr_mean=reshape(PmxScr_mean,spca_ncomps,length(pcadata.time),size(STPCAresults.Spatial.PmxScr,1)/length(pcadata.time));
            PmxScr_mean=mean(PmxScr_mean,3);
            STPCAresults.Spatial.PmxScr_mean=PmxScr_mean;
            %clear PmxScr
            
            %Step 3 do temporal?
        end  
        
        %Spatial PCA Function
        function [scree,scores,loadings,VmxPat,VmxScr,varacc,PmxPat,PmxScr,pmaxvaracc,pmax_coeffs]=SPCA(data,Nfacs)
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
            %mean center the data
            
            wBar = waitbar(0,'Please wait, Performing Analysis...');
            count = 0;
            
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
            
            total = p*p*1.2;
            
            for i=1:p
                for j=1:p
                    X=corrcoef([data(:,i) scores(:,j)]);
                    loadings(i,j)=X(2,1);
                    count = count + 1;
                    waitbar(count/total);
                end
            end
            
            %Orthogonal Rotation of components
            [vmaxcoeffs,VmxPat]=SpcaAlgorithmGenerator.varimax(loadings(:,1:Nfacs)');
            VmxPat=VmxPat';
            
            count = count*1.2;
            waitbar(count/total)
            
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
            [PmxPat, PmxStr, phi, PmxRef, PmxScr] = SpcaAlgorithmGenerator.doPromax(VmxPat, VmxScr, 3);
            pmax_coeffs=R\PmxStr
            %compute variance accounted for by each promax-rotated component
            for i=1:Nfacs
                pmaxvaracc(i)=PmxPat(:,i)'*PmxPat(:,i);
            end
            pmaxtotalvar=sum(pmaxvaracc);
            for i=1:Nfacs
                pmaxvaracc(i)=pmaxvaracc(i)/pmaxtotalvar;
            end
            
            close(wBar);
        end
        
        % varimax rotation for Spatial PCA
        function [V,data] = varimax(data,tol,reorder)
            % varimax() - Perform orthogonal Varimax rotation on rows of a data
            %             matrix. (See also: runica(), pcasvd(), promax())
            % Usage:
            %             >>  V = varimax(data);
            % Output:
            %             V is the orthogonal rotation matrix, hence:
            %             >> rotdata = R*data;
            % Else,
            %             >> [V,rotdata] = varimax(data,tol);
            %             Set the termination tolerance to tol {default: 1e-4}
            % Or,
            %             >> [V,rotdata] = varimax(data,tol,'noreorder')
            %             Perform the rotation without component reorientation
            %             or reordering by size. This suppression is desirable
            %             when doing a q-mode analysis. {default|0|[] -> reorder}
            
            % Sigurd Enghoff - CNL / Salk Institute, La Jolla 6/18/98
            %
            % Reference: % Henry F. Kaiser (1958) The Varimx criterion for
            % analytic rotation in factor analysis. Pychometrika 23:187-200.
            %
            % modified to return V alone by Scott Makeig, 6/23/98
            if nargin < 1
                help varimax
                return
            end
            
            DEFAULT_TOL = 1e-4;  % default tolerance, for use in stopping the iteration
            DEFAULT_REORDER = 1; % default to reordering the output rows by size
            % and adjusting their sign to be rms positive.
            MAX_ITERATIONS = 50; % Default
            qrtr = .25;          % fixed value
            
            if nargin < 3
                reorder = DEFAULT_REORDER;
            elseif isempty(reorder) | reorder == 0
                reorder = 1; % set default
            else
                reorder = strcmp('reorder',reorder);
            end
            
            if nargin < 2
                tol = 0;
            end
            if tol == 0
                tol = DEFAULT_TOL;
            end
            if ischar(tol)
                fprintf('varimax(): tol must be a number > 0\n');
                help varimax
                return
            end
            
            eps1 = tol; % varimax toler
            eps2 = tol;
            
            V = eye(size(data,1)); % do unto 'V' what is done to data
            crit = [sum(sum(data'.^4)-sum(data'.^2).^2/size(data,2)) 0];
            inoim = 0;
            iflip = 1;
            ict = 0;
            
            %fprintf(...
                %'Finding the orthogonal Varimax rotation using delta tolerance %d...\n',...
                %eps1);
            while inoim < 2 & ict < MAX_ITERATIONS & iflip,
                iflip = 0;
                for j = 1:size(data,1)-1,
                    for k = j+1:size(data,1),
                        u = data(j,:).^2-data(k,:).^2;
                        v = 2*data(j,:).*data(k,:);
                        a = sum(u);
                        b = sum(v);
                        c = sum(u.^2-v.^2);
                        d = sum(u.*v);
                        
                        fden = size(data,2)*c + b^2 - a^2;
                        fnum = 2 * (size(data,2)*d - a*b);
                        
                        if abs(fnum) > eps1*abs(fden)
                            iflip = 1;
                            angl = qrtr*atan2(fnum,fden);
                            tmp    =  cos(angl)*V(j,:)+sin(angl)*V(k,:);
                            V(k,:) = -sin(angl)*V(j,:)+cos(angl)*V(k,:);
                            V(j,:) = tmp;
                            
                            tmp       =  cos(angl)*data(j,:)+sin(angl)*data(k,:);
                            data(k,:) = -sin(angl)*data(j,:)+cos(angl)*data(k,:);
                            data(j,:) = tmp;
                        end
                    end
                end
                
                crit = [sum(sum(data'.^4)-sum(data'.^2).^2/size(data,2)) crit(1)];
                inoim = inoim + 1;
                ict = ict + 1;
                
                %fprintf('#%d - delta = %g\n',ict,(crit(1)-crit(2))/crit(1));
                
                if (crit(1) - crit(2)) / crit(1) > eps2
                    inoim = 0;
                end
            end
            %
            %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
            %
            if reorder
                fprintf('Reordering rows...');
                [fnorm index] = sort(sum(data'.^2));
                V = V .* ((2 * (sum(data') > 0) - 1)' * ones(1, size(V,2)));
                data = data .* ((2 * (sum(data') > 0) - 1)' * ones(1, size(data,2)));
                V = V(fliplr(index),:);
                data = data(fliplr(index),:);
                fprintf('\n');
            else
                fprintf('Not reordering rows.\n');
            end
            
        end
        
        % promax rotation for Spatial PCA
        function [PmxPat, PmxStr, phi, PmxRef, PmxScr] = doPromax(VmxPat, VmxScr, k)
            %[PmxPat, PmxStr, phi, PmxRef, PmxScr] = doPromax(VmxPat, VmxScr, k)  - Compute promax rotation for PCA
            %  Gives similar results to SAS command: PROC FACTOR rot = promax
            %
            %Inputs
            %  VmxPat	: Varimax rotated factor loading matrix (variables, factors)
            %  VmxScr	: Varimax scores
            %  k		: Power to raise loadings to produce target matrix.  Higher power results in more oblique solutions.
            %				4 better for simple factor structures, 2 for more complex, 3 is a good compromise (SAS default value)
            %
            %Outputs
            %  PmxPat	: Factor pattern matrix
            %  PmxStr	: Factor structure matrix
            %  phi  : Correlations between factors
            %  PmxRef : Reference structure
            %  PmxScr : Promax factor scores
            %
            %History
            %
            %  With assistance from Lew Goldberg and Jack Digman.
            %
            %  First proposed by:
            %  Hendrickson, A. E. & White, P. O. (1964).  Promax: A quick method for
            %  rotation to oblique simple structure.  The British Journal of Statistical
            %  Psychology, 17:65-70.
            %
            %  Normalization process attributed to:
            %  Cureton, E. E., & D'Agostino, R. B. (1983). Factor Analysis: An applied approach. Hillsdale, NJ: Lawrence Erlbaum and Associates.
            %
            %  Harman, H. H.  (1976).  Modern factor analysis, 3rd edition.  Chicago:University of Chicago Press.
            %
            %  Gorsuch, R. L.  (1983).  Factor analysis, 2nd edition.  Hillsdale, NJ:Lawrence Erlbaum Associates.
            %
            %  Dillon, W. R. & Goldstein, M. (1984).  Multivariate analysis: Methods and applications.  New York:Wiley & Sons.
            %
            %  by Joseph Dien (4/99)
            %  Tulane University
            %  jdien@tulane.edu
            %
            %  12/7/00 JD
            %  Fixed error in promax algorithm.  Modified to output factor correlations and reference structure.
            %  Given the same varimax solution, now produces identical results to SAS 6 promax output.
            %
            %  modified (4/3/01) JD
            %  Added manual rotation of factor scores
            %
            %  bugfix 1/12/03 JD
            %  Fixed column-normalization of H to be on absolute value.
            
            NUM_FAC = size(VmxPat,2);	%Number of factors retained
            NUM_VAR = size(VmxPat,1);	%Number of variables
            
            H = diag(1./sqrt(sum(VmxPat'.^2)))*VmxPat;	%Normalize rows - equalize sum of squares of each variable's loadings
            H = H * diag(1./max(abs(H)));			%Column-normalize by highest absolute value in each column - tends to equalize factor sizes            
            H = H.^k;		%compute target matrix by taking higher power of factor loadings            
            H = abs(H) .* sign(VmxPat);		%add the signs back to the target matrix since even powers eliminate them        
            lambda = inv(VmxPat'*VmxPat) * VmxPat' * H;	%nonnormalized transformation matrix between starting factor matrix and reference vector (H & W, p. 66)          
            lambda = lambda*diag(1./sqrt(sum(lambda .^2)));		%Normalize the columns of lambda (H & W, p. 66)          
            PmxRef = VmxPat*lambda;	%generate reference structure (Harman, eq. 12.25, p. 272)          
            psi = lambda' * lambda;		%Correlations of reference vectors (Harman, eq. 12.29, p. 273)          
            r = inv(psi);					%Inverse of psi          
            D = diag(1./sqrt(diag(r)));	%relationship between reference and primary axes (Gorsuch, p. 226)          
            T = lambda*inv(D);  %Procrustean Transformation Matrix (Gorsuch, eq. 10.2.9, p. 226)           
            phi = inv(T)*inv(T)';	%Correlations between oblique primary factors (Gorsuch, eq. 10.1.15, p. 215)           
            PmxPat = VmxPat * T; 		%factor pattern matrix (Gorsuch, eq. 10.2.2, p. 220)           
            PmxStr = PmxPat * phi;	%factor structure matrix (Harman, eq. 12.19, p. 268)
            PmxScr = VmxScr * inv(T)';	%factor score matrix (Gorsuch, eq. 10.1.10, p. 215)
        end
    end
end
