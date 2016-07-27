/*Name : Huffman_tree
  Time : 2015/6/20
  Author : Never */
#include<stdio.h>
#include<ctype.h>
#include<string.h>
#include<stdlib.h>

#define MAX_CHAR_VALUE 200
#define MAXWORTH 2147482647
#define MAXNODE 200

struct Huffman_node{
	char character;
	char* worth;
	int times;
	struct Huffman_node* left;
	struct Huffman_node* right;
};

int root; //记录huffman树的根节点位置 
int types = 0; //types统计字符种类数 
int label[MAX_CHAR_VALUE]; //label[int(char x)]表示字符x在本程序中给的编号 
char* coding[MAX_CHAR_VALUE]; //coding[c]表示编号为c的字符所对应的huffman编码 
struct Huffman_node* tree[MAXNODE]; //建立huffman树过程中所用的保存节点的数组，每个元素可能是一个节点，也可能是一颗二叉树 

void init(char * input_file){
	
	FILE *fp;
	char c;
	int i;
	
	if ((fp = fopen(input_file , "r" )) == NULL){
		printf("Open Failed!");
		exit(1);
	}
	for ( i = 1 ; i <= MAXNODE ; i++){
		tree[i] = malloc(sizeof(struct Huffman_node));
		tree[i]->left = NULL;
		tree[i]->right = NULL;
		tree[i]->worth = NULL;
		tree[i]->times = 0;
		tree[i]->character = '\0';
	}
	memset( label , 0 , sizeof(label));
	while ((c = fgetc(fp)) != EOF){
		if (label[c+0] == 0){
			label[c+0] = ++types;
			tree[label[c+0]]->character = c;
		}
		tree[label[c+0]]->times++;
	}
	fclose(fp);
} /* init */

struct Huffman_node* combine(struct Huffman_node** Left_node , struct Huffman_node** Right_node){
	struct Huffman_node *ans;
	ans = malloc(sizeof(struct Huffman_node));
	ans->character = '\0';
	ans->left = *Left_node;
	ans->right = *Right_node;
	ans->times = (*Left_node)->times+(*Right_node)->times;
	ans->worth = NULL;
	return ans;	
} /* combine */

void swap(struct Huffman_node** xx , struct Huffman_node** yy){
	struct Huffman_node temp;
	temp = **xx;
	**xx = **yy;
	**yy = temp;
} /* swap */

void Build_Huffman(){
	int i,j;
	int last = types;
	int first_min_position,second_min_position;
	int first_min_value,second_min_value;
	int v[MAXNODE];
	
	memset( v , 0 , sizeof(v));
	for ( i = 1 ; i < types ; i++){
		first_min_value = MAXWORTH;
		second_min_value = MAXWORTH;
		for ( j = 1 ; j <= last ; j++){
			if ((!v[j]) && (tree[j]->times < first_min_value)){
				second_min_value = first_min_value;
				second_min_position = first_min_position;
				first_min_value = tree[j]->times;
				first_min_position = j;
			}
			else if ((!v[j]) && (tree[j]->times < second_min_value)){
				second_min_value = tree[j]->times;
				second_min_position = j;
			}
		}
		tree[++last] = combine(&tree[first_min_position] , &tree[second_min_position]);
		v[first_min_position] = 1;
		v[second_min_position] = 1;
	}
	root = last;
} /* Build_huffman_tree */

void calc_the_code(struct Huffman_node** now , char* parent_code , char* color){
	if ((*now) == NULL)
		return;
	(*now)->worth = malloc(sizeof(char)*(strlen(parent_code)+5));
	strcpy((*now)->worth , parent_code);
	(*now)->worth = strcat((*now)->worth , color);
	calc_the_code(&((*now)->left) , (*now)->worth , "0");
	calc_the_code(&((*now)->right) , (*now)->worth , "1");
} /* calc the huffman code for every leaves node */

void print_coding_schedule(struct Huffman_node* now , FILE *fp){
	if (now->character != '\0'){
		switch (now->character){
		 case '\n' : fprintf(fp , "\\n -> %s\n" , now->worth); break;
		 case '\t' : fprintf(fp , "\\t -> %s\n" , now->worth); break;
		 case ' '  : fprintf(fp , "Space -> %s\n" , now->worth); break;
		 default   : fprintf(fp , "%c -> %s\n" , now->character , now->worth); break;
		}
		coding[label[now->character+0]] = malloc(sizeof(now->worth));
		strcpy(coding[label[now->character+0]] , now->worth);
		return;
	}
	print_coding_schedule(now->left , fp);
	print_coding_schedule(now->right , fp);
} /*print the coding schedule */

void change(char *input_file , char *output_file){
	FILE *fp_in;
	FILE *fp_out;
	char c;
	fp_in = fopen(input_file , "r");
	fp_out = fopen(output_file , "w");
	while ((c = fgetc(fp_in)) != EOF)
		fprintf(fp_out , "%s" , coding[label[c+0]]);
	fclose(fp_in);
	fclose(fp_out);
} /* change */

void get_original_text(char *input_file , char *output_file){
	FILE *fp_in;
	FILE *fp_out;
	char c;
	struct Huffman_node *now = tree[root]; 
	fp_in = fopen(input_file , "r");
	fp_out = fopen(output_file , "w");
	while ((c = fgetc(fp_in)) != EOF){
		if (c == '0')
			now = now->left;
		else if (c == '1')
			now = now->right;
		if (now->character != '\0'){
			fprintf(fp_out , "%c" , now->character);
			now = tree[root];
		}
	}
	fclose(fp_in);
	fclose(fp_out);
} /* get original text */

int main(){
	FILE *fpo;
	init("English.in"); //从文件中读入文本 
	Build_Huffman(); //建立huffman树 
	calc_the_code(&tree[root] , "" , ""); //计算每个叶节点的huffman编码 
	
	fpo = fopen("Coding_schedule.txt","w"); //要输出到的编码表文件名 
	print_coding_schedule(tree[root],fpo);  //将编码表输出到文件中 
	fclose(fpo);
	
	change("English.in" , "coding.out"); //change为将前一个文件中的文本，按照已有编码，huffman压缩并写入后一个文件中 
	get_original_text("coding.out" , "English.out"); //get_original_text为根据前一个文件中的01序列，将文本还原并写入第二个文件中 
	return 0;
}
