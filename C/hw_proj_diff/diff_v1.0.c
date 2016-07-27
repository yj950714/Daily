#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<ctype.h>

#define WORDLONG 500
#define LINELONG 50000
#define NAMELONG 500
#define MAXROW 2000000
#define MAXCOLUMN 50

char from_name[NAMELONG] ,to_name[NAMELONG];
int flag = 0;//0_by_number 1_by_name
int number_a[MAXROW],number_b[MAXROW];
char *chart_a[MAXROW][MAXCOLUMN] ;
char *chart_b[MAXROW][MAXCOLUMN] ;
int line_a,line_b;
int row[2][20];
int depth;
int location_a[MAXROW],location_b[MAXROW];

int report_error(char s[]){
	fprintf(stderr , "%s" , s);
	exit(1);
}

int get_line_a(FILE *from_file,int now_line , int number[]){
  	char line[LINELONG];
  	if (fgets( line , LINELONG , from_file ) == NULL)
    	return 0;
  	if (strcmp(line,"\n") == 0)
    	return 2;
  	if (strlen(line) == 0)
    	return 2;
  	char temp[WORDLONG] = "";
  	int i,lines = -1,now = -1;
  	for (i = 0 ; i < strlen(line) ; i++){
    	if ((isspace(line[i])) && (now >= 0)){
      		temp[++now] = '\0';
      		lines++;
      		if ((chart_a[now_line][lines] = calloc(strlen(temp)+1,sizeof(char))) == NULL )
	  			report_error("Error While Call Memory!");
      		strcpy(chart_a[now_line][lines],temp);
      		now = -1;
      		continue;
    	}
    	if (!isspace(line[i]))
      		temp[++now] = line[i];
  	}
  	number[now_line] = lines+1;
  	return 1;
}  /* get_line_a */

int get_line_b(FILE *to_file,int now_line , int number[]){
  	char line[LINELONG];
  	if (fgets( line , LINELONG , to_file ) == NULL)
    	return 0;
  	if (strcmp(line,"\n") == 0)
    	return 2;
  	if (strlen(line) == 0)
    	return 2;
  	char temp[WORDLONG] = "";
  	int i,lines = -1,now = -1;
  	for (i = 0 ; i < strlen(line) ; i++){
    	if ((isspace(line[i])) && (now >= 0)){
      		temp[++now] = '\0';
      		lines++;
      		chart_b[now_line][lines] = (char*)calloc(strlen(temp)+1,sizeof(char));
      		strcpy(chart_b[now_line][lines],temp);
      		now = -1;
      		continue;
    	}
    	if (!isspace(line[i]))
      		temp[++now] = line[i];
  	}
  	number[now_line] = lines+1;
  	return 1;
}  /* get_line_b */

void get_data(char* from_file,char* to_file){
  	FILE *fp;
  	int now = 0,temp;
  	fp = fopen(from_file,"r");
  	if (fp == NULL)
    	report_error("Can't open file_A.\n");
  	temp = get_line_a(fp , now , number_a);
  	while (temp > 0){
    	if (temp == 1)
      		now++;
    	temp = get_line_a(fp , now , number_a);
  	}
  	line_a = now;
  	fclose(fp);
  
  	now = 0;
  	fp = fopen(to_file,"r");
  	if (fp == NULL)
    	report_error("Can't open file_B.\n");
  	temp = get_line_b(fp , now , number_b);
  	while ( temp > 0){
    	if (temp == 1)
      		now++;
    	temp = get_line_b(fp , now , number_b);
  	}
  	line_b = now;
  	fclose(fp);
} /* get_data */

void change(int which,char* option){
  	char temp[WORDLONG] = "";
  	int i,now = -1,position = 0;
  	for (i = 0 ; i <= strlen(option) ; i++){
    	if ((!isdigit(option[i])) && (now >= 0 )){
      		temp[++now] = '\0';
      		position++;
      		row[which][position] = atoi(temp)-1;
      		now = -1;
      		continue;
    	}
    	if (isdigit(option[i]))
    		temp[++now] = option[i];
  	}
  	row[which][0] = position;
} /* change */

int compare(char* chart[MAXROW][MAXCOLUMN],int depth_now,int x, int y, int color){
  	int temp;
  	if (depth_now>depth)
    	return 0;
  	temp = strcmp(chart[x][row[color][depth_now]],chart[y][row[color][depth_now]]);
  	if (temp<0)
    	return -1;
  	else if (temp>0)
    	return 1;
  	else
    	return compare(chart,depth_now+1,x,y,color);
} /* compare */

void swap(int *xx,int *yy){
  	int temp;
  	temp = *xx;
  	*xx = *yy;
  	*yy = temp;
}

void sort(int a[],char* chart[MAXROW][MAXCOLUMN],int p,int q,int color){
  	int i,j,mid;
  	if (p >= q)
    	return;
  	i = p;
  	j = q;
  	mid = a[(i+j)>>1];
  	while (i <= j ){
    	while (compare(chart,1,a[i],mid,color)<0) i++;
    	while (compare(chart,1,a[j],mid,color)>0) j--;
    	if (i <=j){
      		swap(&a[i],&a[j]);
      		i++;
      		j--;
    	}
  	}
  	sort(a,chart,p,j,color);
  	sort(a,chart,i,q,color);
}

int compare_between_file(char* a[MAXROW][MAXCOLUMN],char* b[MAXROW][MAXCOLUMN], int depth_now,int x, int y){
  	if (depth_now > depth)
    	return 0;
  	int temp;
  	temp = strcmp(a[x][row[0][depth_now]] , b[y][row[1][depth_now]]);
  	if (temp > 0)
    	return 1;
  	else if (temp < 0)
    	return -1;
  	else
    	return compare_between_file(a,b,depth_now+1,x,y);
}

void print(char s[], int number[], char* chart[MAXROW][MAXCOLUMN],int x){
  	FILE *fp;
  	int i;
  	fp = fopen(s,"a");
  	for (i = 0 ; i < number[x] ; i++)
    	fprintf(fp , "%s\t" , chart[x][i]);
  	fprintf(fp ,"\n");
  	fclose(fp);
}

void clear(){
  	FILE *fp;
  	fp = fopen("A_and_B_A.out","w");
  	fclose(fp);
  	fp = fopen("A_and_B_B.out","w");
  	fclose(fp);
  	fp = fopen("Only_in_A.out","w");
  	fclose(fp);
  	fp = fopen("Only_in_B.out","w");
  	fclose(fp);
}

void solve(){
  	int point_a = 0,point_b = 0,temp;
  	int now_a = 0,now_b = 0;
  	clear();
  	while ((point_a < line_a)&&(point_b < line_b)){
    	temp = compare_between_file(chart_a,chart_b,1,location_a[point_a],location_b[point_b]);
    	now_a = 0;
    	now_b = 0;
    	while ((point_a+now_a<line_a)&&(compare(chart_a,1,location_a[point_a],location_a[point_a+now_a],0) == 0))
    		now_a++;
    	while ((point_b+now_b<line_b)&&(compare(chart_b,1,location_b[point_b],location_b[point_b+now_b],0) == 0))
    		now_b++;
    	if (temp == 0){
    		while (now_a >= 0){
    			print("A_and_B_A.out" , number_a , chart_a , point_a++);
    			now_a--;
    		}
    		while (now_b >= 0){
    			print("A_and_B_B.out" , number_b , chart_b , point_b++);
    			now_b--;
    		}
   		}
    	else if (temp < 0)
    		while (now_a >= 0){
    			print("Only_in_A.out" , number_a , chart_a , point_a++);
    			now_a--;
    		}
    	else
    		while (now_b >= 0){
    			print("Only_in_B.out" , number_b , chart_b , point_b++);
    			now_b--;
    		}
  	}
  	while (point_a < line_a)
    	print("Only_in_A.out" , number_a , chart_a , point_a++);
  	while (point_b < line_b)
    	print("Only_in_B.out" , number_b , chart_b , point_b++);
}


int main(int argc , char* argv[]){
  	int now = 0;
  	strcpy(to_name,argv[--argc]);
  	strcpy(from_name,argv[--argc]);
  
  	while (now<=argc){
    	if (argv[now][0] == '-'){
      		switch (argv[now][1]){
      		case 'c' : flag=0; now++; break;
      	 	case 'n' : flag=1; now++; break;
      	 	case 'a' : change(0,argv[++now]); break;
      	 	case 'b' : change(1,argv[++now]); break;
      	 	default: now++; break;
      		}
    	}
    	else
      		now++;
  	}
  	get_data(from_name , to_name);
	printf("Read Done!\n");  
  	if (flag == 0)
    	depth = (row[0][0] < row[1][0]) ? row[0][0]:row[1][0];
  	else
    	depth = 1;
  
  
  	int i;
  	for (i = 0 ; i <= line_a ; i++)
    	location_a[i] = i;
  	for (i = 0 ; i <= line_b ; i++)
    	location_b[i] = i;
  	sort(location_a,chart_a,0,line_a-1,0);
  	sort(location_b,chart_b,0,line_b-1,1);
 	printf("Sort Done\n");
 	printf("Start print to files now.\n");
  	solve();
  
  	return 0;
}
