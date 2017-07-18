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





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.3.0.08_SP_20151218','11.3.0.08',getdate());
go





--新增 信息管理-易播频道信息表
create table oa_informationchannel_yibo  (
   YiBoChannel_Id                NUMERIC(20) IDENTITY(1,1)  not null  primary key,
   YiBoChannelName               NVARCHAR(40),
   Domain_Id                     NUMERIC(20) ,
   YiBoChannelSort                NUMERIC(6) ,
   Channel_Id                    NUMERIC(20) ,
   YiBoCreatedEmp                NUMERIC(20) ,
   YiBoCreatedEmpName            NVARCHAR (60),
   YiBoCreatedOrgId               NUMERIC(20),
   YiBoCreatedTime               DATETIME,
   YiBoPlayNum                   NUMERIC(8),
   YiBoChannelPosition            INT ,
   PositonUpDown                  INT 
);
go
-- 信息频道表增加 是否是易播栏目标识 字段，初始赋值‘0’
alter table oa_informationchannel add IsYiBoChannel  NVARCHAR (1)  default '0';
go

alter table Org_domain add yibo_flag varchar(1) default 0;
go
update Org_domain set yibo_flag = '0';
go
insert into org_right
  (rightname,
   righttype,
   rightclass,
   righthasscope,
   rightselectrange,
   rightdescription,
   rightcode,
   domain_id)
values
  ('维护',
   '易播栏目',
   '信息管理',
   1,
   '11111',
   '全部/本人/本组织及下属组织/本组织/自定义',
   'yibo*01*01',
   0);
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.3.0.09_SP_20151229','11.3.0.09',getdate());
go





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.3.0.10_SP_20160104','11.3.0.10',getdate());
go






CREATE TABLE user_org_syn_errlog(
	id numeric(20) IDENTITY(1,1) NOT NULL primary key,
	create_date nvarchar(20) NULL,
	empid nvarchar(30) NULL,
	username nvarchar(20) NULL,
	orgid nvarchar(30) NULL,
	orgname nvarchar(100) NULL,
	event nvarchar(20) NULL,
	result nvarchar(100) NULL,
	user_org_flag nvarchar(1) NULL,
	phonenum nvarchar(11) NULL
	);
go
CREATE TABLE SYS_CORP_SET_APP(id numeric(20) IDENTITY(1,1) NOT NULL primary key,
	corpid nvarchar(50) NULL,
	appname nvarchar(50) NULL,
	appid nvarchar(50) NULL
	);
go

CREATE TABLE EZOFFICE.SYS_CORP_SET(id numeric(20) IDENTITY(1,1) NOT NULL primary key,
	corpid nvarchar(50) NULL,
	corpsecret nvarchar(500) NULL,
	token nvarchar(500) NULL,
	encodingaeskey nvarchar(500) NULL
	);
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.3.0.11_SP_20160111','11.3.0.11',getdate());
go





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.3.0.12_SP_20160117','11.3.0.12',getdate());
go





alter table wf_work alter column workStepCount numeric(3,0);
go
alter table GOV_DOCUMENTSENDFILE alter column sendtomyname varchar(2000);
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.3.0.13_SP_20160129','11.3.0.13',getdate());
go





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.3.0.14_SP_20160303','11.3.0.14',getdate());
go





alter table EZ_FLOW_HI_PROCINST alter column WHIR_DEALING_USERS nvarchar(1000);
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.3.0.15_SP_20160314','11.3.0.15',getdate());
go





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.3.0.16_SP_20160322','11.3.0.16',getdate());
go





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.3.0.17_SP_20160328','11.3.0.17',getdate());
go





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.3.0.18_SP_20160411','11.3.0.18',getdate());
go




insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.3.0.19_SP_20160505','11.3.0.19',getdate());
go





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.3.0.20_SP_20160510','11.3.0.20',getdate());
go





insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.3.0.21_SP_20160525','11.3.0.21',getdate());
go





delete from  ez_secu_pagelist  where    list_type=3  and   secu_url='/officeserverservlet';
go
insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.3.0.22_SP_20160529','11.3.0.22',getdate());
go







insert into oa_patchinfo (patch_editinfo,patch_name,patch_version,patch_time) values('Wanhu ezOFFICE','11.3.0.23_SP_20160714','11.3.0.23',getdate());
go