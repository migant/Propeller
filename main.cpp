

#include <iostream>


#include "registers.h"



// TIP To <b>Run</b> code, press <shortcut actionId="Run"/> or click the <icon src="AllIcons.Actions.Execute"/> icon in the gutter.

int main() {
    // TIP Press <shortcut actionId="RenameElement"/> when your caret is at the <b>lang</b> variable name to see how CLion can help you rename it.
    std::cout << sizeof(regs) << std::endl;
    REG16(BC) = 0x80;

    for (int i = 0x80; i <= 0x85; i++) {

        std::cout << "i = " << static_cast<int>(REG16(BC)) << std::endl;

        REG8(B) --;
    }

    return 0;
    // TIP See CLion help at <a href="https://www.jetbrains.com/help/clion/">jetbrains.com/help/clion/</a>. Also, you can try interactive lessons for CLion by selecting 'Help | Learn IDE Features' from the main menu.
}