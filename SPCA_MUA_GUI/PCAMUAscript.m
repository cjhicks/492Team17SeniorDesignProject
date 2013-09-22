%RUN FULL PCA-MUA from Scratch (2x3 designs only at this point)
Nsubs=#
Nconds=6
F3lab='Winner';
F3Clab={'Dealer','Bust','Player'};
F2lab='BetValue';
F2Clab={'high','low'};

[pcadata,subID]=PCAMUA_DataPrep(Nsubs,Nconds);
[PCAresults]=STPCA(pcadata,Nsubs,Nconds,0);
PCA_MUA_3x2(PCAresults,F3lab,F3Clab,F2lab,F2Clab)