// -- ファイルをスキャンし、単語をASCII順に並べたリストを出力する -- //

/**
Usage:
	words <file>
**/

#include <stdio.h>
#include <ctype.h>
#include <string.h>
#include <stdlib.h>

struct node {
	struct node *left; // 左枝
	struct node *right; // 右枝
	char *word; // このノードに対する単語
};

static struct node *root = NULL; // ツリーの一番上

// エラーを出力し、終了する
void memory_error(void)
{
	fprintf(stderr, "Error:Out of memory\n");
	exit(8);
}

/*
save_string -- ヒープに文字列を保存する

戻り値
	mallocを適用した部分のメモリへのポインタ
	この部分のメモリには文字列がコピーされている
*/

char *save_string(char *string)
{
	char *new_string;

	new_string = malloc((unsigned) (strlen(string) + 1));

	if (new_string == NULL)
		memory_error();
	strcpy(new_string, string);
	return (new_string);
}

/*

enter -- ツリーに単語を挿入

パラメータ
	node -- 注目している現在のノード
	word -- 挿入する単語
*/

void enter(struct node **node, char *word)
{
	int result; // strcmpの結果

	char *save_string(char *);

	/*
	現在のノードがNULLなら、ツリーの一番下の末端に達したのであり、新しいノードを作成しなければならない
	*/

	if ((*node) == NULL) {
		// 新しいノード用のメモリを割り当てる
		(*node) = malloc(sizeof(struct node));
		if ((*node) == NULL)
			memory_error();


		// 新しいノードを初期化する
		(*node)->left = NULL;
		(*node)->right = NULL;
		(*node)->word = save_string(word);
		return;
	}
	// 単語がどこに来ているかをチェック
	result = strcmp((*node)->word, word);

	// 現在のノードが単語と同じであれば、挿入する必要がない
	if (result == 0)
		return;
	
	// 単語を左枝または右枝に挿入しなければならない
	if (result < 0)
		enter(&(*node)->right, word);
	else
		enter(&(*node)->left, word);
}

/*
scan -- ファイル中で単語をスキャンする

パラメータ
	name -- スキャンするファイルの名前
*/

void scan(char *name)
{
	char word[100]; // 対象となる単語
	int index; // 対象単語のインデックス
	int ch; // 現在の文字
	FILE *in_file; // 入力ファイル

	in_file = fopen(name, "r");
	if (in_file == NULL) {
		fprintf(stderr, "Error:Unable to open %s\n", name);
		exit(8);
	}

	while (1) {
		// 空白を飛ばしてスキャン
		while (1) {
			ch = fgetc(in_file);

			if (isalpha(ch) || (ch == EOF))
				break;
		}

		if(ch == EOF)
			break;

		word[0] = ch;
		for (index = 1; index < sizeof(word); ++index) {
			ch = fgetc(in_file);
			if (!isalpha(ch))
				break;
			word[index] = ch;
		}

		// 終わりにNULLをつける
		word[index] = '\0';

		enter(&root, word);
	}
	fclose(in_file);
}

/*
print_tree -- ツリー中の単語を出力

パラメータ
	top -- 出力するツリーのルート
*/

void print_tree(struct node *top)
{
	if (top == NULL)
		return;
	
	print_tree(top->left);
	printf("%s\n", top->word);
	print_tree(top->right);
}

int main(int argc, char *argv[])
{
	if (argc != 2) {
		fprintf(stderr, "Error:Wrong number of parameters\n");
		fprintf(stderr, "on the command line\n");
		fprintf(stderr, "Usage is\n");
		fprintf(stderr, "	words 'file'\n");
		exit(8);
	}
	scan(argv[1]);
	print_tree(root);
	return 0;
}

