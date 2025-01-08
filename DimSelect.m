function [better_Cpop,bad_Cpop] = DimSelect(Population,N)
%通过非支配排序选择收敛好的和坏的解，用于计算分组策略%

    PopObj          = Population.objs;
    [Convergence,~] = CalFitness(PopObj);
    [~,Cidx]        = sort(Convergence);
    better_Cpop     = Population(Convergence==0);
    temple          = length(Convergence)-N+1;
    bad_Cpop        = Population(Cidx(temple:end));
end