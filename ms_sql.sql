insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.3.0.01_SP_20151028','11.3.0.01',getdate());
go






update  oa_custmenu set LEFTURLSet='/defaultroot/platform/system/transcenter/loginCheck.jsp?module=workflow&reurl=/defaultroot/platform/bpm/bpm_menu_transcenter.jsp&menuName=交换平台工作流',righturlset='/defaultroot/platform/system/transcenter/loginCheck.jsp?module=workflow&reurl=/defaultroot/bpmscope!canStart.action?myCommon=0%26moduleId=1' where MENUCODESet='exchange_workflow';
go

alter table  org_employee  alter column SKIN nvarchar(100);
go
update  org_employee   set   skin='2015/color_default'  where   skin='2015/color1';
go
update  org_employee   set   skin='2015/color_orange'  where   skin='2015/color2';
go
update  org_employee   set   skin='2015/color_green'  where   skin='2015/color3';
go
update  org_employee   set   skin='2015/color_linered'  where   skin='2015/color4';
go

insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.3.0.02_SP_20151110','11.3.0.02',getdate());
go






insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.3.0.03_SP_20151112','11.3.0.03',getdate());
go
