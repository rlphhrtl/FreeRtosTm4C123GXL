CC = arm-none-eabi-gcc
CFLAGS = -mcpu=cortex-m4 -mthumb -mfloat-abi=soft -O2 -g \
         -I./FreeRTOS/Source/include \
         -I./TivaWare/driverlib \
         -I./TivaWare/driverlib/inc \
         -I./hdr \
         -I./TivaWare/inc \
         -I./FreeRTOS/Source/examples/template_configuration \
         -I./TivaWare/inc \
		 -I./FreeRTOSConfig \
		 -I./FreeRTOS/Source/portable/ThirdParty/XCC/Xtensa
LDFLAGS = -Tproject.ld -nostartfiles

SOURCES = src/main.c FreeRTOS/Source/tasks.c FreeRTOS/Source/queue.c \
          FreeRTOS/Source/list.c TivaWare/driverlib/gpio.c \
          TivaWare/driverlib/sysctl.c TivaWare/driverlib/interrupt.c \
          FreeRTOS/Source/portable/MemMang/heap_4.c \
          FreeRTOS/Source/portable/GCC/ARM_CM4F/port.c

OBJS = $(SOURCES:.c=.o)

all: program

%.o: %.c
	$(CC) $(CFLAGS) -c $< -o $@

program: $(OBJS)
	$(CC) $(LDFLAGS) -o program.elf $(OBJS)

clean:
	rm -f $(OBJS) program.elf