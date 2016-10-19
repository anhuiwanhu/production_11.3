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





insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.3.0.04_SP_20151120','11.3.0.04',sysdate);
commit;





update oa_custmenu ss set ss.menu_name='人事' where ss.menu_name='人事管理' and ss.menuparentset=0;
commit;
update oa_custmenu ss set ss.menu_name='流程' where ss.menu_name='工作流程' and ss.menuparentset=0;
commit;
update oa_custmenu ss set ss.menu_name='信息' where ss.menu_name='信息管理' and ss.menuparentset=0;
commit;
update oa_custmenu ss set ss.menu_name='公文' where ss.menu_name='公文管理' and ss.menuparentset=0;
commit;
update oa_custmenu ss set ss.menu_name='邮件' where ss.menu_name='内部邮件' and ss.menuparentset=0;
commit;
update oa_custmenu ss set ss.menu_name='文库' where ss.menu_name='知识文库' and ss.menuparentset=0;
commit;
update oa_custmenu ss set ss.menu_name='定位' where ss.menu_name='定位服务' and ss.menuparentset=0;
commit;
update oa_custmenu ss set ss.menu_name='档案' where ss.menu_name='档案管理' and ss.menuparentset=0;
commit;
update oa_custmenu ss set ss.menu_name='文档' where ss.menu_name='文档管理' and ss.menuparentset=0;
commit;
update oa_custmenu ss set ss.menu_name='关系' where ss.menu_name='关系管理' and ss.menuparentset=0;
commit;
update oa_custmenu ss set ss.menu_name='预算' where ss.menu_name='预算管理' and ss.menuparentset=0;
commit;

insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.3.0.05_SP_20151127','11.3.0.05',sysdate);
commit;