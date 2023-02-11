# MAPF_Problem
Seminar project

Team: Lkhagvasuren Rentsenbyamba, Felix Kratzsch 
## Project: MAPF with pruning in ASP
### Goal
Using ASP to simplify and solve MAPF instances.

### Encoding
 Our encoding was based on the paper [1], which we discussed in the seminar. All given instances are solved by our solver with and without pruning. We considered a vertex and edge (swap) conflicts that agents are not allowed to possess a same vertex or swapping positions at same time. 
 
 For the prunning, we did not take the idea of the paper [1]. Instead, we just implemented reachable vertices from start positions to end postions, so that we can constrain the unreacheable verticies. Interestingly, the given instances are solved with the pruning slower than the solver without pruning. May be, it is because of the given instances are not enough to prune. 

### Usages

### References 
1.    Husár, M., Švancara, J., Obermeier, P., Bart ́ak, R., Schaub, T.: Reduction-based
   Solving of Multi-agent Pathfinding on Large Maps Using Graph Pruning. AAMAS
   2022, May, Online. (2022).

### Sources
**Asprilo vizualiser:** https://asprilo.github.io/visualizer/
