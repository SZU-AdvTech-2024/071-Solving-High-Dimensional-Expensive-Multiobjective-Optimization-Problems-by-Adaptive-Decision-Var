# 写在前面
- 本次学习和复现的论文是Solving High-Dimensional Expensive Multiobjective Optimization Problems by Adaptive Decision
Variable Grouping，地址：https://ieeexplore.ieee.org/document/10485270  
- 复现代码参考自安徽大学团队开发的Evolutionary multi-objective optimization platform，地址：https://github.com/BIMK/PlatEMO  
# 关于代码
1. CalFitness.m：这个是从收敛性、多样性角度来计算一个比较各个解的适应度指标
2. CalFlag.m：通过计算HV和the summation of normalized objective values（Con）来决定下一代的stage
3. DimSelect.m：通过非支配排序选择收敛好的和坏的解，用于计算分组策略
4. DSelectNew.m：环境选择：先选择在各个目标上最好的（收敛性），然后再通过夹角去选（多样性）
5. DVsetEnvironmentalSelection.m：环境选择：先根据非支配排序去选（收敛性），然后再通过夹角去选（多样性）
6. EnvironmentalSelection.m：NSGA-Ⅱ中的环境选择，在本文是用于在组间进化时从Arc中选择个体进入组内进化
7. MergeSubpop.m：用于将组内进化得到的低纬度解拼接成高纬度解，不过要记录归一化等数据处理的参数
8. OperatorG.m：通过给定的父本来生成子代
9. SelectTrainData.m：用来从真实评估的历史数据中选择一些数据去训练代理模型
10. SubEnvironmentalSelection.m：通过非支配排序进行选择
11. AVGSAEA.m：这个是主流程，会调用其他的函数