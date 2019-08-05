function [output,theta_SS]=rate(r1,rr1,r2,r3)
[t,x]=ode23s(@(t,x) [r3(x)-r1(x)+rr1(x);r1(x)-rr1(x)-r2(x);r2(x)-r3(x)],[0,100],[0.998,0.001,0.001]); %forward integration of the rate until a long t=100 which is assumed to be steady-state
theta_SS=x(end,:);%theta_SS is the steady-state coverages
output=r3(theta_SS); %output is the rate
end
