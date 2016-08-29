/*
 *
 * Automatically generated file; DO NOT EDIT.
 * Linux/arm 4.4.16 Kernel Configuration
 *
 */
/*
 * Helper macros to use CONFIG_ options in C/CPP expressions. Note that
 * these only work with boolean and tristate options.
 */
/*
 * Getting something that works in C and CPP for an arg that may or may
 * not be defined is tricky.  Here, if we have "#define CONFIG_BOOGER 1"
 * we match on the placeholder define, insert the "0," for arg1 and generate
 * the triplet (0, 1, 0).  Then the last step cherry picks the 2nd arg (a one).
 * When CONFIG_BOOGER is not defined, we generate a (... 1, 0) pair, and when
 * the last step cherry picks the 2nd arg, we get a zero.
 */
/*
 * IS_BUILTIN(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y', 0
 * otherwise. For boolean options, this is equivalent to
 * IS_ENABLED(CONFIG_FOO).
 */
/*
 * IS_MODULE(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'm', 0
 * otherwise.
 */
/*
 * IS_REACHABLE(CONFIG_FOO) evaluates to 1 if the currently compiled
 * code can call a function defined in code compiled based on CONFIG_FOO.
 * This is similar to IS_ENABLED(), but returns false when invoked from
 * built-in code when CONFIG_FOO is set to 'm'.
 */
/*
 * IS_ENABLED(CONFIG_FOO) evaluates to 1 if CONFIG_FOO is set to 'y' or 'm',
 * 0 otherwise.
 */
MEMORY {
 pmu_sram_code : ORIGIN = 0xff720000, LENGTH = 0xf00
 pmu_sram_stack : ORIGIN = 0xff720f00, LENGTH = 0x100
}
OUTPUT_FORMAT("elf32-littlearm", "elf32-littlearm", "elf32-littlearm")
OUTPUT_ARCH(arm)
SECTIONS
{
 /* Don't need unwind tables */
 /DISCARD/ : {
  *(.ARM.exidx*)
  *(.ARM.extab*)
 }
 /* Kernel code finds params because it knows they are first */
 .params : { *(.resume_params*) } > pmu_sram_code
 . = ALIGN(4);
 .text : { *(.text*) } > pmu_sram_code
 . = ALIGN(4);
 .rodata : { *(SORT_BY_ALIGNMENT(.rodata*)) } > pmu_sram_code
 . = ALIGN(4);
 .data : {
  *(SORT_BY_ALIGNMENT(.data*))
  . = ALIGN(4);
  /* We purposely put bss as part of data to avoid initting */
  *(SORT_BY_ALIGNMENT(.bss*))
  . = ALIGN(4);
 } > pmu_sram_code
 .stack : {
  . += LENGTH(pmu_sram_stack) - 8;
  __stack_start = .;
 } > pmu_sram_stack
}
