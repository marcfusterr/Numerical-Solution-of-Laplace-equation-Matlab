tic
%%Declaraci� de variables
N=30; %Espai d'estudi Real
C=6; %Costat del quadrat (ha de ser parell)
C=C/2;
Vquadrat=1; %Potencial del quadrat, 1 per normalitzaci�.
    
%Creaci� de la matriu
    V=zeros(N,N);
%Cond.Cont del quadrat interior   
    V((((end/2-C)):(end/2)+C),((end/2-C)):end/2+C)=Vquadrat;  
%Cond.Cont dels extrems
%Al ser la matriu ja directament de 0 no cal afegirles

%Si es vulguessin afegir altres condicions exteriors, usar
   %V(1,:)=0.2;
   %V(N,:)=0.2;
   %V(:,1)=0.2;
   %V(:,N)=0.2;
    
%%Equacions
tolerancia=0.0001;
A=rand(1)*100;
iteracions=1;

while A>tolerancia %%Aquest while es per depurar la funci�, fent que l'aproximaci� num�rica sigui molt m�s bona
    Norm1=norm(V);
    for i=2:N-1;
        for j=2:N-1;
              if V(i,j)==1 %% El continue salta a la seguent iteraci� del for
                continue;  %% Si el voltatge es 1, ho salta ---> Mante el quadrat fixe
              end
    
            V(i,j)=(V(i-1,j)+V(i+1,j)+V(i,j-1)+V(i,j+1))./4;
        end
    end
    Norm2=norm(V);
    A=abs(Norm2-Norm1); %%Diferencia entre xn i xn+1 --> aproximaci� del resultat
    iteracions=iteracions+1; %% para a les 888 iteracions aprox
    
end

%Guardat de la Matriu soluci� amb la posici� corresponent
arxiu = fopen('arxiu.txt','wt');
for i=1:N
    for j=1:N
       fprintf(arxiu,'%d\t%d\t%g\n',i,j,V(i,j)); %el \t es tabulador
    end                                          %el \n canvia de linea
end
fclose(arxiu)


[Ex,Ey]=gradient(V);%%Per calcular el camp el�ctric

%%Representaci� gr�fica de V
figure
hold on
surf(V); shading interp; colorbar;
xlabel('x(mm)')
grid
ylabel('y(mm)')
zlabel('Difer�ncia de potencial')
title('Eq. de laplace per quadrat - Metode iteratiu')
view (-54,6);
hold off

%EXTRA: representacio del camp E i linies equipot.
figure
hold on 
contour(V,5);
quiver(Ex,Ey,5);
title('L�nies equipotencials i camp el�ctric')
hold off
    
toc
