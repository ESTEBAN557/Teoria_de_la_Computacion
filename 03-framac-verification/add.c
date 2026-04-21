#include <limits.h> // <--- include for INT_MIN and INT_MAX

/*@
  requires (long long)x + y >= INT_MIN && (long long)x + y <= INT_MAX; // <-- Missing line
  ensures \result == x + y;
*/
int add(int x, int y) {
  return x + y;
}