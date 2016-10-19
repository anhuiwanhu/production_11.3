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





-----修改收文表备用字段长度
alter table GOV_RECEIVEFILE modify  field5 varchar2(1000);
commit;
alter table GOV_RECEIVEFILE modify  field6 varchar2(1000);
commit;
alter table GOV_RECEIVEFILE modify  field7 varchar2(1000);
commit;
alter table GOV_RECEIVEFILE modify  field8 varchar2(1000);
commit;
alter table GOV_RECEIVEFILE modify  field9 varchar2(2000);
commit;
alter table GOV_RECEIVEFILE modify  field10 varchar2(2000);
commit;

-------修改发文表字段长度
alter table gov_documentsendfile modify  field5 varchar2(1000);
commit;
alter table gov_documentsendfile modify  field6 varchar2(1000);
commit;
alter table gov_documentsendfile modify  field7 varchar2(1000);
commit;
alter table gov_documentsendfile modify  field8 varchar2(1000);
commit;
alter table gov_documentsendfile modify  field9 varchar2(2000);
commit;
alter table gov_documentsendfile modify  field10 varchar2(2000);
commit;

-------修改文件送审签字段长度
alter table gov_sendfilecheckwithworkflow modify  field2 varchar2(1000);
commit;
alter table gov_sendfilecheckwithworkflow modify  field3 varchar2(1000);
commit;
alter table gov_sendfilecheckwithworkflow modify  field4 varchar2(1000);
commit;
alter table gov_sendfilecheckwithworkflow modify  field5 varchar2(1000);
commit;
alter table gov_sendfilecheckwithworkflow modify  field6 varchar2(1000);
commit;
alter table gov_sendfilecheckwithworkflow modify  field7 varchar2(1000);
commit;
alter table gov_sendfilecheckwithworkflow modify  field8 varchar2(1000);
commit;
alter table gov_sendfilecheckwithworkflow modify  field9 varchar2(2000);
commit;
alter table gov_sendfilecheckwithworkflow modify  field10 varchar2(2000);
commit;

-------修改自定义字段表中 字段大小 modify by gexiang 
update tfield set field_len = 1000 where  field_table in (select table_id from ttable where wf_module_id in (2,3))
and field_code in ('field5','field6','field7','field8','field9','field10');
commit;

update tfield set field_len = 1000 where  field_table in (select table_id from ttable where wf_module_id in (34))
and field_code in ('field2','field3','field4','field5','field6','field7','field8','field9','field10');
commit;

insert into  EZ_SECU_PAGELIST(SECU_URL,LIST_TYPE)values('/public/iWebOfficeSign/OfficeServer.jsp',1);
commit;
insert into  EZ_SECU_PAGELIST(SECU_URL,LIST_TYPE)values('/public/iWebOfficeSign/OfficeServer.jsp',3);
commit;

insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.3.0.06_SP_20151207','11.3.0.06',sysdate);
commit;





update wf_needFlowModule a set a.module_packrighttype = '26*08*26',a.module_procright=1,a.module_procrighttype = '26*08*26',a.module_channowrite=1 where a.wf_module_id = 36;
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.3.0.07_SP_20151211','11.3.0.07',sysdate);
commit;





insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.3.0.08_SP_20151218','11.3.0.08',sysdate);
commit;





create table oa_informationchannel_yibo  (
   YiBoChannel_Id                NUMBER(20)         not null,
   YiBoChannelName              VARCHAR2(40),
   Domain_Id                    NUMBER(20),
   YiBoChannelSort                NUMBER(6),
   Channel_Id                    NUMBER(20),
   YiBoCreatedEmp                NUMBER(20),
   YiBoCreatedEmpName           VARCHAR2(60),
   YiBoCreatedOrgId               NUMBER(20),
   YiBoCreatedTime               DATE,
   YiBoPlayNum                  NUMBER(8),
   YiBoChannelPosition            NUMBER(2),
   PositonUpDown                NUMBER(1),
   constraint pk_oa_informationchannel_yibo primary key (YiBoChannel_Id)
);
commit;

-- 信息频道表增加 是否是易播栏目标识 字段，初始赋值‘0’
alter table oa_informationchannel add IsYiBoChannel  VARCHAR2(1)  default '0';
commit;

alter table Org_domain add yibo_flag varchar2(1) default 0;
commit;
update Org_domain set yibo_flag = '0';
commit;

--新增易播栏目设置的维护权限
insert into org_right
  (right_id,
   rightname,
   righttype,
   rightclass,
   righthasscope,
   rightselectrange,
   rightdescription,
   rightcode,
   domain_id)
values
  (hibernate_sequence.nextval,
   '维护',
   '易播栏目',
   '信息管理',
   1,
   '11111',
   '全部/本人/本组织及下属组织/本组织/自定义',
   'yibo*01*01',
   0);
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.3.0.09_SP_20151229','11.3.0.09',sysdate);
commit;





insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.3.0.10_SP_20160104','11.3.0.10',sysdate);
commit;