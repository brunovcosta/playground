#include<jni.h>
#include<stdio.h>
#include"Main.h"

JNIEXPORT void JNICALL Java_Main_funcloka(JNIEnv *env, jobject thisObj) {
   printf("Hello World!\n");
   return;
}
