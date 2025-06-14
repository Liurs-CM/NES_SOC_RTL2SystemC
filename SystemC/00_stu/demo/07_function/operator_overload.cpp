#include <iostream>

enum color {black, red, magenta, yellow, 
    green, cyan, blue, white };

color operator+(color lhs, color rhs) {
    if (lhs == rhs) return lhs;
    else if (lhs == black) return rhs;
    else if (rhs == black) return lhs;
    else if (lhs == white) return white;
    else if (rhs == white) return white;
    else if (lhs == red && rhs == blue) return magenta;
    else if (lhs == blue && rhs == red) return magenta;
    else return color((int(lhs) + int(rhs)) % 7 + 1);
}

color operator+(color lhs, int rhs) {
    return color((int(lhs) + rhs) % 8);
}

int main() {
    color c1 = red;
    color c2 = blue;

    // 颜色混合
    std::cout << "Red + Blue = " << int(c1 + c2) << std::endl;  // 输出2(magenta)

    // 颜色循环
    color current = red;
    std::cout << "Red + 3 = " << int(current + 3) << std::endl;  // 输出4(yellow)

    // 黑色测试
    std::cout << "Black + Red = " << int(black + red) << std::endl;  // 输出1(red)

    return 0;
}

