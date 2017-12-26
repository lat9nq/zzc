CC=gcc
CCFLAGS=-g -Wall
LIBFLAGS=-lfl
LEX=flex
YACC=bison

build/zzc.l.c:src/zzc.l build/zzc.tab.h

