
%% Definitioner
clear
clc
% Antal noder (mÃ¥ste vara en kvadrat av ett heltal).
n = 10000;
% Coupling-parametern
J = -1;

kBT=0;

%% Generation av slumpmässigt utgångstillstånd
% SidlÃ¤ngd pÃ¥ matrisen
clf
N = sqrt(n);

% Matrisen som huserar noderna
A=(unidrnd(2,N,N)-1);
A=A-isnan(A./A);

plot(-5,-5,'bo')
hold on
plot(-5,-5,'bx')
% 
% for i=1:N
%     for j=1:N
%         if A(i,j)==1
%             plot(i,j,'bo')
%         else
%             plot(i,j,'bx')
%         end
%     end
% end

imagesc(A)

legend('dipolmoment = +1','dipolmoment = -1')

axis([0 N+1 0 N+1])

% BerÃ¤kna Hamiltonianen

HAa=[A zeros(N,1)];
HAb=[zeros(N,1) A];

Hhoriz=sum(sum(HAa.*HAb));

HBa=[zeros(1,N);A];
HBb=[A;zeros(1,N)];

Hvert=sum(sum(HBa.*HBb));

H=-(Hhoriz+Hvert);

%% Monte-Carlo
iter=1000*n; % Antal iterationer i Monte-Carlo
for eh=1:iter
    % Välj
    xx=unidrnd(N);
    yy=unidrnd(N);
    
    if xx>1
        if xx<N
            dHhor=A(xx,yy)*(A(xx-1,yy)+A(xx+1,yy));
        else
            dHhor=A(xx,yy)*A(xx-1,yy);
        end
    else
        dHhor=A(xx,yy)*A(xx+1,yy);
    end
    
    if yy>1
        if yy<N
            dHVert=A(xx,yy)*(A(xx,yy-1)+A(xx,yy+1));
        else
            dHVert=A(xx,yy)*A(xx,yy-1);
        end
    else
        dHVert=A(xx,yy)*A(xx,yy+1);
    end
    
    dH=-2*J*(dHhor+dHVert);
    
    if dH<=0
        A(xx,yy)=-A(xx,yy);
        H=H+dH;
    else
        p=exp(-dH/kBT);
        if rand<=p
            A(xx,yy)=-A(xx,yy);
            H=H+dH;
        end
    end
    
    if mod(eh,1000)==0
    imagesc(A)
    
    pause(0.00001)
    end
end
