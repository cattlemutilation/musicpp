/**********************************************************************/
/*   ____  ____                                                       */
/*  /   /\/   /                                                       */
/* /___/  \  /                                                        */
/* \   \   \/                                                       */
/*  \   \        Copyright (c) 2003-2009 Xilinx, Inc.                */
/*  /   /          All Right Reserved.                                 */
/* /---/   /\                                                         */
/* \   \  /  \                                                      */
/*  \___\/\___\                                                    */
/***********************************************************************/

#include "xsi.h"

struct XSI_INFO xsi_info;

char *IEEE_P_2592010699;
char *STD_STANDARD;
char *IEEE_P_3499444699;
char *IEEE_P_3620187407;


int main(int argc, char **argv)
{
    xsi_init_design(argc, argv);
    xsi_register_info(&xsi_info);

    xsi_register_min_prec_unit(-12);
    ieee_p_2592010699_init();
    ieee_p_3499444699_init();
    ieee_p_3620187407_init();
    work_a_2683404259_3212880686_init();
    work_a_3323112796_3212880686_init();
    work_a_4204489651_3212880686_init();
    work_a_2106061457_3212880686_init();
    work_a_0352376499_3212880686_init();
    work_a_3090695112_3212880686_init();
    work_a_3502204906_3212880686_init();
    work_a_1275585856_3212880686_init();
    work_a_3451019812_3212880686_init();
    work_a_2440385771_3212880686_init();
    work_a_1183605162_3212880686_init();
    work_a_0448807928_3212880686_init();
    work_a_1965620090_3212880686_init();
    work_a_0498065240_3212880686_init();
    work_a_2279567875_3212880686_init();
    work_a_1024383897_3212880686_init();


    xsi_register_tops("work_a_1024383897_3212880686");

    IEEE_P_2592010699 = xsi_get_engine_memory("ieee_p_2592010699");
    xsi_register_ieee_std_logic_1164(IEEE_P_2592010699);
    STD_STANDARD = xsi_get_engine_memory("std_standard");
    IEEE_P_3499444699 = xsi_get_engine_memory("ieee_p_3499444699");
    IEEE_P_3620187407 = xsi_get_engine_memory("ieee_p_3620187407");

    return xsi_run_simulation(argc, argv);

}
