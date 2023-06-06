clc
clear
close all

global gmdh

Q=input('Enter Q= ');
lb=[0 0 0];
ub=[10 2 6];
N=size(lb,2);

T1=TaguchiArray(Q,N);
T2=TaguchiArray(2,N);
n=size(T1,1)*size(T2,1);

main

a1=lb;
b1=ub;

for i=1:10
    for k1=1:Q
        for k2=1:N
            Damaneh(k1,2*k2-1)=a1(k2)+(k1-1)*(b1(k2)-a1(k2))/Q;
            Damaneh(k1,2*k2)=a1(k2)+k1*(b1(k2)-a1(k2))/Q;
        end
    end
    

    z=1;
    for j=1:size(T1,1)
        for k=1:size(T2,1)
            s(z,1)=z;
            for hh=1:N
                if T2(k,hh)==1
                    s(z,hh+1)=Damaneh(T1(j,hh),2*hh-1);
                else
                    s(z,hh+1)=Damaneh(T1(j,hh),2*hh);
                end
            end
            for i1=1:N
                s(z,N+1+2*i1-1)=Damaneh(T1(j,i1),2*i1-1);
                s(z,N+1+2*i1)=Damaneh(T1(j,i1),2*i1);
            end
            s(z,1+N+2*N+1)=ApplyGMDH(gmdh,[s(z,2) s(z,3) s(z,4)]');
            z=z+1;
        end
    end

    
    s_max=max(s(:,end));
    a10=find(s(:,end)==s_max);
    for i2=1:N
        a1(1,i2)=s(a10(1),1+N+2*i2-1);
        b1(1,i2)=s(a10(1),1+N+2*i2);
    end
end

X_Final=s(a10(1),[2 3 4])
s_max
        

        
        