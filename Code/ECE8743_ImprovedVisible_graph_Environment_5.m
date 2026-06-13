
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%
% ECE8743 Advanced Robotics
% Visibility Graph based robot global path planning for static obstacles
% Evloved from Aditya Jain's codes
%
% Configued in Environment 3
%%
%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%

clc
close all
clear
tic
%% Defining environment variables
start = [180,180];     % start position
goal = [1800, 1800];   % goal position
n = 15;             % no. of obstacles

%% Defining the grid
figure

%%% 1st Config %%%%
% rectangle('Position',[20 10 40 30], 'FaceColor',[0 .5 .5])
% axis([0 100 0 100])
% axis square
% 
% hold on
% rectangle('Position',[50 60 20 20], 'FaceColor',[0 .5 .5])
%%%%%%%%%%%%%%%%%%%


%%% Environment 2 - 2nd Config
% rectangle('Position',[20 10 40 20], 'FaceColor',[0 .5 .5])
% axis([0 100 0 100])
% axis square

% rectangle('Position',[70 10 20 40], 'FaceColor',[0 .5 .5])
% rectangle('Position',[10 40 40 20], 'FaceColor',[0 .5 .5])
% rectangle('Position',[20 70 60 20], 'FaceColor',[0 .5 .5])
%%%%%%%%%%%%%


%%% 5th Config
% rectangle('Position',[20 10 20 20], 'FaceColor',[0 .5 .5])
% first polygon
T = ([374 210;500 375;864 22;440 15]);
tgon = polyshape(T);
% plot(tgon)
% hold on

% Second shape 
P = [0 584; 232 697;368 577; 248 438];
pgon = polyshape(P);
% plot(pgon)
% plot(tgon)
% hold on

% Third shape 
E = [ 573   637;
   699   644;
   831   513;
   659   371;
   579   513];
egon = polyshape(E);
% plot(Egon)

D = [  881  667;
  1063  685;
  1182  506;
  934  468];
dgon = polyshape(D);

F = [  1281  749;
  1252  644;
  1338  348;
  1440  528;
  1374  723];
fgon = polyshape(F);

G = [ 162  828;
  195  1101;
  308  1135;
  295  790];
ggon = polyshape(G);

H = [  434  869;
  526  1139;
  659  1199;
  603  787];
hgon = polyshape(H);

I = [ 897  963;
  818  1288
  917  1318
  1076  1187
  1089  914];
igon = polyshape(I);

J = [1182  1206
  1328  1273
  1440  1030
  1215  963];
jgon = polyshape(J);

 K= [1464  880
  1606  944
  1745  738
  1656  693];
kgon = polyshape(K);

L = [    1619  1067
  1695  1281
  2007  1202
  1884  966];
lgon = polyshape(L);

M = [ 119  1476
  281  1790
  394  1513
  311  1202
  179  1251];
mgon = polyshape(M);

N = [   579  1783
  626  1955
  798  1884
  877  1629];
ngon = polyshape(N);

O = [ 1089  1854
  1146  1891
  1377  1850
  1318  1532
  1182  1554];
ogon = polyshape(O);

Q = [ 1404  1663
  1487  1768
  1619  1479
  1450  1322];
qgon = polyshape(Q);

plot(egon)
hold on
plot(tgon)
hold on
plot(pgon)
hold on 
plot(dgon)
hold on
plot(fgon)
hold on
plot(ggon)
hold on
plot(hgon)
hold on
plot(igon)
hold on
plot(jgon)
hold on
plot(kgon)
hold on 
plot(lgon)
hold on 
plot(mgon)
hold on 
plot(ngon)
hold on
plot(ogon)
hold on
plot(qgon)
axis([0 2000 0 2000])
grid on

% Plotting start position
circles(start(1), start(2),0.5, 'facecolor','green')

% Plotting goal position
circles(goal(1), goal(2),0.5, 'facecolor','yellow')

%% initialising the hash map

%%% 1st Config
% keys = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j'};
% values = {start, [20,10], [20,40], [60,40], [60,10], [50,60], [50,80], [70,80], [70,60], goal};
%%%%%%%%%%%%%%%%%

%%% 2nd Config
% keys = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r'};
% values = {start, [20,10], [20,30], [60,30], [60,10], [10,40], [10,60], [50,60], [50,40], [70,10], [70,50], [90,50], [90,10], [20,70], [20,90], [80,90], [80,70], goal};
%%%%%%%%%%%%%%%%%

%%% 3rd Config
keys = {'a', 'b', 'c', 'd', 'e', 'f', 'g', 'h', 'i', 'j', 'k', 'l', 'm', 'n', 'o', 'p', 'q', 'r', 's', 't', 'u', 'v', 'w', 'x', 'y', 'z'...
    'aa','ab','ac','ad', 'ae', 'af', 'ag', 'ah', 'ai', 'aj', 'ak', 'al', 'am', 'an', 'ao', 'ap', 'aq', 'ar', 'as', 'at', 'au', 'av', 'aw', 'ax', 'ay','az'...
    'ba', 'bb', 'bc', 'bd', 'be', 'bf', 'bg', 'bh', 'bi', 'bj', 'bk', 'bl', 'bm', 'bn', 'bo'};
values = {start, [573   637],[699   644],[831   513],[659   371],[579   513]...
   [374   210],[500   375],[864    22],[440    15]...
   [30 584], [232 697],[368 577],[248 438]...
   [162  828],[195  1101],[308  1135],[295  790]...
   [881 667],[1063 685],[1182 506],[934 468]...
   [1281 749],[1252 644],[1338 348],[1440 528],[1374 723]...
   [434  869],[526  1139],[659  1199],[603  787]...
   [897  963],[818  1288],[917  1318],[1076  1187],[1089  914]...
   [1182  1206],[1328  1273],[1440  1030],[1215  963]...
   [1464  880],[1606  944],[1745  738],[1656  693]...
   [1619  1067],[1695  1281],[2007  1202],[1884  966]...
   [119  1476],[281  1790],[394  1513],[311  1202],[179  1251]...
   [579  1783],[626  1955],[798  1884],[877  1629]...
   [1089  1854],[1146  1891],[1377  1850],[1318  1532],[1182  1554]...
   [1404  1663],[1487  1768],[1619  1479],[1450  1322]...
   goal};
%%%%%%%%%%%%%%%%%
pp = length(values);

% for i = 1:pp
%     for j = 2:pp
%          temp = [values{1,i}(1), values{1,j}(1), values{1,i}(2), values{1,i+1}(2)];
%         edges = vertcat(edges, temp);   
% 
%     end 
% end 
%%%%%%%%%%%%%%%%%
Map = containers.Map(keys, values);
len = Map.values;
Map('j');


%% Building all the obstacle edges
length = size(keys);    % this contains the number of nodes

edges = [];

for i = 2:(length(2)-2)   
        temp = [values{1,i}(1), values{1,i+1}(1), values{1,i}(2), values{1,i+1}(2)];
        edges = vertcat(edges, temp);                
end


% Removing edges which are not obstacle edges
% sizeEdges = size(edges);
% i = 4;
% while i < (sizeEdges(1)-1)
%     [edges,ps] = removerows(edges,'ind',i);
%     sizeEdges = size(edges);
%     i = i + 3;
% end

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
        m1 = (q1(2)-p1(2))/(q1(1)-p1(1));%slope 
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
pair = [keys; values]; % this is used to find the corresonding letter with its point and what number it is on the list 
while i < (length(2)-2)
    
    G = rmedge(G,keys{i}, keys{i+2});
    G = rmedge(G,keys{i+1}, keys{i+3});
    i = i + 4;
end
% 
G = rmedge(G,keys{12}, keys{14});
G = rmedge(G,keys{11}, keys{16});
% G = rmedge(G,keys{17}, keys{8});
%  G = rmedge(G,keys{20}, keys{15});
% G = rmedge(G,keys{2}, keys{13});
% % G = rmedge(G,keys{9}, keys{12});

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

pairm = [keys; values];

toc
totalDis
%%%%%%%%%%%%%% end %%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
