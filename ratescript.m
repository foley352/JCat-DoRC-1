%definiton of ki and ri
k1=1;kr1=0.4
r1=@(x) x(1)/x(2)*k1^2/kr1-exp(-x(3));
rr1=@(x) sqrt(x(2))*x(3);
r2=@(x) x(2)/(x(3))^0.1;
r3=@(x) x(3)^4-x(2);

%x=theta=[theta_*,theta_A^*,theta_B^*]

[rxnrate0,thetaSS]=rate(r1,rr1,r2,r3);%rate with unperturbed inputs, output of steady-state coverages

[rxnrate1,~]=rate(@(x) 1.0001*r1(x),rr1,r2,r3);%rate with r1 perurbed
[rxnrater1,~]=rate(r1,@(x) 1.0001*rr1(x),r2,r3);%rate with r-1 perturbed
[rxnrate2,~]=rate(r1,rr1,@(x) 1.0001*r2(x),r3);%rate with r2 perturbed
[rxnrate3,~]=rate(r1,rr1,r2,@(x) 1.0001*r3(x));%rate with r3 perturbed

%calulation of sensitivities
s1=(rxnrate1-rxnrate0)/0.0001/rxnrate0;
sr1=(rxnrater1-rxnrate0)/0.0001/rxnrate0;
s2=(rxnrate2-rxnrate0)/0.0001/rxnrate0;
s3=(rxnrate3-rxnrate0)/0.0001/rxnrate0;

%calculation of s_k1
k1=1.0001;
r1=@(x) x(1)/x(2)*k1^2/kr1-exp(-x(3));
[rxnratek1,~]=rate(r1,rr1,r2,r3);
sk1=(rxnratek1-rxnrate0)/0.0001/rxnrate0;

%output of sensitivities
sensitivities=[s1,sr1,s2,s3]
total=sum([s1,sr1,s2,s3]) %the total still sums to one becuase of units
[sk1,sensitivities(1)*((2*x(1)/x(2)*k1^2/kr1)/(x(1)/x(2)*k1^2/kr1-exp(-x(3))))] %output of s_k1 and the calculated value from Eq. 36