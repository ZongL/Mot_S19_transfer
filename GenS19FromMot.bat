 
C:\srecord\bin\srec_cat XXXXXXX.mot -exclude 0x343A8000 0x343A8138 -o zTemp00.srec

C:\srecord\bin\srec_cat zTemp00.srec -fill 0x1A 0x342FFE00 0x342FFE01 -fill 0x2B 0x342FFE01 0x342FFE02 -fill 0x3C 0x342FFE02 0x342FFE03 -fill 0x4D 0x342FFE03 0x342FFE04 --output zTemp11.srec

C:\srecord\bin\srec_cat zTemp11.srec Didi_CAL_0824.s19 -o mergedCAL.srec

C:\srecord\bin\srec_cat mergedCAL.srec -fill 0x1A 0x3477FE00 0x3477FE01 -fill 0x2B 0x3477FE01 0x3477FE02 -fill 0x3C 0x3477FE02 0x3477FE03 -fill 0x4D 0x3477FE03 0x3477FE04  --output mergedCALFilled.srec


C:\srecord\bin\srec_cat bootloader.img -binary -offset 0x33000000 -o bootloaderoffset.srec
C:\srecord\bin\srec_cat mergedCALFilled.srec bootloaderoffset.srec -o mergedCAL_UBoot.srec
C:\srecord\bin\srec_cat mergedCAL_UBoot.srec -fill 0x1A 0x333FFE00 0x333FFE01 -fill 0x2B 0x333FFE01 0x333FFE02 -fill 0x3C 0x333FFE02 0x333FFE03 -fill 0x4D 0x333FFE03 0x333FFE04  --output mergedCAL_UBootFilled.srec


C:\srecord\bin\srec_cat 20221214_didi_E5_gPTP_fw_config.bin -binary -offset 0x33500000 -o Switchoffset.srec
C:\srecord\bin\srec_cat mergedCAL_UBootFilled.srec Switchoffset.srec -o mergedCAL_UBoot_Switch.srec
C:\srecord\bin\srec_cat mergedCAL_UBoot_Switch.srec -fill 0x1A 0x336FFE00 0x336FFE01 -fill 0x2B 0x336FFE01 0x336FFE02 -fill 0x3C 0x336FFE02 0x336FFE03 -fill 0x4D 0x336FFE03 0x336FFE04  --output mergedCAL_UBoot_SwitchFilled.srec

C:\srecord\bin\srec_cat mergedCAL_UBoot_SwitchFilled.srec -fill 0x00 -within mergedCAL_UBoot_SwitchFilled.srec -range-pad 256 --output XXXXXXX_out.s19

del zTemp00.srec
del zTemp11.srec
del mergedCAL.srec
del mergedCALFilled.srec
del bootloaderoffset.srec
del mergedCAL_UBoot.srec
del mergedCAL_UBootFilled.srec
del Switchoffset.srec
del mergedCAL_UBoot_Switch.srec
del mergedCAL_UBoot_SwitchFilled.srec


pause
