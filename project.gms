Sets
         i       clusters of stations    /node1*node10 /;
Alias (i,j)

Parameters

         d(i) demands for each cluster
         /       node1   -4
                 node2   10
                 node3   3
                 node4   2
                 node5   -8
                 node6   5
                 node7   -10
                 node8   2
                 node9   -1
                 node10  1/;

Table w(i,j) distance between bike stations v(i) and v(j)



         node1           node2           node3           node4           node5           node6           node7           node8           node9           node10
node1    0.         0.01740656         0.02803472      0.02564747        0.01430677      0.03113276      0.02066321      0.01795033      0.01961556      0.03876175
node2  0.01740656   0.                 0.01582217      0.01404104        0.02275546      0.01460469      0.01709441      0.00701318      0.03442013      0.02341575
node3  0.02803472   0.01582217         0.              0.02771651        0.02437968      0.02190971      0.01169642      0.02259806      0.03837457      0.01202611
node4  0.02564747   0.01404104         0.02771651      0.                0.0354326       0.01078307      0.03112872      0.00831374      0.04501595      0.03082944
node5  0.01430677   0.02275546         0.02437968      0.0354326         0.              0.03716745      0.01303437      0.02712287      0.0140105       0.03640369
node6  0.03113276   0.01460469         0.02190971      0.01078307        0.03716745      0.              0.0291344       0.01387568      0.04899975      0.02148753
node7  0.02066321   0.01709441         0.01169642      0.03112872        0.01303437      0.0291344       0.              0.0236926       0.02701077      0.02365105
node8  0.01795033   0.00701318         0.02259806      0.00831374        0.02712287      0.01387568      0.0236926       0.              0.03696844      0.02873597
node9  0.01961556   0.03442013         0.03837457      0.04501595        0.0140105       0.04899975      0.02701077      0.03696844      0.              0.05039163
node10 0.03876175   0.02341575         0.01202611      0.03082944        0.03640369      0.02148753      0.02365105      0.02873597      0.05039163      0.


scalar C capacity for vheicle    /12/;

variable x(i,j)  whether there are bikes transfered from i to j
         q(i,j)  quantity of bikes transfered from i to j
         u(i)    MTZ subtour elimination
         z       total travel distance;

binary variable x;
positive variable q,u;
Equations
         distance        define objective fuction
         c1(i)     make sure rebalanced
         c2(i) make sure enter only once
         c3(i) make sure exit only once
         c4(i,j)   make sure under vheicle capacity
         c5   MTZ subtour elimination_1
         c6   MTZ subtour elimination_2
         c7   MTZ subtour elimination_3;

distance..   z=e=sum((i,j),w(i,j)*x(i,j));
c1(i)..      sum(j,q(i,j))-sum(j,q(j,i)) =e= d(i);
c2(i)..      sum(j,x(i,j))=e= 1;
c3(i)..      sum(j,x(j,i))=e= 1;
c4(i,j)..    q(i,j) =l= C*x(i,j);
c5(i,j)$(ord(i)>1 and ord(j)>1)..        u(i)-u(j)+10*x(i,j) =l=9;
c6(i,j)$(ord(i)>1)..     u(i)=l=9;
c7(i,j)$(ord(i)>1)..     u(i)=g=1;

Model travel_distance /all/;
option MIP = Cplex;
Solve travel_distance using MIP minimizing z;
Display x.l, z.l;





