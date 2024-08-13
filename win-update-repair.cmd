@echo off

:: Windows RE'yi devre dışı bırak
reagentc /disable

:: Diskpart komutlarını çalıştır
echo select disk 0 > %temp%\diskpart_commands.txt
echo select part 3 >> %temp%\diskpart_commands.txt
echo shrink desired=250 >> %temp%\diskpart_commands.txt
echo create partition primary id=de94bba4-06d1-4d40-a16a-bfd50179d6ac >> %temp%\diskpart_commands.txt
echo gpt attributes=0x8000000000000001 >> %temp%\diskpart_commands.txt
echo format quick fs=ntfs label="Windows RE tools" >> %temp%\diskpart_commands.txt

diskpart /s %temp%\diskpart_commands.txt

:: Geçici dosyayı sil
del %temp%\diskpart_commands.txt

:: Windows RE'yi yeniden etkinleştir
reagentc /enable

echo İşlem tamamlandı.
pause
