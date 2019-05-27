%%
%Caminho no Fedora
run('/home/igor.barbara/github/USP-GIT/LabRobosManip/rvctools/startup_rvc.m')
%Caminho no Windows
%run('C:\Users\Igor\USP-GIT\LabRobosManip\rvctools\startup_rvc.m')
%%
clear

global joint1 joint2 joint3 joint4 joint5 joint6 joint7
cinemDir = [];
instantPos = [];
instantRot = [];
instantRPY = [];
batman = [];
%Parametros do kuka
a1 = 340;
a2 = 400;
a3 = 400;
a4 = 126;
theta1 = 0;
theta2 = 0;
theta3 = 0;
theta4 = 0;
theta5 = 0;
theta6 = 0;
theta7 = 0;
%Braco
L(1) = Link([ -pi/2 + theta1 ,  a1  , 0 , -1*pi/2]);
L(2) = Link([   0   + theta2 ,  0   , 0 ,  1*pi/2]);
L(3) = Link([   0   + theta3 , a2/2 , 0 ,  1*pi/2]);
L(4) = Link([   0   + theta4 ,  0   , 0 , -1*pi/2]);
L(5) = Link([   0   + theta5 , a3/2 , 0 , -1*pi/2]);
L(6) = Link([   0   + theta6 ,  0   , 0 , -1*pi/2]);
L(7) = Link([  pi/2 + theta7 , a4/2 , 0 ,     0  ]);

kuka = SerialLink(L, 'name', 'kuka') 


%Plot
figure(1)
clf
%kuka.plot(zeros(1, kuka.n), 'tilesize', 128 )
axis equal;
hold on;
grid on;
xlabel('X','FontSize',18);
ylabel('Y','FontSize',18);
zlabel('Z','FontSize',18);

%Animacao
for i = 1:length(joint1)-1
    %figure(1)
    clf
    kuka.plot([joint1(length(joint1) - i)*pi/180 , joint2(length(joint2) - i)*pi/180 , joint3(length(joint3) - i)*pi/180 , joint4(length(joint4) - i)*pi/180 , joint5(length(joint5) - i)*pi/180 , joint6(length(joint6) - i)*pi/180 , joint7(length(joint7) - i)*pi/180], 'tilesize', 128 )
    cinemDir = horzcat( cinemDir , kuka.fkine([joint1(length(joint1) - i)*pi/180 , joint2(length(joint2) - i)*pi/180 , joint3(length(joint3) - i)*pi/180 , joint4(length(joint4) - i)*pi/180 , joint5(length(joint5) - i)*pi/180 , joint6(length(joint6) - i)*pi/180 , joint7(length(joint7) - i)*pi/180]));
    %cinemDir = kuka.fkine([joint1(length(joint1) - i) , joint2(length(joint2) - i) , joint3(length(joint3) - i) , joint4(length(joint4) - i) , joint5(length(joint5) - i) , joint6(length(joint6) - i) , joint7(length(joint7) - i)], 'deg');
    pause(1E-3)
    %kuka.getpos()
end

%Cinematica Direta
instantPos = cinemDir.t;
instantRot = [cinemDir.n , cinemDir.o , cinemDir.a];

%Roll Pitch Yaw
for i = 1:3:length(instantRot)
    batman = tr2rpy([instantRot(:,i),instantRot(:,i),instantRot(:,i)]);
    instantRPY =   [cos(batman(1)).*cos(batman(2)) , cos(batman(1)).*sin(batman(1)).*sin(batman(3))-sin(batman(1)).*cos(batman(3)) , cos(batman(1)).*sin(batman(2)).*cos(batman(3))+sin(batman(1)).*sin(batman(3))
                    sin(batman(1)).*cos(batman(2)) , sin(batman(1)).*sin(batman(2)).*cos(batman(3))+cos(batman(2)).*cos(batman(3)) , sin(batman(1)).*sin(batman(2)).*cos(batman(3))-cos(batman(1)).*sin(batman(3))
                    -sin(batman(2))                , cos(batman(2)).*sin(batman(3))                                                , cos(batman(2)).*cos(batman(3))];
end