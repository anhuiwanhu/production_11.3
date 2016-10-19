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






-- Create table
create table USER_ORG_SYN_ERRLOG
(id            NUMBER(20) not null,
  create_date   VARCHAR2(20),
  username      VARCHAR2(20),
  phonenum      VARCHAR2(11),
  orgid         VARCHAR2(30),
  empid         VARCHAR2(30),
  orgname       VARCHAR2(100),
  result        VARCHAR2(100),
  event         VARCHAR2(20),
  user_org_flag VARCHAR2(1)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Add comments to the columns 
comment on column USER_ORG_SYN_ERRLOG.create_date
  is '创建时间';
comment on column USER_ORG_SYN_ERRLOG.username
  is '姓名';
comment on column USER_ORG_SYN_ERRLOG.phonenum
  is '手机号码';
comment on column USER_ORG_SYN_ERRLOG.orgid
  is '组织ID';
comment on column USER_ORG_SYN_ERRLOG.empid
  is '用户ID';
comment on column USER_ORG_SYN_ERRLOG.orgname
  is '组织名称';
comment on column USER_ORG_SYN_ERRLOG.result
  is '结果';
comment on column USER_ORG_SYN_ERRLOG.event
  is '事件';
comment on column USER_ORG_SYN_ERRLOG.user_org_flag
  is '标记 0-用户，1-组织';
-- Create/Recreate primary, unique and foreign key constraints 
alter table USER_ORG_SYN_ERRLOG
  add constraint PK_USER_ORG_SYN_ERRLOG primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
commit;
-- Create table
create table SYS_CORP_SET_APP
(id      NUMBER(20) not null,
  appname VARCHAR2(50),
  appid   VARCHAR2(50),
  corpid  VARCHAR2(50)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table SYS_CORP_SET_APP
  add primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
commit;
-- Create table
create table SYS_CORP_SET
( id             NUMBER(20) not null,
  corpid         VARCHAR2(50),
  corpsecret     VARCHAR2(500),
  token          VARCHAR2(500),
  encodingaeskey VARCHAR2(500)
)
tablespace USERS
  pctfree 10
  initrans 1
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
-- Create/Recreate primary, unique and foreign key constraints 
alter table SYS_CORP_SET
  add primary key (ID)
  using index 
  tablespace USERS
  pctfree 10
  initrans 2
  maxtrans 255
  storage
  (
    initial 64K
    next 1M
    minextents 1
    maxextents unlimited
  );
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.3.0.11_SP_20160111','11.3.0.11',sysdate);
commit;





update wf_immobilityfield set immofield_pofield = CONCAT('information.',immofield_pofield) 
where wf_immoform_id = (select wf_immoform_id from ezoffice.WF_IMMOBILITYFORM where WF_MODULE_ID = 4) and instr(immofield_pofield,'.')=0;
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.3.0.12_SP_20160117','11.3.0.12',sysdate);
commit;





alter table wf_work modify workStepCount number(3);
commit;
alter table GOV_DOCUMENTSENDFILE modify sendtomyname varchar2(2000);
commit;
insert into oa_patchinfo (patch_id,patch_editinfo,patch_name,patch_version,patch_time) values(hibernate_sequence.nextval,'Wanhu ezOFFICE','11.3.0.13_SP_20160129','11.3.0.13',sysdate);
commit;