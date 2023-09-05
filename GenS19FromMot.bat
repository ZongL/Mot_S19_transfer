C:\srecord\bin\srec_cat *.mot -exclude 0x20000004 0x200001AC -o zTemp00.srec

C:\srecord\bin\srec_cat zTemp00.srec -fill 0x1A 0x342FFE00 0x342FFE01 -fill 0x2B 0x342FFE01 0x342FFE02 -fill 0x3C 0x342FFE02 0x342FFE03 -fill 0x4D 0x342FFE03 0x342FFE04 --output mergedCAL.srec

::C:\srecord\bin\srec_cat zTemp11.srec Didi_CAL_0824.s19 -o mergedCAL.srec

C:\srecord\bin\srec_cat mergedCAL.srec -fill 0x1A 0x347FFE00 0x347FFE01 -fill 0x2B 0x347FFE01 0x347FFE02 -fill 0x3C 0x347FFE02 0x347FFE03 -fill 0x4D 0x347FFE03 0x347FFE04  --output mergedCALFilled.srec


C:\srecord\bin\srec_cat *.img -binary -offset 0x33000000 -o bootloaderoffset.srec
C:\srecord\bin\srec_cat mergedCALFilled.srec bootloaderoffset.srec -o mergedCAL_UBoot.srec
C:\srecord\bin\srec_cat mergedCAL_UBoot.srec -fill 0x1A 0x333FFE00 0x333FFE01 -fill 0x2B 0x333FFE01 0x333FFE02 -fill 0x3C 0x333FFE02 0x333FFE03 -fill 0x4D 0x333FFE03 0x333FFE04  --output mergedCAL_UBootFilled.srec


C:\srecord\bin\srec_cat *.bin -binary -offset 0x33500000 -o Switchoffset.srec
C:\srecord\bin\srec_cat mergedCAL_UBootFilled.srec Switchoffset.srec -o mergedCAL_UBoot_Switch.srec
C:\srecord\bin\srec_cat mergedCAL_UBoot_Switch.srec -fill 0x1A 0x336FFE00 0x336FFE01 -fill 0x2B 0x336FFE01 0x336FFE02 -fill 0x3C 0x336FFE02 0x336FFE03 -fill 0x4D 0x336FFE03 0x336FFE04  --output mergedCAL_UBoot_SwitchFilled.srec

C:\srecord\bin\srec_cat mergedCAL_UBoot_SwitchFilled.srec -fill 0x00 -within mergedCAL_UBoot_SwitchFilled.srec -range-pad 256 --output NoCMAC_mcu.s19 -disable=data-count

del *.srec
 
echo "add CMAC to S19"
 
::pause

C:\srecord\bin\srec_cat NoCMAC_mcu.s19 -crop 0x34000000 0x342FFCFF -o data_extract.srec

C:\srecord\bin\srec_cat data_extract.srec -fill 0xFF 0x34000000 0x342FFD00 -o data_extract_new.srec

C:\srecord\bin\srec_cat data_extract_new.srec -offset -0x34000000 -o data.binn -Binary

cmac_gen.exe

C:\srecord\bin\srec_cat CMAC.binn -binary -offset 0x342FFD00 -o CMAC.binn.srec

C:\srecord\bin\srec_cat NoCMAC_mcu.s19 CMAC.binn.srec -o mcu.img -disable=data-count
del *.srec

::pause
