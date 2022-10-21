**Reduced and Improved Visibility Graph for Robot Path Planning**
Meshaal. Mouawad, *Department of Electrical and Computer Engineering, Mississippi State University

# Project Objectives

The objective of the project is to

-   Get familiar with Visibility Graph (VG) technique-based robot global path
    planning.

-   Apply the Visibility Graph technique of robot global path planning in
    workspace with a variety of obstacles.

-   Improve this Visibility Graph technique of robot path planning and attempt
    creation of Reduced Visibility Graph (RVG) algorithm.

# Project Requirements
understanding the basic of robotics and  global path planning.

# Running the code
Note:
- other files are helper files for the above main scripts
- To switch between the three environment configurations, comment the others in visible_graph.m (well documented and commented code)
- ECE8743_Visible_graph_Environment_1.m for Environment 1
- ECE8743_Visible_graph_Environment_2.m for Environment 2
- ECE8743_Visible_graph_Environment_3.m for Environment 3
- These three environments of files can be revsied from ECE8743_Visible_graph.m


# Introduction

VISIBILITY graph (VG) is one of the earliest motion planning algorithms and
notable as it is a **complete, optimal** algorithm for polygonal obstacles.
Visibility graph is a roadmap approach graph of intervisible locations,
typically for a set of points and obstacles in the *Euclidean plane*. Each
*vertex* in the graph represents a point location, whereas each *edge*
represents a *visible connection* between them. That is, if the line segment
connecting two vertices (locations) does not pass through any obstacle, an
*edge* is created between them in the graph. When the set of locations lies in a
line, this can be addressed as an ordered series [1]

The idea to construct visibility graph can be summarized in three steps:

1.  The *vertices* are the *start*, *destination*, and all *obstacle vertices*.

2.  The *edges* consist of all possible *collision-free line segments* and
    *obstacle edges*.

3.  The solution paths will pass directly through obstacle corners as shown in
    Fig. 1.
# The Roadmap Approach

This approach is dependent upon the concepts of configuration space and a
continuous path. A set of one-dimensional curves, each of which connect two
nodes of different polygonal obstacles, lie in the free space and represent a
roadmap *R* [3]. That is, all line segments that connect a vertex of one
obstacle to a vertex of another without entering the interior of any polygonal
obstacles are drawn [4]. This set of paths is called the roadmap [5]. If a
continuous path can be found in the free space of *R*, the initial and goal
points are then connected to this path to arrive at the final solution, a free
path. If more than one continuous path can be found and the number of nodes in
the graph is relatively small, Dijkstra's shortest path algorithm is often used
to find the best path [6].

There are various types of roadmaps, one of the earliest path planning methods
was the visibility graph method, explored by NJ Nilsson as early as 1969. A
visibility graph is shown in Fig. 1. [7]. The shaded areas represent obstacles.
The solid lines are the edges of the graph and connect the vertices of the
obstacles. The dotted lines connect the beginning and end configurations with
the roadmap.[8, 9]

# Visibility Graph Algorithms Procedure

**Shortest path in the graph is calculated using BFS**

