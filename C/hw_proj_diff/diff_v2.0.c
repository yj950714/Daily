#include<stdio.h>
#include<stdlib.h>
#include<string.h>
#include<ctype.h>

#define MAXWORTH 100
#define WORDLONG 550
#define LINELONG 20000
#define NAMELONG 300
#define MAXROW 1200000
#define MAXCOLUMN 100
#define MAXCOMMANDLINE 10
#define SONNUMBER 37

struct set{
  int tot;
  int *line;
};
struct trie_node{
  struct set record;
  struct trie_node* next[SONNUMBER]; 
};
struct trie_node* trie[MAXCOMMANDLINE];
int trie_number = 0;
int dictionary[MAXWORTH];
char from_name[NAMELONG] ,to_name[NAMELONG];
int flag = 0;//0_by_number 1_by_name
int number_a[MAXROW];
char *chart[MAXROW][MAXCOLUMN] ;
char b_line[MAXCOLUMN][WORDLONG];
int line_a;
int only[MAXROW];
int row[2][MAXCOMMANDLINE];

int report_error(char s[]){
  fprintf(stderr , "%s" , s);
  exit(1);
} /* report error s */

void previous(){
  char now;
  int i;
  memset(only , 1 , sizeof(only));
  for (now = 'A' ; now <= 'Z' ; now++)
    dictionary[now-0] = now-'A'+10;
  for (now = '0' ; now <= '9' ; now++)
    dictionary[now-0] = now-'0';
  for (i = 0 ; i < MAXCOMMANDLINE ; i++){
    trie[i] = calloc(1,sizeof(struct trie_node));
  }
} /* previous : make a dictionary */

struct set combine(struct set xx, struct set yy){
  struct set newnode;
  int i,j;
  newnode.tot = 0;
  newnode.line = NULL;
  for (i = 0; i < xx.tot ; i++)
    for (j = 0 ; j < yy.tot ; j++)
      if (xx.line[i] == yy.line[j]){
	newnode.line = realloc(newnode.line,sizeof(newnode.tot+1));
	newnode.line[newnode.tot] = xx.line[i];
	newnode.tot++;
      }
  return newnode;
}

void insert(struct trie_node** root , char* s, int from){
  struct trie_node* now = *root;
  int i;
  for (i = 0 ; i < strlen(s) ; i++){
    if (now->next[dictionary[s[i]-0]] == NULL){
      now->next[dictionary[s[i]-0]] = calloc(1,sizeof(struct trie_node));
      now = now->next[dictionary[s[i]-0]];
      now->record.tot = 0;
      now->record.line = NULL;
    }
    else
      now = now->next[dictionary[s[i]-0]];
  }
  now->record.line = realloc(now->record.line,sizeof(int)*(now->record.tot+1));
  now->record.line[now->record.tot] = from;
  now->record.tot++;
}

struct trie_node* find(struct trie_node* root , char* s){
  struct trie_node* now = root;
  int i;
  for (i = 0 ; i < strlen(s) ; i++)
    if (now->next[dictionary[s[i]-0]] == NULL)
      return 0;
    else
      now = now->next[dictionary[s[i]-0]];
  if (now->record.tot == 0)
    return NULL;
  else
    return now;
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
      if ((chart[now_line][lines] = calloc(1,sizeof(temp))) == NULL )
	report_error("Error While Call Memory!");
      strcpy(chart[now_line][lines],temp);
      now = -1;
      continue;
    }
    if (!isspace(line[i]))
      temp[++now] = line[i];
  }
  number[now_line] = lines+1;
  return 1;
}  /* get lines from file A */


void get_data(char* from_file){
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
}  /* get_data */

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

void build(){
  int i,j,k;
  char s[LINELONG];
  for (i = 0 ; i < line_a ; i++)
    for (j = 1 ; j <= row[0][0] ; j++){
      strcpy(s,chart[i][row[0][j]]);
      for (k = 0 ; k < strlen(s) ; k++)
	s[k] = toupper(s[k]);
      insert(&trie[j],s,i);
    }
} /*build the trie*/

void print_b(FILE *fp, int maxn){
  int i;
  for (i = 0 ; i < maxn ; i++)
    fprintf(fp , "%s\t" , b_line[i]);
  fprintf(fp ,"\n");
} /*print b */

int get_line_b(FILE *to_file, int* num){
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
      strcpy(b_line[lines],temp);
      now = -1;
      continue;
    }
    if (!isspace(line[i]))
      temp[++now] = toupper(line[i]);
  }
  *num = lines+1;
  return 1;
}  /* get_line_b */

void calc(char* to_file){
  FILE *fp;
  FILE *fp_only;
  FILE *fp_and;
  int temp,tmp_column;
  int i,j,have_answer;
  struct set ans;
  struct trie_node* tmp;
	
  fp = fopen(to_file,"r");
  if (fp == NULL)
    report_error("Can't open file_B.\n");
  fp_only = fopen("Only_in_B.out","w");
  fp_and = fopen("A_and_B_B.out","w");
  temp = get_line_b(fp , &tmp_column);
  while (temp > 0){
    if (temp == 1){
      ans.tot = 0;
      ans.line = NULL;
      have_answer = 1;
      for (i = 1 ; i <= row[0][0] ; i++){
	tmp = find(trie[i],b_line[row[1][i]]);
	if (tmp == NULL){
	  have_answer = 0;
	  break;
	}
	if (i == 1)
	  ans = tmp->record;
	else
	  ans = combine(tmp->record , ans);
	if (ans.tot == 0){
	  have_answer = 0;
	  break;
	}
      }
      if (have_answer){
	print_b(fp_and,tmp_column);
	for (i = 0 ; i < ans.tot ; i++)
	  only[ans.line[i]] = 0;
      }
      else
	print_b(fp_only,tmp_column);
    }
    temp = get_line_b(fp , &tmp_column);
  }
  fclose(fp);	
  fclose(fp_only);
  fclose(fp_and);

  fp = fopen("A_and_B_A.out","w");
  for (i = 0 ; i < line_a ; i++)
    if (!only[i]){
      for (j = 0 ; j < number_a[i] ; j++)
	fprintf(fp , "%s\t" , chart[i][j]);
      fprintf(fp , "\n" );
    }
  fclose(fp);
  
  fp = fopen("Only_in_A.out","w");
  for (i = 0 ; i < line_a ; i++)
    if (only[i]){
      for (j = 0 ; j < number_a[i] ; j++)
	fprintf(fp , "%s\t" , chart[i][j]);
      fprintf(fp , "\n" );
    }
  fclose(fp);	
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
  printf("Command Read Done\n");
  previous();
  get_data(from_name);
  printf("Get Data Done!\n");
  build();
  printf("Build Done!\n");
  calc(to_name);
	
  return 0;
}


