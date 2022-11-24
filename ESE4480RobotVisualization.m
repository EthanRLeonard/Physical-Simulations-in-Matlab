clear, close all
%% Base



%% First Link
Linkx=zeros(1,5);
Linky=[0 0 6 6 8];
Linkz=[0 -1 -1 0 0];
%% TRANS0_1
%Structure of T1 is (left to right) :
% x,y,z,theta1
hold off
Linkx2=zeros(1,2);
Linky2=[0 12 ];
Linkz2=[0 0 ];
T1=zeros(4,4);
T2=zeros(4,4);
steps=50;
theta1=linspace(0,2*pi,steps);
theta2=linspace(0,2*pi,steps);
for step=1:steps
    [transformedpoints,T1]=revolveLink1(Linkx,Linky,Linkz,theta1,step);
    
    transformedpoints2=revolveLink2(Linkx2,Linky2,Linkz2,theta2,step,T1);
    
    drawBase
    
    plot3(transformedpoints(1,:),transformedpoints(2,:),transformedpoints(3,:))
    
    plot3(transformedpoints2(1,:),transformedpoints2(2,:),transformedpoints2(3,:))
    
    pause(.1)
    
    hold off
   
  
    title ('animated links')

end

%% Functions
function drawBase 
plot3([0 0] , [0 0], [-12,0],'bs-')
axis([-15 15 -15 15 -15 15]) 
grid on
hold on 
end

function [transformedpoints,Tr1]=revolveLink1 (Linkx,Linky,Linkz,theta1,step)
numpoints=length(Linkx);
    points=zeros(4,numpoints);
    for p=1:numpoints
    points(:,p)=[Linkx(p),Linky(p),Linkz(p),theta1(step)]';
    end
T1(1,1)=cos(theta1(step));
T1(2,2)=cos(theta1(step));
T1(1,2)=-sin(theta1(step));
T1(2,1)=sin(theta1(step));
T1(3,3)=1;
T1(4,4)=1;
    transformedpoints=T1*points;
    Tr1=T1;
end
function transformedpoints2=revolveLink2 (Linkx2,Linky2,Linkz2,theta2,step,T1)
    numpoints2=length(Linkx2);
    points2=zeros(4,numpoints2);
    for p=1:numpoints2
    points2(:,p)=[Linkx2(p),Linky2(p),Linkz2(p),theta2(step)/(theta2(step))]';
    end
    theta2(step)
T2(1,1)=cos(theta2(step));
T2(1,2)=-sin(theta2(step));
T2(3,1)=sin(theta2(step));
T2(3,2)=cos(theta2(step));
T2(2,3)=-1;
T2(2,4)=8;
T2(4,4)=1;

transformedpoints2=T1*T2*points2;
end