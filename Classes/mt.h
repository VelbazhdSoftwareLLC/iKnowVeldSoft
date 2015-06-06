/*
 *  mt.h
 *  iKnow
 *
 *  Created by Trifon Dimov on 6/5/10.
 *  Copyright 2010 __MyCompanyName__. All rights reserved.
 *
 */

void init_genrand(unsigned long s);

void init_by_array(unsigned long init_key[], int key_length);

unsigned long genrand_int32(void);

long genrand_int31(void);

double genrand_real1(void);

double genrand_real2(void);

double genrand_real3(void);

double genrand_res53(void);
