%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% ECE8743 Advanced Robotics
% Visibility Graph based robot global path planning for static obstacles
% Evolved from Aditya Jain's codes
%Reduced Visibility graph
% Configured in Environment 2
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

clc
close all
clear
tic
%% Defining environment variables
start = [4,4];     % start position
goal = [90, 85];   % goal position
n = 2;             % no. of obstacles

%% Defining the grid
figure

%%% Environment 2 - 2nd Config
rectangle('Position',[20 10 40 20], 'FaceColor',[0 .5 .5])
axis([0 100 0 100])
axis square

rectangle('Position',[70 10 20 40], 'FaceColor',[0 .5 .5])
rectangle('Position',[10 40 40 20], 'FaceColor',[0 .5 .5])
rectangle('Position',[20 70 60 20], 'FaceColor',[0 .5 .5])

% Plotting start position
hold on;
plot(start(1), start(2), 'go', 'MarkerFaceColor', 'green', 'MarkerSize', 8); % Green circle

% Plotting goal position
plot(goal(1), goal(2), 'yo', 'MarkerFaceColor', 'yellow', 'MarkerSize', 8); % Yellow circle

%% Initialising the hash map
keys = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r'};
values = {start, [20,10], [20,30], [60,30], [60,10], [10,40], [10,60], [50,60], [50,40], [70,10], [70,50], [90,50], [90,10], [20,70], [20,90], [80,90], [80,70], goal};

Map = containers.Map(keys, values);
len = Map.values;

%% Building all the obstacle edges
length = size(keys);    % this contains the number of nodes
edges = [];

for i = 2:(length(2)-2)   
        temp = [values{1,i}(1), values{1,i+1}(1), values{1,i}(2), values{1,i+1}(2)];
        edges = vertcat(edges, temp);                
end

% Adding 1 edge pair in each obstacle which were not added in the earlier
% for loop
i = 2;
while i < length(2)-2    
    temp = [values{1,i}(1), values{1,i+3}(1), values{1,i}(2), values{1,i+3}(2)];
    edges = vertcat(edges, temp);
    i = i + 4;    
end

%% Calculating the valid edges and adding them to the graph
ledgeSize = size(edges);
noEdges = ledgeSize(1);

G = graph();

for i = 1:length(2)    
    for j = (i + 1):length(2)        
        % find equation of the edge to be checked
        p1 = values{1, i};
        q1 = values{1, j};
        
        % Skip identical points
        if p1(1) == q1(1) && p1(2) == q1(2)
            continue; 
        end
        
        % Check for intersection with any obstacles
        flag = 1; % Assume edge is valid unless proven otherwise
        for k = 1:noEdges
            ed = edges(k,:);            
            if isIntersecting(p1, q1, ed(1:2), ed(3:4))
                flag = 0; % Edge intersects an obstacle
                break;
            end
        end
        
        % Add edge if valid
        if flag
            G = addedge(G, keys{i}, keys{j});
        end
    end    
end

%% Function to check intersection between two line segments
function intersects = isIntersecting(p1, q1, p2, q2)
    % Calculate the direction of each point
    d1 = direction(p1, q1, p2);
    d2 = direction(p1, q1, q2);
    d3 = direction(p2, q2, p1);
    d4 = direction(p2, q2, q1);
    
    % Check if the segments straddle each other
    intersects = (d1 * d2 < 0) && (d3 * d4 < 0);
end

%% Function to calculate direction
function dir = direction(p1, q1, p2)
    dir = (p2(1) - p1(1)) * (q1(2) - p1(2)) - (p2(2) - p1(2)) * (q1(1) - p1(1));
end

%% Debugging: Print the edges in the graph
disp('Current edges in the graph:');
disp(G.Edges);

%% Debugging: Print the nodes in the graph
disp('Current nodes in the graph:');
disp(G.Nodes.Name);

%% Plotting all the visible edges
visEd = G.Edges;  
sizeEd = size(G.Edges);

for i=1:sizeEd(1)
   x = visEd(i,1);
   xx = x{1,1};
   p1 = Map(xx{1,1});
   p2 = Map(xx{1,2});
   xpoints = [p1(1,1), p2(1,1)];
   ypoints = [p1(1,2), p2(1,2)];
   hold on
   plot(xpoints, ypoints, 'b')
end

%% Finding the shortest path in the graph and printing it 
path = shortestpath(G, keys{1}, keys{length(2)});
if isempty(path)
    disp('No path found between start and goal.');
else
    pathSize = size(path);
    totalDis = 0; 

    % Plot the shortest path
    for i=1:pathSize(2)-1
        p1 = Map(path{i});
        p2 = Map(path{i+1});

        totalDis = totalDis + EuclDist(p1,p2);

        xpoints = [p1(1,1), p2(1,1)];
        ypoints = [p1(1,2), p2(1,2)];
        hold on
        plot(xpoints, ypoints, 'k', 'LineWidth', 3) % Plot the path in black
        title('Reduced Visibility Graph')
    end
    disp(['Total distance: ', num2str(totalDis)]);
end

toc
totalDis

%% Function to calculate Euclidean distance
function d = EuclDist(p1, p2)
    d = sqrt((p2(1) - p1(1))^2 + (p2(2) - p1(2))^2);
end

%%%%%%%%%%%%%% end %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%