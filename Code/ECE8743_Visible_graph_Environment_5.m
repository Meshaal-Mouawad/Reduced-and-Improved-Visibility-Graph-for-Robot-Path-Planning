
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% ECE8743 Advanced Robotics
% Visibility Graph based robot global path planning for static obstacles
% Evloved from Aditya Jain's codes
% Edited by Meshaal Mouawad 10/01/2021
% Visibility Graph for Enviroment 5
% Configued in Environment 5
% 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
clc
close all
clear
tic
%% Defining environment variables
start = [200,200];     % start position
goal = [1800, 1800];   % goal position
n = 2;             % no. of obstacles
%% Defining the grid
figure; hold on;
% Create obstacles 
ob1 = [410 0; 370 200; 500 390; 890 0];
ob2 = [210 410; 0 600; 200 700; 370 600];
ob3 = [190 820; 210 1100; 300 1160; 300 760];
ob4 = [210 1250; 160 1450; 270 1790; 400 1500; 300 1200];
ob5 = [640 390; 550 500; 550 610; 700 610; 810 500];
ob6 = [450 850; 500 1100; 650 1200; 630 790];
ob7 = [500 1800; 600 1950; 780 1900; 880 1620];
ob8 = [900 300; 850 600; 1100 650; 1220 350];
ob9 = [900 950; 810 1250; 920 1270; 1100 1190; 1100 880];
ob10 = [1300 380; 1250 650; 1300 780; 1400 750; 1430 500];
ob11 = [1210 900; 1180 1200; 1300 1250; 1400 1050];
ob12 = [1180 1550; 1100 1800; 1180 1850; 1390 1800; 1320 1500]; 
ob13 = [1610 530;1500 760; 1600 800;  1750 600]; 
ob14 = [1500 1350; 1450 1620; 1550 1750; 1670 1450]; 
ob15 = [1650 1090; 1750 1300; 1990 1200; 1900 1000];
g1 = polyshape(ob1); g2 = polyshape(ob2); g3 = polyshape(ob3);
g4 = polyshape(ob4); g5 = polyshape(ob5); g6 = polyshape(ob6);
g7 = polyshape(ob7); g8 = polyshape(ob8);
g9 = polyshape(ob9); g10 = polyshape(ob10);
g11 = polyshape(ob11);g12 = polyshape(ob12); g13=polyshape(ob13);
g14 = polyshape(ob14); g15=polyshape(ob15);
% Plotting start position
circles(start(1), start(2),0.3, 'facecolor','green');
% Plotting goal position
circles(goal(1), goal(2),0.3, 'facecolor','yellow');
%% plot the obstacles
plot(g1)
hold on 
plot(g2)
plot(g3)
plot(g4)
plot(g5)
plot(g6)
plot(g7);
plot(g8);
plot(g9);
plot(g10);
plot(g11);
plot(g12);
plot(g13);
plot(g14);
plot(g15);
grid on
axis([0 2000 0 2000])

%% initialising the hash map
%%% 1st Config
keys = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's','t','u','v','w','x','y','z'...
      'aa','ab','ac','ad', 'ae', 'af', 'ag', 'ah', 'ai', 'aj', 'ak', 'al', 'am', 'an', 'ao', 'ap', 'aq', 'ar', 'as', 'at', 'au', 'av', 'aw', 'ax', 'ay','az'...
    'ba', 'bb', 'bc', 'bd', 'be', 'bf', 'bg', 'bh', 'bi','bj'};
values = {start, [ob1(1,1) ob1(1,2)],[ob1(2,1) ob1(2,2)], [ob1(3,1) ob1(3,2)], [ob1(4,1) ob1(4,2)]...
   [ob2(1,1) ob2(1,2)], [ob2(2,1) ob2(2,2)], [ob2(3,1) ob2(3,2)], [ob2(4,1) ob2(4,2)]...
    [ob3(1,1) ob3(1,2)], [ob3(2,1) ob3(2,2)], [ob3(3,1) ob3(3,2)], [ob3(4,1) ob3(4,2)]...
   [ob4(1,1) ob4(1,2)], [ob4(2,1) ob4(2,2)], [ob4(3,1) ob4(3,2)], [ob4(4,1) ob4(4,2)]...
   [ob5(1,1) ob5(1,2)], [ob5(2,1) ob5(2,2)], [ob5(3,1) ob5(3,2)] [ob5(4,1) ob5(4,2)]...
   [ob6(1,1) ob6(1,2)], [ob6(2,1) ob6(2,2)], [ob6(3,1) ob6(3,2)], [ob6(4,1) ob6(4,2)]...
   [ob7(1,1) ob7(1,2)], [ob7(2,1) ob7(2,2)], [ob7(3,1) ob7(3,2)], [ob7(4,1) ob7(4,2)]...
   [ob8(1,1) ob8(1,2)], [ob8(2,1) ob8(2,2)], [ob8(3,1) ob8(3,2)], [ob8(4,1) ob8(4,2)]...
   [ob9(1,1) ob9(1,2)], [ob9(2,1) ob9(2,2)], [ob9(3,1)  ob9(3,2)], [ob9(4,1) ob9(4,2)]...
   [ob10(1,1) ob10(1,2)], [ob10(2,1) ob10(2,2)], [ob10(3,1) ob10(3,2)], [ob10(4,1) ob10(4,2)]...
   [ob11(1,1) ob11(1,2)], [ob11(2,1) ob11(2,2)], [ob11(3,1) ob11(3,2)], [ob11(4,1) ob11(4,2)]...
   [ob12(1,1) ob12(1,2)], [ob12(2,1) ob12(2,2)], [ob12(3,1) ob12(3,2)], [ob12(4,1) ob12(4,2)]...
   [ob13(1,1) ob13(1,2)], [ob13(2,1) ob13(2,2)], [ob13(3,1) ob13(3,2)], [ob13(4,1) ob13(4,2)]...
   [ob14(1,1) ob14(1,2)], [ob14(2,1) ob14(2,2)], [ob14(3,1) ob14(3,2)], [ob14(4,1) ob14(4,2)]...
   [ob15(1,1) ob15(1,2)], [ob15(2,1) ob15(2,2)], [ob15(3,1) ob15(3,2)], [ob15(4,1) ob15(4,2)],goal};
%%%%%%%%%%%%%%%%%
Map = containers.Map(keys, values);
len = Map.values;
Map('j');
%% Building all the obstacle edges
lenNode = size(keys);    % this contains the number of nodes
edges = [];
for i = 2:(lenNode(2)-2)   % start from the second point (forst point is start point)
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
while i < lenNode(2)-2    
    temp = [values{1,i}(1), values{1,i+3}(1), values{1,i}(2), values{1,i+3}(2)];
    edges = vertcat(edges, temp);
    i = i + 4;    
end
%% Calculating the valid edges and adding them to the graph
ledgeSize = size(edges);
noEdges = ledgeSize(1);
G = graph();
for i = 1:lenNode(2)    
    for j = (i + 1):lenNode(2)        
        % find equation of the edge to be checked
        p1 = values{1,i};
        q1 = values{1,j};
        m1 = (q1(2)-p1(2))/(q1(1)-p1(1));
        c1 = p1(2) - m1*(p1(1));
        
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
            end

        end
        if flag==1
            G = addedge(G,keys{i}, keys{j});
        end
                
    end    
end

%% Removing the diagonals of the obstacle from the visible edges
lenNode = size(keys);    % this contains the number of nodes
i = 2;

while i < (lenNode(2)-2)
    G = rmedge(G,keys{i}, keys{i+2});
    G = rmedge(G,keys{i+1}, keys{i+3});
    i = i + 4;
end

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
path = shortestpath(G, keys{1}, keys{lenNode(2)});
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
totalDis;