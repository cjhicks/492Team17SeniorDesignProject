function [ spca_ncomps ] = doParallelAnalysis( dataset )
%UNTITLED Summary of this function goes here
%   Detailed explanation goes here

[realeval, evals, means, percentiles, spca_ncomps]=rawpar(dataset, 1, 2, 100, 90);

end

