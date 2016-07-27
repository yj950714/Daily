#include <cstdio>
#include <iostream>
using namespace std;
 
int main()
{
    int n,i,sum;
    long int a[23];
    while(cin>>n)
    {
        for(i=0; i<n; i++)
            cin>>a[i];
        sum=a[0];
        for(i=1; i<n; i++)
            sum=sum^a[i];
        if(sum==0)
            cout<<"No"<<endl;
        else
            cout<<"Yes"<<endl;
    }
}