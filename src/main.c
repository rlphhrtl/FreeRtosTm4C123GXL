#include <stdbool.h>
#include <FreeRTOS.h>
#include <task.h>
#include <sysctl.h>
#include <gpio.h>
#include <hw_memmap.h>

void vTask1(void *pvParameters) {
    while (1) {
        GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_1, GPIO_PIN_1);
        vTaskDelay(500);
        GPIOPinWrite(GPIO_PORTF_BASE, GPIO_PIN_1, 0);
        vTaskDelay(500);
    }
}

int main(void) {
    SysCtlClockSet(SYSCTL_SYSDIV_5 | SYSCTL_USE_PLL | SYSCTL_OSC_MAIN | SYSCTL_XTAL_16MHZ);
    SysCtlPeripheralEnable(SYSCTL_PERIPH_GPIOF);
    GPIOPinTypeGPIOOutput(GPIO_PORTF_BASE, GPIO_PIN_1);

    xTaskCreate(vTask1, "Task1", 128, NULL, 1, NULL);
    vTaskStartScheduler();

    while (1);
}