%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Simulation is NOT complete, as I did not account for forces on each atom 
% from its second nearest neighbor
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clc
clear
close all

num_atoms = 5;
spacing = 1;

%% display atoms and initialize positions

for i = 1:num_atoms
    if i == 1
        pos(1) = spacing; 
    else
        pos(i) = pos(i-1) + spacing;
    end
  
    plot(pos(i),0,'.r','MarkerSize',69)
    hold on;
    
    x_0(i) = pos(i);
end

xlim([0 pos(num_atoms)+spacing]);

for i = 1:num_atoms
    plot(pos(i),0,'.w','MarkerSize',69);
    pos(i) = pos(i) + unifrnd(-0.5,0.5);
    plot(pos(i),0,'.r','MarkerSize',69);
end

%% calculate forces and displacements

delta_t = 0.5;
m = 1; % mass of atom
k = 1; % spring constant

for i = 1:1000
    
    if i == 1
        [F,v,d] = hooke(k,pos,x_0,m,delta_t,0); 
    else
        [F,v,d] = hooke(k,pos,x_0,m,delta_t,v); 
    end
    
    for j = 1:num_atoms
        plot(pos(j),0,'.w','MarkerSize',69)   
        pos(j) = pos(j) + d(j);
        plot(pos(j),0,'.r','MarkerSize',69)
    end
    
    for j = 1:num_atoms
        if i > 1
            delete(anArrow(j));
        end
        anArrow(j) = annotation('arrow') ;
        anArrow(j).Parent = gca;
        anArrow(j).Position = [pos(j), 0, F(j)*5, 0];
    end
   
    drawnow limitrate
    pause(0.0001)
    
end

