insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.3.0.01_SP_20151028','11.3.0.01',sysdate);
commit;





update  oa_custmenu set LEFTURLSet='/defaultroot/platform/system/transcenter/loginCheck.jsp?module=workflow'||'&'||'reurl=/defaultroot/platform/bpm/bpm_menu_transcenter.jsp'||'&'||'menuName=交换平台工作流',righturlset='/defaultroot/platform/system/transcenter/loginCheck.jsp?module=workflow'||'&'||'reurl=/defaultroot/bpmscope!canStart.action?myCommon=0%26moduleId=1' where MENUCODESet='exchange_workflow';
commit;

update  org_employee   set   skin='2015/color_default'  where   skin='2015/color1';
commit;
update  org_employee   set   skin='2015/color_orange'  where   skin='2015/color2';
commit;
update  org_employee   set   skin='2015/color_green'  where   skin='2015/color3';
commit;
update  org_employee   set   skin='2015/color_linered'  where   skin='2015/color4';
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.3.0.02_SP_20151110','11.3.0.02',sysdate);
commit;





insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.3.0.03_SP_20151112','11.3.0.03',sysdate);
commit;