#include <iostream>

using namespace std;

int main (){
	double a[] = {242136, 186857, 194709, 234097, 221979, 247912, 227976, 223245, 200770};
	double var = 0;
	double esperanza = 0;

	for(int i = 0; i < 9; i++){
		esperanza = esperanza + a[i];
	}
	esperanza = esperanza / 9;

	for(int i = 0; i < 9; i++){
		var = var + ((a[i] - esperanza) * (a[i] - esperanza));
	}

	var = var / 9;

	cout << fixed <<"Esperanza: " << esperanza << "   Varianza: desvio estandar " << sqrt(var) <<endl;

	//printf("Esperanza; %d",esperanza);
	//printf("Varianza: %d", var);
	return 0;
}
