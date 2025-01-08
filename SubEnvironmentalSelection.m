function Next = SubEnvironmentalSelection(PopObj,N)
%通过非支配排序进行选择%


    %% Non-dominated sorting
    Next = false(size(PopObj,1),1);
    Con  = calCon(PopObj);
    [~,Rank] = sort(Con);
    Next(Rank(1:N)) = true;    
end

function Con = calCon(PopObj)
% Calculate the convergence of each solution

    FrontNo = NDSort(PopObj,inf);
    Con     = sum(PopObj,2);
    Con     = FrontNo'*(max(Con)-min(Con)) + Con;
end