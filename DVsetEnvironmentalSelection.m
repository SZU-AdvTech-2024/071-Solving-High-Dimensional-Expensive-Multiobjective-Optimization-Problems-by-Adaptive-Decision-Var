function [Nextobj,Nextdec] = DVsetEnvironmentalSelection(Popobj,Popdec,N)
% The environmental selection of distribution optimization in LMEA
%环境选择：先根据非支配排序去选（收敛性），然后再通过夹角去选（多样性）%

    %% Non-dominated sorting
    [FrontNo,MaxFNo] = NDSort(Popobj,N);
    Next = FrontNo < MaxFNo;

    %% Select the solutions in the last front
    Last   = find(FrontNo==MaxFNo);
    Choose = Truncation(Popobj(Last,:),N-sum(Next));
    Next(Last(Choose)) = true;
    % Population for next generation
    Nextobj = Popobj(Next,:);
    Nextdec = Popdec(Next,:);
end

function Choose = Truncation(PopObj,K)
% Select part of the solutions by truncation

    %% Calculate the normalized angle between each two solutions
    fmax   = max(PopObj,[],1);
    fmin   = min(PopObj,[],1);
    PopObj = (PopObj-repmat(fmin,size(PopObj,1),1))./repmat(fmax-fmin,size(PopObj,1),1);
    Cosine = 1 - pdist2(PopObj,PopObj,'cosine');
    Cosine(logical(eye(length(Cosine)))) = 0;
    
    %% Truncation
    % Choose the extreme solutions first
    Choose = false(1,size(PopObj,1)); 
    [~,extreme] = max(PopObj,[],1);
    Choose(extreme) = true;
    % Choose the rest by truncation
    if sum(Choose) > K
        selected = find(Choose);
        Choose   = selected(randperm(length(selected),K));
    else
        while sum(Choose) < K
            unSelected = find(~Choose);
            [~,x]      = min(max(Cosine(~Choose,Choose),[],2));
            Choose(unSelected(x)) = true;
        end
    end
end