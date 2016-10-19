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





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.3.0.04_SP_20151120','11.3.0.04',getdate());
go






update oa_custmenu  set menu_name='人事' where menu_name='人事管理' and menuparentset=0;
go
update oa_custmenu   set  menu_name='流程' where menu_name='工作流程' and menuparentset=0;
go
update oa_custmenu   set  menu_name='信息' where menu_name='信息管理' and menuparentset=0;
go
update oa_custmenu   set  menu_name='公文' where menu_name='公文管理' and menuparentset=0;
go
update oa_custmenu   set  menu_name='邮件' where menu_name='内部邮件' and menuparentset=0;
go
update oa_custmenu   set  menu_name='文库' where menu_name='知识文库' and menuparentset=0;
go
update oa_custmenu   set  menu_name='定位' where menu_name='定位服务' and menuparentset=0;
go
update oa_custmenu   set  menu_name='档案' where menu_name='档案管理' and menuparentset=0;
go
update oa_custmenu   set  menu_name='文档' where menu_name='文档管理' and menuparentset=0;
go
update oa_custmenu   set  menu_name='关系' where menu_name='关系管理' and menuparentset=0;
go
update oa_custmenu   set  menu_name='预算' where menu_name='预算管理' and menuparentset=0;
go

insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.3.0.05_SP_20151127','11.3.0.05',getdate());
go





-----修改收文表备用字段长度
alter table gov_receivefile  alter column   field5 nvarchar(1000);
go
alter table gov_receivefile  alter column   field6 nvarchar(1000);
go
alter table gov_receivefile  alter column   field7 nvarchar(1000);
go
alter table gov_receivefile  alter column   field8 nvarchar(1000);
go
alter table gov_receivefile  alter column   field9 nvarchar(2000);
go
alter table gov_receivefile  alter column   field10 nvarchar(2000);
go

-------修改发文表字段长度
alter table gov_documentsendfile  alter column   field5 nvarchar(1000);
go
alter table gov_documentsendfile  alter column   field6 nvarchar(1000);
go
alter table gov_documentsendfile  alter column   field7 nvarchar(1000);
go
alter table gov_documentsendfile  alter column   field8 nvarchar(1000);
go
alter table gov_documentsendfile  alter column   field9 nvarchar(2000);
go
alter table gov_documentsendfile  alter column   field10 nvarchar(2000);
go


-------修改文件送审签字段长度
alter table gov_sendfilecheckwithworkflow  alter column   field2 nvarchar(1000);
go
alter table gov_sendfilecheckwithworkflow  alter column   field3 nvarchar(1000);
go
alter table gov_sendfilecheckwithworkflow  alter column   field4 nvarchar(1000);
go
alter table gov_sendfilecheckwithworkflow  alter column   field5 nvarchar(1000);
go
alter table gov_sendfilecheckwithworkflow  alter column   field6 nvarchar(1000);
go
alter table gov_sendfilecheckwithworkflow  alter column   field7 nvarchar(1000);
go
alter table gov_sendfilecheckwithworkflow  alter column   field8 nvarchar(1000);
go
alter table gov_sendfilecheckwithworkflow  alter column   field9 nvarchar(2000);
go
alter table gov_sendfilecheckwithworkflow  alter column   field10 nvarchar(2000);
go




-------修改自定义字段表中 字段大小 modify by gexiang 
update tfield set field_len = 1000 where  field_table in (select table_id from ttable where wf_module_id in (2,3))
and field_code in ('field5','field6','field7','field8','field9','field10')
go

update tfield set field_len = 1000 where  field_table in (select table_id from ttable where wf_module_id in (34))
and field_code in ('field2','field3','field4','field5','field6','field7','field8','field9','field10')
go

insert into  EZ_SECU_PAGELIST(SECU_URL,LIST_TYPE)values('/public/iWebOfficeSign/OfficeServer.jsp',1);
go
insert into  EZ_SECU_PAGELIST(SECU_URL,LIST_TYPE)values('/public/iWebOfficeSign/OfficeServer.jsp',3);
go

insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.3.0.06_SP_20151207','11.3.0.06',getdate());
go





update wf_needFlowModule set module_packrighttype = '26*08*26',module_procright=1,module_procrighttype = '26*08*26',module_channowrite=1 where wf_module_id = 36;
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.3.0.07_SP_20151211','11.3.0.07',getdate());
go
