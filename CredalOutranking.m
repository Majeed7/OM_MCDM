function ranking = CredalOutranking(Alt,AltNames,W,criteria_type)

Alt = Alt ./ max(Alt); 
Alt(:,find(criteria_type == -1)) = 1 - Alt(:,find(criteria_type == -1));

[altNo,criNo] = size(Alt);

scores  = Alt*W';
ranking = zeros(altNo);

for i=1:altNo
    for j=1:altNo
        ranking(i,j) = length(find(scores(i,:) > scores(j,:)));
    end
end

ranking = ranking / size(W,1);

nonZeroProb = length(find(ranking > 0.5));
edgeTable = zeros(nonZeroProb,3);
counter = 1;
for i=1:altNo
    for j=1:altNo
        if ranking(i,j) > 0.5
           edgeTable(counter,:) = [i j ranking(i,j)];
           counter = counter+1;
        end
    end
end

directedGraph = ranking > .5;
set(0,'defaultAxesFontSize', 12,'defaultAxesFontWeight','b')
G = digraph(directedGraph);
p = plot(G,'k','NodeLabel',AltNames,'EdgeLabel',round(edgeTable(:,3),2));

p.Marker = 's';
p.NodeColor = 'r';
p.MarkerSize = 7;
%p.LineStyle = '--';
axis off
NameArray = {'linewidth','markersize'};
ValueArray ={1.8,10};
set(p,NameArray,ValueArray);
set(gcf,'color','w')

p.NodeLabel = '';
xd = get(p, 'XData');
yd = get(p, 'YData');
text(xd, yd, AltNames, 'FontSize',12, 'FontWeight','bold', 'HorizontalAlignment','right', 'VerticalAlignment','bottom')

C = {[0	255	255]/255,'r','g','b',[238 154 0]/255,[139 58 58]/255,[.2 .5 .7],[.6 .2 .7],[255 0 255]/255,[.5 .7 .2],'m','y'};
%C = C(1:altNo);
for j=1:min(length(AltNames),length(C))
    T = [];
    for i=1:size(G.Edges.EndNodes,1)
        if G.Edges.EndNodes(i,1) == j
           %T = [T;G.Edges.EndNodes(j,1:2)];
            highlight(p,G.Edges.EndNodes(i,1:2),'EdgeColor',C{j},'LineWidth',1.5)
        end
    end
    
end

end