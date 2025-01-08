function [MergeDec] = MergeSubpop(eachDec,Index,cycle,NumEsp,mu,Problem)
%用于将组内进化得到的低纬度解拼接成高纬度解，不过要记录归一化等数据处理的参数%

    MergeDec = zeros(mu,Problem.D);
    for j = 1 : cycle
        for i = 1 : NumEsp  
            MergeDec(:,Index{j}==i) = eachDec{i}; 
        end
    end
end