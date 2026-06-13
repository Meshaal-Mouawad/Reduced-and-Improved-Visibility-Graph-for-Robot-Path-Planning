
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% ECE8743 Advanced Robotics
% Visibility Graph based robot global path planning for static obstacles
% Evloved from Aditya Jain's codes
% edited by: Meshaal Mouawad 09/29/2021
% Configued in Environment 4 for map 1
%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
%
%
clc
close all
clear
tic
%% Defining environment variables
start = [0.5,15.5];     % star
goal = [15.5, 0.5];     % goal position
n = 2;                  % no. of obstacles

%% Defining the grid
[X,Y]=meshgrid(0:16);
figure; hold on;
plot(X,Y,'k');
plot(Y,X,'k');axis on

axis([0 16 0 16]);
axis square
Ob2 = [1 3 3 3];
Ob3 = [5 1 4 1];
Ob4 = [7 6 2 4];
Ob5 = [8 13 1 3];
Ob6 = [11 0 2 8];
Ob7 = [12 11 3 3];
rectangle('Position',[2 8 2 8], 'FaceColor',[0 0 0])% creates a rectangle  [x y w h]
% axis([0 100 0 100])
rectangle('Position',Ob2, 'FaceColor',[0 0 0])
rectangle('Position',Ob3, 'FaceColor',[0 0 0])
rectangle('Position',Ob4, 'FaceColor',[0 0 0])
rectangle('Position',Ob5, 'FaceColor',[0 0 0])
rectangle('Position',Ob6, 'FaceColor',[0 0 0])
rectangle('Position',Ob7, 'FaceColor',[0 0 0])
% Plotting start position
circles(start(1), start(2),0.3, 'facecolor','green')
% Plotting goal position
circles(goal(1), goal(2),0.3, 'facecolor','yellow')

%% initialising the hash map
cor1 = [2,8];
cor2 = [2,16];
cor3 = [4,16];
cor4 = [4,8];

cor5 = [1,3];
cor6 = [1,6];
cor7 = [4,6];
cor8 = [4,3];

cor9 = [5,1];
cor10 = [5,2];
cor11 = [9,2];
cor12 = [9,1];

cor13 = [7,6];
cor14 = [7,10];
cor15 = [9,10];
cor16 = [9,6];

cor17 = [8,13];
cor18 = [8,16];
cor19 = [9,16];
cor20 = [19,13];

cor21 = [11,0];
cor22 = [11,8];
cor23 = [13, 8];
cor24 = [13. 0];

cor25 = [12, 11];
cor26 = [12, 14];
cor27 = [15, 14];
cor28 = [15, 11];
%%% 3rd Config
keys = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z', 'aa','ab','ac','ad'};
values = {start, cor1, cor2, cor3, cor4, cor5, cor6, cor7, cor8, cor9, cor10, cor11, cor12, cor13, cor14, cor15, cor16, cor17, cor18, cor19, cor20, cor21, cor22, cor23, cor24, cor25, cor26, cor27, cor28,goal};
% values = {start, , [20,30], [40,30], [40,10], [50,5], [50,25], [65,25], [65,5], [70,10], [70,30], [90,30], [90,10], [10,40], [10,60], [30,60], [30,40], [40,40], [40,60], [75,60], [75,40], [80,35], [80,75], [95,75], [95,35], [10,70], [10,90], [15,90], [15,70], [20,70], [20,90], [40,90], [40,70], [50,65], [50,90], [70,90], [70,65], goal};
%%%%%%%%%%%%%%%%%

Map = containers.Map(keys, values);
len = Map.values;
Map('ad');


%% Building all the obstacle edges
length = size(keys);    % this contains the number of nodes
edges = [];
for i = 2:(length(2)-2)   
        temp = [values{1,i}(1), values{1,i+1}(1), values{1,i}(2), values{1,i+1}(2)];
        edges = vertcat(edges, temp);                
end


% Removing edges which are not obstacle edges
sizeEdges = size(edges);
i = 4;
while i < (sizeEdges(1)-1)
    [edges,ps] = removerows(edges,'ind',i);
    sizeEdges = size(edges);
    i = i + 3;
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
        p1 = values{1,i};
        q1 = values{1,j};
        m1 = (q1(2)-p1(2))/(q1(1)-p1(1));
        c1 = p1(2) - m1*(p1(1));
        %%%%%%%%%%%%
    
        flag = 1;    % flag to check if the edge has any intersection with any other edge;
                     % '1' means no intersection
        % need to compare with the edges   
        for k = 1:noEdges
            
            ed = edges(k,:);            
            m2 = (ed(4) - ed(3))/(ed(2) - ed(1));
            if(ed(2)==ed(1))
                m2 = 1e+10;
            end
            c2 = ed(3) - m2*ed(1);  
            
            if m1==m2 %% ignoring 
                t = 1;
            else
                
                %%%%%%
                temp1 = ed(3) - m1*ed(1) - c1;
                temp2 = ed(4) - m1*ed(2) - c1;
                
                temp3 = p1(2) - m2*p1(1) - c2;
                temp4 = q1(2) - m2*q1(1) - c2;
                
                if (sign(temp1) ~= sign(temp2)) &&  sign(temp1)~=0 && sign(temp2)~=0 && (sign(temp3) ~= sign(temp4)) &&  sign(temp3)~=0 && sign(temp4)~=0
                    flag = 0;
                    break
                end
                %%%%%%
            end

        end
        if flag==1
            G = addedge(G,keys{i}, keys{j});
        end
                
    end    
end

%% Removing the diagonals of the obstacle from the visible edges
length = size(keys);    % this contains the number of nodes
i = 2;

while i < (length(2)-2)
    
    G = rmedge(G,keys{i}, keys{i+2});
    G = rmedge(G,keys{i+1}, keys{i+3});
    i = i + 4;
end

% G = rmedge(G,keys{15}, keys{32});
% G = rmedge(G,keys{14}, keys{33});
% G = rmedge(G,keys{15}, keys{4});
% G = rmedge(G,keys{14}, keys{5});
% G = rmedge(G,keys{10}, keys{25});
% G = rmedge(G,keys{9}, keys{12});

%% Plotting all the visible edges

visEd = G.Edges;  % this has the visible edges
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

%% finding the shortest path in the graph and printing it 

path = shortestpath(G, keys{1}, keys{length(2)});
pathSize = size(path);

totalDis = 0;    % this will contain the total distance in units for the final selected path

for i=1:pathSize(2)-1
    p1 = Map(path{i});
    p2 = Map(path{i+1});
    
    totalDis = totalDis + EuclDist(p1,p2);
    
    xpoints = [p1(1,1), p2(1,1)];
    ypoints = [p1(1,2), p2(1,2)];
    hold on
    plot(xpoints, ypoints, 'k', 'LineWidth', 3)
    title('Visibility Graph')
end

toc
totalDis
%%%%%%%%%%%%%% end %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
