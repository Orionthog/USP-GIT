function P0 = rotacao(usrRef, usrRotx, usrRoty, usrRotz)
    global H 
    global P
    global P0
    %P � fixo enquanto P0 muda a cada plot
    P = [ [0; 0; 0], [0; 1; 0],  [1; 1; 0], [1; 0; 0], [0; 0; 1], [0; 1; 1], [1; 1; 1], [1; 0; 1]];
    %J � a rotacao agora H s�o as rotacoes acumuladas 
    J = rotx(usrRotx*pi/180)*roty(usrRoty*pi/180)*rotz(usrRotz*pi/180);
    %Referencial Local ou Global
    if (usrRef == 'W')    
        H = J*H;    %Global
    else
        H = H*J;    %Local
    end
    %P0 vira o cara rotacionado para a funcao DesenhaCubo plotar
    P0 = P;
    P0 = [H*P(:,1), H*P(:,2), H*P(:,3), H*P(:,4), H*P(:,5), H*P(:,6), H*P(:,7), H*P(:,8)];
end