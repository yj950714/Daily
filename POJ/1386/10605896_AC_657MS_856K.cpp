#include <stdlib.h>
#include <iostream>
#include <vector>
#include <string.h>
#include <stdio.h>
using namespace std;
#define _max 30
vector<int>v[_max];
int in[_max];
int out[_max];
char ch[1005];
bool visited[_max];
int ans;
int n;

/*
 *
 */
void dfs(int k) {
    int i;
    ans++;
    visited[k] = 1;
    for (i = 0; i < v[k].size(); i++) {
        if (!visited[v[k][i]])
            dfs(v[k][i]);
    }
}

int main(int argc, char** argv) {

    int i, j;
    int T;
    cin >> T;
    while (T--) {
        cin >> n;
        for (i = 0; i < 26; i++)//初始化
        {
            in[i] = 0;
            out[i] = 0;
            v[i].clear();
            visited[i] = 0;
        }

        for (i = 1; i <= n; i++) {
            cin >> ch;
            int a = ch[0] - 'a';
            int b = ch[strlen(ch) - 1] - 'a';
            v[a].push_back(b);
            in[b]++;
            out[a]++;
        }

        int s1, s2, s3;
        int num = 0;
        s1 = 0;
        s2 = 0;
        s3 = 0;
        int start, end;
        for (i = 0; i < 26; i++) {
            if (in[i] + out[i] != 0) {
                num++;
                if (in[i] + 1 == out[i]) {
                    s1++;
                    start = i;
                } else if (in[i] == out[i]) {
                    s2++;
                } else if (out[i] + 1 == in[i]) {
                    s3++;
                }
                end = i;
            }
        }
        ans = 0;
        if (s1 != 0)dfs(start);
        else dfs(end);
        if (num == ans) {
            if ((s1 == 1 && s3 == 1 && s2 == num - 2) || s2 == num) {
                cout << "Ordering is possible." << endl;
            } else {
                cout << "The door cannot be opened." << endl;
            }
        } else {
            cout << "The door cannot be opened." << endl;
        }
    }
    return (EXIT_SUCCESS);
}