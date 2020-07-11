            %% read in month x model x....
            %This function takes in the whole array (with lat, lon indeces) or
            %lat band and calculates corresponding area
%output=Datan
%output=output(1:65,1:end)
           % output=load('Model_1_lgm_Jan.m');
            %output=(output(0:31,:));
            %Takes a whole month, year or latitude band
          function [total_area]=flux(output);
            %%  format cell height by finding edges
            %height of half of each grid cell
            half_lat_diff=abs(output(2:end-1,1)-output(3:end,1))./2;
            %add this vector to the centers in order to get the centers:
            %ensures that the edges are at 90
            %%  latitude bands will start a various cell places away from the beginning of the vector (cell height= 'center height'
            
           if output(2,1)>=-89.5 && (output(end,1))>=89.5 %doesn't start at -90 but goes to 90
                    edges=[floor(output(2,1)); half_lat_diff+output(2:end-1,1);90];
           
           else if output(2,1)>=-89.5 && (output(end,1))<=89.5 
                    edges=[floor(output(2,1)); half_lat_diff+output(2:end-1,1);ceil(output(end,1))]; %somewhwere in the middle; creates an edge above and below
               else if  output(2,1)<=-89.5 && (output(end,1))<=89.5 %from -90 but goes to 90 
                       edges=[-90;half_lat_diff+output(2:end-1,1);ceil(output(end,1))];
                else  
                edges=[-90;half_lat_diff+output(2:end-1,1);90]; %advances by one to skip the zero placeholder
               end
               end
           end
            %% half-way point between each longitude value, create grid values
            
            if output(1,2)>0
            half_lon_len=(output(1,2:end-1)+output(1,3:end))./2;
            
            %add logic here
            longitude_grid=[0;half_lon_len(1:end)';360];
            else 
               half_lon_len=(output(1,2:end-1)+output(1,3:end))./2;
            
            %add logic here
            longitude_grid=[floor(output(1,2)); half_lon_len(1:end)' ;360];
            end
                    
            %% area calculations associated with each cell

            vector_y=abs((edges(1:end-1)-edges(2:end))); %difference between height values (height of each grid cell)
            cosign_lat=cos(output(3:end,1)*pi/180); %length of each grid cell varies with the cosine value at each latitude cell

            longitude_vector=abs(longitude_grid(2:end-1)-longitude_grid(3:end));%length of each grid cell
            total_length_x=cosign_lat*longitude_vector'*111325; %to get the acutal value of the length of each cell
            vector_y_1=[ vector_y]'*111325;%height of each grid cell

            %simplify
            vector_y=vector_y_1';
            %loop through entire array
            for j=1:length(longitude_vector);
                total_area(:,j)=vector_y.*total_length_x(:,j)
            end

            total_area(:,j); %for lat band etc.
            sae=sum(sum(total_area));%check calculation ~5.1*10^14 m^2=surface area of the earth
hae=sae/2
