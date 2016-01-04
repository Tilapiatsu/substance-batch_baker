@echo off

:: Autor : tilapiatsu.fr
:: Contact : contact@tilapiatsu.fr

:: Path
set mesh_folder=C:\Batch
set output_folder=C:\Batch\Output

:: Constant
set batch_path=C:\Program Files\Allegorithmic\Substance BatchTools\5
set baker=%batch_path%\sbsbaker.exe
set template_file=%~dp0\baking_template.txt
set batch_file=%output_folder%\batch.bat

:: -----------------------------------------------------------------------------------------------
:: -----------------------------------------------------------------------------------------------
:: File
set lp_suffix=_low
set hp_suffix=_high
set lp_suffix_length=4
set mesh_format=fbx
set output_format=tga

:: For more information about the Substance baker parameter please visite : https://support.allegorithmic.com/documentation/display/SB10/sbsbaker

:: Export
set size=6

:: Baker To Use
set baker_type=%batch_path%\plugins\tangentspace\unitytspace.dll
:: set baker_type=%batch_path%\plugins\tangentspace\mikktspace.dll

:: Normal
set normal_invert=0

:: HighPoly Raycast
set front_distance=0.03
set back_distance=0.03
set dilatation=16
set match=0

:: Occlusion
set occ_max_distance=3
set occ_spread_angle=180
set occ_self_occlusion=0

:: Curvature
set curvature_detail=0.5
set curvature_seam=1.0

:: Baker : set to 1 to bake, 0 to disable
set b_normal_world_space=1
set b_curvature=1
set b_position=1
set b_thickness_from_mesh=1
set b_ambient_occlusion_from_mesh=1
set b_uv_map=1
set b_height_from_mesh=1
set b_ambient_occlusion=1

:: -----------------------------------------------------------------------------------------------
:: ---------------------------------!!!! DO NOT EDIT FROM HERE !!!!-------------------------------
:: -----------------------------------------------------------------------------------------------

setlocal ENABLEDELAYEDEXPANSION


:: path construction (msdos path compatibility, no space)
for %%I in ("%baker%") do set baker=%%~sI
for %%I in ("%output_folder%") do set output_folder=%%~sI
for %%I in ("%mesh_folder%") do set mesh_folder=%%~sI
for %%I in ("%template_file%") do set template_file=%%~sI
for %%I in ("%batch_file%") do set batch_file=%%~sI
for %%I in ("%baker_type%") do set baker_type=%%~sI

:: Path
echo @echo off> %batch_file%
echo set baker=%baker%>> %batch_file%
echo set output_folder=%output_folder%>> %batch_file%
echo set baker_type=%baker_type%>> %batch_file%

pause

echo set lp_suffix=%lp_suffix%>> %batch_file%
echo set hp_suffix=%hp_suffix%>> %batch_file%
echo set mesh_format=%mesh_format%>> %batch_file%
echo set output_format=%output_format%>> %batch_file%

:: Export
echo set size=%size% >> %batch_file%

:: High PolyRaycast
echo set front_distance=%front_distance%>> %batch_file%
echo set back_distance=%back_distance%>> %batch_file%
echo set dilatation=%dilatation%>> %batch_file%
echo set match=%match% >> %batch_file%

:: Normal
echo set normal_invert=%normal_invert% >> %batch_file%

:: Occlusion
echo set occ_max_distance=%occ_max_distance% >> %batch_file%
echo set occ_spread_angle=%occ_spread_angle% >> %batch_file%
echo set occ_self_occlusion=%occ_self_occlusion% >> %batch_file%


:: Curvature
echo set curvature_detail=%curvature_detail%>>%batch_file%
echo set curvature_seam=%curvature_seam%>>%batch_file%

:: Baker
echo set b_normal_world_space="%b_normal_world_space%">> %batch_file%
echo set b_curvature="%b_curvature%">> %batch_file%
echo set b_position="%b_position%">> %batch_file%
echo set b_thickness_from_mesh="%b_thickness_from_mesh%">> %batch_file%
echo set b_ambient_occlusion_from_mesh="%b_ambient_occlusion_from_mesh%">> %batch_file%
echo set b_uv_map="%b_uv_map%">> %batch_file%
echo set b_height_from_mesh="%b_height_from_mesh%">> %batch_file%
echo set b_ambient_occlusion="%b_ambient_occlusion%">> %batch_file%


echo pause >> %batch_file%

for /f %%i in ('dir /d/b %mesh_folder%\*%lp_suffix%.%mesh_format%') do (

set mesh_base_name=%%i

echo set mesh_base_name=%%~ni>> %batch_file%

echo set lp="%mesh_folder%\%%i">> %batch_file%
echo set hp="%mesh_folder%\%%mesh_base_name:~0,-!lp_suffix_length!%%%hp_suffix%.%mesh_format%">> %batch_file%

echo echo --------------------------------------------------------------------------------------------------------- >> %batch_file%
echo echo ------------------------------- processing %%i ------------------------------- >> %batch_file%
echo echo --------------------------------------------------------------------------------------------------------- >> %batch_file%
echo echo. >> %batch_file%

type %template_file% >> %batch_file%

echo echo. >> %batch_file%
echo echo. >> %batch_file%
echo echo. >> %batch_file%

)
echo pause >>%batch_file%
echo ------------------------------- Batch File Created -------------------------------
pause



