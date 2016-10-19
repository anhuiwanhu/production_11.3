<%@ page contentType="text/html; charset=UTF-8" pageEncoding="UTF-8"%>
<%@ page import="java.io.*" %>
<%@ page import="java.text.*" %>
<%@ page import="java.util.*" %>
<%@ page import="java.sql.*" %>
<%@ page import="DBstep.iMsgServer2000.*" %>
<%@ page import="DBstep.iDBManager2000.*" %>
<%@ page import="java.text.SimpleDateFormat" %>
<%@ page import="java.text.DateFormat" %>
<%@ page import="java.util.Date" %>
<%@ page import="oracle.sql.BLOB" %>
<%@ page import="oracle.jdbc.*" %>

<%!
public class iWebOffice {
 private int mFileSize;
 private byte[] mFileBody;
 private String mFileName;
 private String mFileType;
 private String mFileDate;
 private String mFileID;


 private String mRecordID;
 private String mTemplate;
 private String mDateTime;
 private String mOption;
 private String mMarkName;
 private String mPassword;
 private String mMarkList;
 private String mBookmark;
 private String mDescript;
 private String mHostName;
 private String mMarkGuid;
 private String mCommand;
 private String mContent;
 private String mHtmlName;
 private String mDirectory;
 private String mFilePath;

 private String mUserName;
 private int mColumns;
 private int mCells;
 private String mMyDefine1;
 private String mLocalFile;
 private String mRemoteFile;
 private String mLabelName;
 private String mImageName;
 private String mTableContent;

 private String Sql;

 //打印控制
 private String mOfficePrints;
 private int mCopies; 

 //自定义信息传递
 private String mInfo;

 private DBstep.iMsgServer2000 MsgObj;
 private DBstep.iDBManager2000 DbaObj;

 private String databaseType=com.whir.common.config.SystemCommon.getDatabaseType();

 private int mTemplateId;

 private int c_userId;
 private int c_orgId;


// ************* Bolb字段处理、公共函数、接收流、写回流代码    开始  *******************************
 private void PutAtBlob(BLOB vField,int vSize) throws IOException
 {
   try
   {
     OutputStream outstream=vField.getBinaryOutputStream();
     outstream.write(mFileBody,0, vSize);
     outstream.close();
   }
   catch(SQLException e)
   {

   }
 }

 private void GetAtBlob(BLOB vField,int vSize) throws IOException
 {
   try
   {
     mFileBody = new byte[vSize];
     InputStream instream=vField.getBinaryStream();
     instream.read(mFileBody,0,vSize);
     instream.close();
   }
   catch(SQLException e)
   {

   }
 }
  /**
   * 功能或作用：格式化日期时间
   * @param DateValue 输入日期或时间
   * @param DateType 格式化 EEEE是星期, yyyy是年, MM是月, dd是日, HH是小时, mm是分钟,  ss是秒
   * @return 输出字符串
   */
  public String FormatDate(String DateValue,String DateType)
  {
    String Result;
    SimpleDateFormat formatter = new SimpleDateFormat(DateType);
    try{
      Date mDateTime = formatter.parse(DateValue);
      Result = formatter.format(mDateTime);
    }catch(Exception ex){
      Result = ex.getMessage();
    }
    if (Result.equalsIgnoreCase("1900-01-01")){
      Result = "";
    }
    return Result;
  }

//取得客户端发来的数据包
private byte[] ReadPackage(HttpServletRequest request)
{
  byte mStream[]=null;
  int totalRead = 0;
  int readBytes = 0;
  int totalBytes = 0;
  try
  {
    totalBytes = request.getContentLength();
    mStream = new byte[totalBytes];
    while(totalRead < totalBytes)
    {
      request.getInputStream();
      readBytes = request.getInputStream().read(mStream, totalRead, totalBytes - totalRead);
      totalRead += readBytes;
      continue;
    }
  }
  catch (Exception e)
  {
    System.out.println(e.toString());
  }
  return (mStream);
}

//发送处理后的数据包
  private void SendPackage(HttpServletResponse response)
  {
    try
    {
      ServletOutputStream OutBinarry=response.getOutputStream() ;
      OutBinarry.write(MsgObj.MsgVariant()) ;
      OutBinarry.flush();
      OutBinarry.close();
    }
    catch(IOException e)
    {
      System.out.println(e.toString());
    }
  }
// ************* Bolb字段处理、公共函数、接收流、写回流代码    结束  *******************************


  // ************* 文档、模板管理代码    开始  *******************************

 //调出文档，将文档内容保存在mFileBody里，以便进行打包
  private boolean LoadFile()
  {
    boolean mResult = false;
    String Sql = "SELECT FileBody,FileSize FROM Document_File WHERE RecordID='" + mRecordID + "'";
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          if (result.next()) {
            try {				
				if ("oracle".equals(databaseType)) {
				mFileSize=result.getInt("FileSize");
	            GetAtBlob(((OracleResultSet)result).getBLOB("FileBody"),mFileSize);
                mResult = true ;				
				}else{
              mFileBody = result.getBytes("FileBody");
              if (result.wasNull()) {
                mFileBody = null;
              }
              mResult = true ;				
				}

            }
            catch (Exception ex) {
              System.out.println(ex.toString());
            }
          }
          result.close();
        }
        catch (SQLException e) {
          System.out.println(e.getMessage());
          mResult = false;
        }
      }
    }
    finally {
      DbaObj.CloseConnection();
    }
    return (mResult);
  }

 //保存文档，如果文档存在，则覆盖，不存在，则添加
  private boolean SaveFile()
  {
    boolean mResult = false;
    int iFileId = -1;
    String Sql = "SELECT * FROM Document_File WHERE RecordID='" + mRecordID + "'";
    String sizeSql="insert into OA_ALLATTACH (FILENAME,FILESIZE) values ('"+mFileName+"',"+mFileSize+")";
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          if (result.next()) {

				if ("oracle".equals(databaseType)) {

				Sql="update Document_File set FileID=?,RecordID=?,FileName=?,FileType=?,FileSize=?,FileDate=?,FileBody=EMPTY_BLOB(),FilePath=?,UserName=?,Descript=? WHERE RecordID='" + mRecordID + "'";
                iFileId=result.getInt("FileId");
			
			   }else if("mysql".equals(databaseType)){

				 Sql="update Document_File set RecordID=?,FileName=?,FileType=?,FileSize=?,FileDate=?,FileBody=?,FilePath=?,UserName=?,Descript=? WHERE RecordID='" + mRecordID + "'";

			   }else{	
				   
				 Sql="update Document_File set RecordID=?,FileName=?,FileType=?,FileSize=?,FileDate=?,FileBody=?,FilePath=?,UserName=?,Descript=? WHERE RecordID='" + mRecordID + "'";

			   }

			   sizeSql=" update  OA_ALLATTACH  set  FILESIZE="+mFileSize+" where  FILENAME= '"+mFileName+"'";
           
          }
          else {


			  if ("oracle".equals(databaseType)) {

				 Sql="insert into Document_File (FileID,RecordID,FileName,FileType,FileSize,FileDate,FileBody,FilePath,UserName,Descript) values (?,?,?,?,?,?,EMPTY_BLOB(),?,?,? )";
                  iFileId=DbaObj.GetMaxID("Document_File","FileId");
			
			   }else if("mysql".equals(databaseType)){

				  Sql="insert into Document_File (RecordID,FileName,FileType,FileSize,FileDate,FileBody,FilePath,UserName,Descript) values (?,?,?,?,?,?,?,?,? )";

			   }else{	
				   
				  Sql="insert into Document_File (RecordID,FileName,FileType,FileSize,FileDate,FileBody,FilePath,UserName,Descript) values (?,?,?,?,?,?,?,?,? )";

			   }
           
          }
          result.close();
        }
        catch (SQLException e) {
          System.out.println(e.toString());
          mResult = false;
        }

        java.sql.PreparedStatement prestmt=null;
        try {


		 if ("oracle".equals(databaseType)) {

	      prestmt =DbaObj.Conn.prepareStatement(Sql);
          prestmt.setInt(1,iFileId);
          prestmt.setString(2, mRecordID);
          prestmt.setString(3, mFileName);
          prestmt.setString(4, mFileType);
          prestmt.setInt(5, mFileSize);
          prestmt.setDate(6 ,DbaObj.GetDate());
          prestmt.setString(7, mFilePath);
          prestmt.setString(8, mUserName);
          prestmt.setString(9, mDescript);                                          //"通用版本"
          DbaObj.Conn.setAutoCommit(true) ;
          prestmt.execute();
          DbaObj.Conn.commit();
          prestmt.close();
          Statement stmt=null;
          DbaObj.Conn.setAutoCommit(false) ;
          stmt = DbaObj.Conn.createStatement();
          OracleResultSet update=(OracleResultSet)stmt.executeQuery("select FileBody from Document_File where Fileid=" + String.valueOf(iFileId)+ " for update");
          if (update.next()){
            try
            {
              PutAtBlob(((oracle.jdbc.OracleResultSet)update).getBLOB("FileBody"),mFileSize);
            }
            catch (IOException e) {
               System.out.println(e.toString());
               mResult = false;
            }
          }
          update.close();
          stmt.close();

          DbaObj.Conn.commit();
          mFileBody=null;
          mResult=true;
	
	   }else if("mysql".equals(databaseType)){

	      prestmt =DbaObj.Conn.prepareStatement(Sql);
          prestmt.setString(1, mRecordID);
          prestmt.setString(2, mFileName);
          prestmt.setString(3, mFileType);
          prestmt.setInt(4, mFileSize);
          prestmt.setString (5 ,mFileDate);
          prestmt.setBytes(6, mFileBody);
          prestmt.setString(7, mFilePath);
          prestmt.setString(8, mUserName);
          prestmt.setString(9, mDescript);                                          //"通用版本"
          //DbaObj.Conn.setAutoCommit(true) ;
          prestmt.execute();
          //DbaObj.Conn.commit();
          prestmt.close();
          mResult=true;

	   }else{	
		   
	      prestmt =DbaObj.Conn.prepareStatement(Sql);
          prestmt.setString(1, mRecordID);
          prestmt.setString(2, mFileName);
          prestmt.setString(3, mFileType);
          prestmt.setInt(4, mFileSize);
          prestmt.setString (5 ,mFileDate);
          prestmt.setBytes(6, mFileBody);
          prestmt.setString(7, mFilePath);
          prestmt.setString(8, mUserName);
          prestmt.setString(9, mDescript);                                          //"通用版本"
          DbaObj.Conn.setAutoCommit(true) ;
          prestmt.execute();
          DbaObj.Conn.commit();
          prestmt.close();
          mResult=true;
	   }

	    // System.out.println("-------------------:"+sizeSql);
         DbaObj.ExecuteUpdate(sizeSql);
          
        }
        catch (SQLException e) {
          System.out.println(e.toString());
          mResult = false;
        }
      }
    }
    finally {
      DbaObj.CloseConnection();
    }
    return (mResult);
  }

//调出模板文档，将模板文档内容保存在mFileBody里，以便进行打包
  private boolean LoadTemplate()
  {
    boolean mResult = false;
    String Sql = "SELECT FileBody,FileSize FROM Template_File WHERE RecordID='" + mTemplate + "'";
       
	   if(mTemplate!=null&&mTemplate.equals("")){
		    try {
				String myPath=mFilePath+"//iWebOfficeSign//Doc1.doc";
				if(mFileType.equals(".xls")){
				  myPath=mFilePath+"//iWebOfficeSign//Doc1.xls";
				}
				FileInputStream fis = null;
				fis = new FileInputStream(myPath);
				int   index=fis.available();  
				mFileBody=new   byte[index];   
				fis.read(mFileBody);  
				fis.close();
				mResult=true;
			   } catch (Exception ex) { }
		   return (mResult);
	     	
	     }
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          if (result.next()) {
            try {


				if ("oracle".equals(databaseType)) {

				     mFileSize=result.getInt("FileSize");
	                 GetAtBlob(((OracleResultSet)result).getBLOB("FileBody"),mFileSize);//??????????colin ：此处？mFileSize 应该就是
                     mResult = true ;
			
			   }else if("mysql".equals(databaseType)){

					 mFileBody = result.getBytes("FileBody");
					  if (result.wasNull()) {
						mFileBody = null;
					  }
					  mResult = true ;

			   }else{	
						   
					 mFileBody = result.getBytes("FileBody");
				     if (result.wasNull()) {
				  	 mFileBody = null;
				     }
				     mResult = true ;

			   }

             
            }
            catch (Exception ex) {
              System.out.println(ex.toString());
            }
          }else{
		  
		      try {
				String myPath=mFilePath+"//iWebOfficeSign//Doc1.doc";
				if(mFileType.equals(".xls")){
				  myPath=mFilePath+"//iWebOfficeSign//Doc1.xls";
				}
				FileInputStream fis = null;
				fis = new FileInputStream(myPath);
				int   index=fis.available();  
				mFileBody=new   byte[index];   
				fis.read(mFileBody);  
				fis.close();
				mResult=true;
			   } catch (Exception ex) { }
		       return (mResult);
		      }
          result.close();
        }
        catch (SQLException e) {
          System.out.println(e.getMessage());
          mResult = false;
        }
      }
    }
    finally {
      DbaObj.CloseConnection();
    }
    return (mResult);
  }


 //保存模板文档，如果模板文档存在，则覆盖，不存在，则添加
  private boolean SaveTemplate()
  {
    boolean mResult = false;
    int iFileId = -1;
    String Sql = "SELECT * FROM Template_File WHERE RecordID='" + mTemplate + "'";
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          if (result.next()) {


            if ("oracle".equals(databaseType)) {

				     Sql="update Template_File set TemplateID=?,RecordID=?,FileName=?,FileType=?,FileSize=?,FileDate=?,FileBody=EMPTY_BLOB(),FilePath=?,UserName=?,Descript=?,createEmp=?,createOrg=? WHERE RecordID='" + mTemplate + "'";
                     mTemplateId=result.getInt("TemplateId");
			
			   }else if("mysql".equals(databaseType)){

					 Sql="update Template_File set RecordID=?,FileName=?,FileType=?,FileSize=?,FileDate=?,FileBody=?,FilePath=?,UserName=?,Descript=?,createEmp=?,createOrg=? WHERE RecordID='" + mTemplate + "'";

			   }else{	
						   
					 Sql="update Template_File set RecordID=?,FileName=?,FileType=?,FileSize=?,FileDate=?,FileBody=?,FilePath=?,UserName=?,Descript=?,createEmp=?,createOrg=? WHERE RecordID='" + mTemplate + "'";

			   }


           
          }
          else {


			  if ("oracle".equals(databaseType)) {

				     Sql="insert into Template_File (TemplateID,RecordID,FileName,FileType,FileSize,FileDate,FileBody,FilePath,UserName,Descript,createEmp,createOrg) values (?,?,?,?,?,?,EMPTY_BLOB(),?,?,?,?,? )";
                     mTemplateId=DbaObj.GetMaxID("Template_File","TemplateId");
			
			   }else if("mysql".equals(databaseType)){

					 Sql="insert into Template_File (RecordID,FileName,FileType,FileSize,FileDate,FileBody,FilePath,UserName,Descript,createEmp,createOrg) values (?,?,?,?,?,?,?,?,?,?,? )";

			   }else{	
						   
					Sql="insert into Template_File (RecordID,FileName,FileType,FileSize,FileDate,FileBody,FilePath,UserName,Descript,createEmp,createOrg) values (?,?,?,?,?,?,?,?,?,?,? )";

			   }

            
          }
          result.close();
        }
        catch (SQLException e) {
          System.out.println(e.toString());
          mResult = false;
        }
        java.sql.PreparedStatement prestmt=null;
        try {


            if ("oracle".equals(databaseType)) {

				      prestmt =DbaObj.Conn.prepareStatement(Sql);
					  prestmt.setInt(1,mTemplateId);
					  prestmt.setString(2, mTemplate);
					  prestmt.setString(3, mFileName);
					  prestmt.setString(4, mFileType);
					  prestmt.setInt(5, mFileSize);
					  prestmt.setDate(6 ,DbaObj.GetDate());
					  prestmt.setString(7, mFilePath);
					  prestmt.setString(8, mUserName);
					  prestmt.setString(9, mDescript);                                          //"通用版本"
					  prestmt.setInt(10, c_userId);    
				  	  prestmt.setInt(11, c_orgId);    
					  DbaObj.Conn.setAutoCommit(true) ;
					  prestmt.execute();
					  DbaObj.Conn.commit();
					  prestmt.close();
					  Statement stmt=null;
					  DbaObj.Conn.setAutoCommit(false) ;
					  stmt = DbaObj.Conn.createStatement();
					  OracleResultSet update=(OracleResultSet)stmt.executeQuery("select FileBody from Template_File where TEMPLATEID=" + String.valueOf(mTemplateId)+ " for update");
					  if (update.next()){
						try
						{
					  mFileSize=mFileBody.length;
						  PutAtBlob(((oracle.jdbc.OracleResultSet)update).getBLOB("FileBody"),mFileSize);
						}
						catch (IOException e) {
						   System.out.println(e.toString());
						   mResult = false;
						}
					  }
					  update.close();
					  stmt.close();

					  DbaObj.Conn.commit();
					  mFileBody=null;
					  mResult=true;
						
			   }else if("mysql".equals(databaseType)){

					  prestmt =DbaObj.Conn.prepareStatement(Sql);
					  prestmt.setString(1, mTemplate);
					  prestmt.setString(2, mFileName);
					  prestmt.setString(3, mFileType);
					  prestmt.setInt(4, mFileSize);
					  prestmt.setString (5 ,mFileDate);
					  prestmt.setBytes(6, mFileBody);
					  prestmt.setString(7, mFilePath);
					  prestmt.setString(8, mUserName);
					  prestmt.setString(9, mDescript);                                          //"通用版本"
					  prestmt.setInt(10, c_userId);    
				  	  prestmt.setInt(11, c_orgId);  
					  //DbaObj.Conn.setAutoCommit(true) ;
					  prestmt.execute();
					  //DbaObj.Conn.commit();
					  prestmt.close();
					  mResult=true;

			   }else{	
						   
					  prestmt =DbaObj.Conn.prepareStatement(Sql);
					  prestmt.setString(1, mTemplate);
					  prestmt.setString(2, mFileName);
					  prestmt.setString(3, mFileType);
					  prestmt.setInt(4, mFileSize);
					  prestmt.setString (5 ,mFileDate);
					  prestmt.setBytes(6, mFileBody);
					  prestmt.setString(7, mFilePath);
					  prestmt.setString(8, mUserName);
					  prestmt.setString(9, mDescript);                                          //"通用版本"
					  prestmt.setInt(10, c_userId);    
				  	  prestmt.setInt(11, c_orgId);  
					  DbaObj.Conn.setAutoCommit(true) ;
					  prestmt.execute();
					  DbaObj.Conn.commit();
					  prestmt.close();
					  mResult=true;
			   }


         
        }
        catch (SQLException e) {
          System.out.println(e.toString());
          mResult = false;
        }
      }
    }
    finally {
      DbaObj.CloseConnection();
    }
    return (mResult);
  }
// ************* 文档、模板管理代码    结束  *******************************



//************* 版本管理代码    开始  *******************************
//列出所有版本信息
private boolean ListVersion()
{
   boolean mResult=false;
   String mDesc="";
   String Sql= "SELECT FileID,FileDate,UserName,Descript FROM Version_File WHERE RecordID='" + mRecordID + "'";

   mFileID="\r\n";
   mDateTime="保存时间\r\n";
   mUserName="用户名\r\n";
   mDescript="版本说明\r\n";
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          while (result.next()) {
            try {

                if ("oracle".equals(databaseType)) {//??????????????colin:   mysql , sqlserver 的 没写

				       mFileID+=String.valueOf(result.getInt("FileID"))+"\r\n";                  //文件号列表
					   mDateTime+=result.getString("FileDate")+"\r\n";                           //日期列表
					   mUserName+=result.getString("UserName")+"\r\n";                           //用户名列表
					   mDesc=result.getString("Descript");                              //如果说明信息里有回车，则将回车变成>符号
					   mDesc=mDesc.replace('\r','>');
					   mDesc=mDesc.replace('\n','>');
					   mDescript+=mDesc +"\r\n";
			
			   }else if("mysql".equals(databaseType)){

					   mFileID+=String.valueOf(result.getInt("FileID"))+"\r\n";                  //文件号列表
					   mDateTime+=result.getString("FileDate")+"\r\n";                           //日期列表
					   mUserName+=result.getString("UserName")+"\r\n";                           //用户名列表
					   mDescript+=result.getString("Descript")+"\r\n";                   //如果说明信息里有回车，则将回车变成>符号

			   }else{	
						   
					   mFileID+=String.valueOf(result.getInt("FileID"))+"\r\n";                  //文件号列表
					   mDateTime+=result.getString("FileDate")+"\r\n";                           //日期列表
					   mUserName+=result.getString("UserName")+"\r\n";                           //用户名列表
					   mDescript+=result.getString("Descript")+"\r\n";                   //如果说明信息里有回车，则将回车变成>符号
			   }


            
            }
            catch (Exception ex) {
              System.out.println(ex.toString());
            }
          }
          result.close();
          mResult=true;
        }
        catch (SQLException e) {
          System.out.println(e.getMessage());
          mResult = false;
        }
      }
    }
    finally {
      DbaObj.CloseConnection();
    }
   return (mResult);
}

//调入选中版本，通过文件号调用mFileID,并把文件放入mFileBody里，以便进行打包
private boolean LoadVersion(String mFileID)
{
    boolean mResult = false;
    String Sql= "SELECT FileBody,FileSize FROM Version_File WHERE RecordID='" + mRecordID + "' and  FileID=" + mFileID;
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          if (result.next()) {
            try {        

			   if ("oracle".equals(databaseType)) {

				        mFileSize=result.getInt("FileSize");
	                    GetAtBlob(((OracleResultSet)result).getBLOB("FileBody"),mFileSize);
                        mResult = true ;
			
			   }else if("mysql".equals(databaseType)){

					  mFileBody = result.getBytes("FileBody");
					  if (result.wasNull()) {
						mFileBody = null;
					  }
					  mResult = true ;

			   }else{	
						   
					 mFileBody = result.getBytes("FileBody");
					  if (result.wasNull()) {
						mFileBody = null;
					  }
					  mResult = true ;

			   }

            }
            catch (Exception ex) {
              System.out.println(ex.toString());
            }
          }
          result.close();
        }
        catch (SQLException e) {
          System.out.println(e.getMessage());
          mResult = false;
        }
      }
    }
    finally {
      DbaObj.CloseConnection();
    }
    return (mResult);
}

//保存版本，将该版本文件存盘，并将说明信息也保存起来
private boolean SaveVersion()
{
    boolean mResult = false;
    int iFileId = -1;
    String Sql = "insert into Version_File (RecordID,FileName,FileType,FileSize,FileDate,FileBody,FilePath,UserName,Descript) values (?,?,?,?,?,?,?,?,? )";
    
	      
     if ("oracle".equals(databaseType)) {
	  Sql="insert into Version_File (FileID,RecordID,FileName,FileType,FileSize,FileDate,FileBody,FilePath,UserName,Descript) values (?,?,?,?,?,?,EMPTY_BLOB(),?,?,? )";
    if (mFileID.equalsIgnoreCase("")){
       iFileId=DbaObj.GetMaxID("Version_File","FileId");
    }
    else
    {
       iFileId = Integer.getInteger(mFileID.toString()).intValue();
    }
	
	}
	
	try {
      if (DbaObj.OpenConnection()) {
        java.sql.PreparedStatement prestmt=null;
        try {

           
		    if ("oracle".equals(databaseType)) {

				      prestmt =DbaObj.Conn.prepareStatement(Sql);
					  prestmt.setInt(1,iFileId);
					  prestmt.setString(2, mRecordID);
					  prestmt.setString(3, mFileName);
					  prestmt.setString(4, mFileType);
					  prestmt.setInt(5, mFileSize);
					  prestmt.setDate(6 ,DbaObj.GetDate());
					  prestmt.setString(7, mFilePath);
					  prestmt.setString(8, mUserName);
					  prestmt.setString(9, mDescript);                                          //"通用版本"
					  DbaObj.Conn.setAutoCommit(true) ;
					  prestmt.execute();
					  DbaObj.Conn.commit();
					  prestmt.close();
					  Statement stmt=null;
					  DbaObj.Conn.setAutoCommit(false) ;
					  stmt = DbaObj.Conn.createStatement();
					  OracleResultSet update=(OracleResultSet)stmt.executeQuery("select FileBody from Version_File where Fileid=" + String.valueOf(iFileId)+ " for update");
					  if (update.next()){
						try
						{
						  PutAtBlob(((oracle.jdbc.OracleResultSet)update).getBLOB("FileBody"),mFileSize);
						}
						catch (IOException e) {
						   System.out.println(e.toString());
						   mResult = false;
						}
					  }
					  update.close();
					  stmt.close();

					  DbaObj.Conn.commit();
					  mFileBody=null;
					  mResult=true;
			
			   }else if("mysql".equals(databaseType)){

					  prestmt =DbaObj.Conn.prepareStatement(Sql);
					  prestmt.setString(1, mRecordID);
					  prestmt.setString(2, mFileName);
					  prestmt.setString(3, mFileType);
					  prestmt.setInt(4, mFileSize);
					  prestmt.setString (5 ,mFileDate);
					  prestmt.setBytes(6, mFileBody);
					  prestmt.setString(7, mFilePath);
					  prestmt.setString(8, mUserName);
					  prestmt.setString(9, mDescript);                                          //"通用版本"
					  //DbaObj.Conn.setAutoCommit(true) ;
					  prestmt.execute();
					  //DbaObj.Conn.commit();
					  prestmt.close();
					  mResult=true;

			   }else{	
						   
					  prestmt =DbaObj.Conn.prepareStatement(Sql);
					  prestmt.setString(1, mRecordID);
					  prestmt.setString(2, mFileName);
					  prestmt.setString(3, mFileType);
					  prestmt.setInt(4, mFileSize);
					  prestmt.setString (5 ,mFileDate);
					  prestmt.setBytes(6, mFileBody);
					  prestmt.setString(7, mFilePath);
					  prestmt.setString(8, mUserName);
					  prestmt.setString(9, mDescript);                                          //"通用版本"
					  DbaObj.Conn.setAutoCommit(true) ;
					  prestmt.execute();
					  DbaObj.Conn.commit();
					  prestmt.close();
					  mResult=true;

			   }

         

         
        }
        catch (SQLException e) {
          System.out.println(e.toString());
          mResult = false;
        }
      }
    }
    finally {
      DbaObj.CloseConnection();
    }
    return (mResult);
}
// ************* 版本管理代码    结束  *******************************


//************ 标签管理代码   开始  *******************************
//取得书签列表
private boolean ListBookmarks()
{
    boolean mResult=false;
    String Sql= "SELECT * FROM Bookmarks ";
    mBookmark="";
    mDescript="";
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          while (result.next()) {
            try {
               mBookmark+=result.getString("BookMarkName")+"\r\n";   //用户名列表
               mDescript+=result.getString("BookMarkDesc")+"\r\n";   //如果说明信息里有回车，则将回车变成>符号
            }
            catch (Exception ex) {
              System.out.println(ex.toString());
            }
          }
          result.close();
          mResult=true;
        }
        catch (SQLException e) {
          System.out.println(e.getMessage());
          mResult = false;
        }
      }
    }
    finally {
      DbaObj.CloseConnection();
    }
   return (mResult);
}

//装入书签
private boolean LoadBookMarks()
{
   boolean mResult=false;
   String Sql=" select b.BookMarkName,b.BookMarkText from Template_BookMarks a,BookMarks b where a.BookMarkname=b.BookMarkName and a.RecordID='"+ mTemplate +"'";
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          while (result.next()) {
            try {
                //说明：我们测试程序把SQL语句直接写到替换标签内容
                //实际使用中，这个标签内容是通过Sql语句得到的。
                //生成SQL查询语句  result.getString("BookMarkText") & "条件"
                //当前纪录号位 mRecordID
               //BookMarkValue=生成SQL运行结果
               String mBookMarkName=result.getString("BookMarkName");
               String mBookMarkValue=result.getString("BookMarkText");
               MsgObj.SetMsgByName(mBookMarkName,mBookMarkValue);
            }
            catch (Exception ex) {
              System.out.println(ex.toString());
            }
          }
          result.close();
          mResult=true;
        }
        catch (SQLException e) {
          System.out.println(e.getMessage());
          mResult = false;
        }
      }
    }
    finally {
      DbaObj.CloseConnection();
    }
   return (mResult);
}

//保存书签
private boolean SaveBookMarks()
{
  boolean mResult=false;
  String mBookMarkName;
  int mBookMarkId;
  int mIndex;
    try {
      if (DbaObj.OpenConnection()) {
        try {
          java.sql.PreparedStatement prestmt=null;
          String Sql = "DELETE FROM Template_BookMarks Where RecordID='"+ mTemplate+"'";
          prestmt =DbaObj.Conn.prepareStatement(Sql);
          if("mysql".equals(databaseType)){
				//DbaObj.Conn.setAutoCommit(true) ;
				prestmt.execute();
				//  DbaObj.Conn.commit();
				// prestmt.close();
		   }else{
				  DbaObj.Conn.setAutoCommit(true) ;
				  prestmt.execute();
				  DbaObj.Conn.commit();
				 // prestmt.close();	   
		   }

          for (mIndex=7;mIndex<=MsgObj.GetFieldCount()-1;mIndex++)
          {
            java.sql.PreparedStatement prestmtx=null;
            mBookMarkName=MsgObj.GetFieldName(mIndex);
            Sql="insert into Template_BookMarks (RecordId,BookMarkName) values ('"+ mTemplate +"','"+ mBookMarkName +"')";


			if ("oracle".equals(databaseType)) {
             mBookMarkId=DbaObj.GetMaxID("Template_BookMarks","BookMarkId");
             Sql="insert into Template_BookMarks (BookMarkId,RecordId,BookMarkName) values ('" + String.valueOf(mBookMarkId)+ "','"+ mTemplate +"','"+ mBookMarkName +"')";		
			}else{
				
				
				
			}

    

            prestmtx =DbaObj.Conn.prepareStatement(Sql);
           // DbaObj.Conn.setAutoCommit(true) ;
            prestmtx.execute();
           // DbaObj.Conn.commit();
            prestmtx.close();
          }
          mResult=true;
        }
        catch (SQLException e) {
          System.out.println(e.toString());
          mResult = false;
        }
      }
    }
    finally {
      DbaObj.CloseConnection();
    }
  return(mResult);
}
//************ 标签管理代码   结束  *******************************


//************ 签章管理代码    开始  *******************************
//取得签名列表
private boolean LoadMarkList()
{
   String Sql= "SELECT MarkName FROM Signature";
   mMarkList="";
   boolean mResult=false;
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          while (result.next()) {
            try {
                mMarkList+=result.getString("MarkName")+"\r\n";
            }
            catch (Exception ex) {
              System.out.println(ex.toString());
            }
          }
          result.close();
          mResult=true;
        }
        catch (SQLException e) {
          System.out.println(e.getMessage());
          mResult = false;
        }
      }
    }
    finally {
      DbaObj.CloseConnection();
    }
   return (mResult);
}



//取得签名列表
private boolean LoadMarkList(String domainId,String userId,String orgId)
{
	StringBuffer where=new StringBuffer(" where domain_id=");   //构造取签章的条件
	where.append(domainId);
	//where.append(" and (useOrgId like '%*").append(orgId).append("*%'");
	where.append(" and  (useUserId like '%$").append(userId).append("$%'");

	//查询部门
	java.util.StringTokenizer stOrg = new java.util.StringTokenizer(orgId, "$");
	while(stOrg.hasMoreElements()){
		where.append(" or useOrgId like '%*").append(stOrg.nextElement().toString()).append("*%'");
	}

	//查询组
	try{
		if (DbaObj.OpenConnection()) {
			ResultSet result = DbaObj.ExecuteQuery("select group_id from org_user_group where emp_id="+userId);
			while(result.next()){
				where.append(" or useGroupId like '%@").append(result.getString(1)).append("@%'");
			}
			result.close();
			DbaObj.CloseConnection();
		}

	}catch(Exception ex){
		System.out.println(ex.getMessage());
	}
    where.append(" or (useOrgId='' and useUserId='' and useGroupId='') or (useOrgId is null and useUserId is null and useGroupId is null) "); 
	where.append(")");



   String Sql= "SELECT MarkName FROM Signature "+where.toString();
   //System.out.println("###################:"+Sql);

   mMarkList="";
   boolean mResult=false;
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          while (result.next()) {
            try {
                mMarkList+=result.getString("MarkName")+"\r\n";
            }
            catch (Exception ex) {
              System.out.println(ex.toString());
            }
          }
          result.close();
          mResult=true;
        }
        catch (SQLException e) {
          System.out.println(e.getMessage());
          mResult = false;
        }
      }
    }
    finally {
      DbaObj.CloseConnection();
    }
   return (mResult);
}



//取得签名列表
private boolean LoadMarkList2(String domainId,String userId,String orgIdString)
{
	StringBuffer where=new StringBuffer(" where domain_id=");   //构造取签章的条件
	where.append(domainId);
	//where.append(" and (useOrgId like '%*").append(orgId).append("*%'");
	where.append(" and  (useUserId like '%$").append(userId).append("$%'");

	//查询部门
	/*java.util.StringTokenizer stOrg = new java.util.StringTokenizer(orgId, "$");
	while(stOrg.hasMoreElements()){
		where.append(" or useOrgId like '%*").append(stOrg.nextElement().toString()).append("*%'");
	}*/


	  if (orgIdString != null && orgIdString.length() > 3) {
                String cStr = orgIdString.substring(1, orgIdString.length() - 1);
                cStr = cStr.replaceAll("\\$", ",");
                 cStr = cStr.replaceAll(",,", ",");
                String[] gg1 = cStr.split(",");
                if (gg1 != null && gg1.length > 0) {
                    for (int i = 0; i < gg1.length; i++) {
          
                       where.append(" or useOrgId like '%*").append(gg1[i]).append("*%' ");
                    }
                }
            }


	//查询组
	try{
		if (DbaObj.OpenConnection()) {
			ResultSet result = DbaObj.ExecuteQuery("select group_id from org_user_group where emp_id="+userId);
			while(result.next()){
				where.append(" or useGroupId like '%@").append(result.getString(1)).append("@%'");
			}
			result.close();
			DbaObj.CloseConnection();
		}

	}catch(Exception ex){
		System.out.println(ex.getMessage());
	}
    where.append(" or (useOrgId='' and useUserId='' and useGroupId='') or (useOrgId is null and useUserId is null and useGroupId is null) "); 
	where.append(")");



   String Sql= "SELECT MarkName FROM Signature "+where.toString();
   //System.out.println("###################:"+Sql);

   mMarkList="";
   boolean mResult=false;
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          while (result.next()) {
            try {
                mMarkList+=result.getString("MarkName")+"\r\n";
            }
            catch (Exception ex) {
              System.out.println(ex.toString());
            }
          }
          result.close();
          mResult=true;
        }
        catch (SQLException e) {
          System.out.println(e.getMessage());
          mResult = false;
        }
      }
    }
    finally {
      DbaObj.CloseConnection();
    }
   return (mResult);
}





//调入签名纪录
private boolean LoadMarkImage(String vMarkName,String vPassWord)
{
  String  Sql= "SELECT MarkBody,MarkType FROM Signature WHERE MarkName='" + vMarkName + "' and PassWord='" + vPassWord + "'";
  boolean mResult=false;
    try {
      if (DbaObj.OpenConnection()) {
        try {
          ResultSet result = DbaObj.ExecuteQuery(Sql);
          if (result.next()) {
            try {
              mFileBody=result.getBytes("MarkBody");
              mFileType=result.getString("MarkType");
              mResult=true;
            }
            catch (Exception ex) {
              System.out.println(ex.toString());
            }
          }
          result.close();
        }
        catch (SQLException e) {
          System.out.println(e.getMessage());
          mResult = false;
        }
      }
    }
    finally {
      DbaObj.CloseConnection();
    }
    return (mResult);
}

 //保存签名
 private boolean SaveSignature()
 {
  boolean mResult=false;

          String Sql="";
          int iSignatureID=1;

          if ("oracle".equals(databaseType)) {//??????????????colin :  []问题 

			 Sql="insert into Document_Signature (SignatureID,RecordID,MarkName,UserName,DateTime,HostName,MarkGuid) values (?,?,?,?,to_date('"+mDateTime+"','yyyy-mm-dd hh24:mi:ss'),?,? ) ";
			 iSignatureID=DbaObj.GetMaxID("Document_Signature","SignatureID");
		
		   }else if("mysql".equals(databaseType)){

			  Sql="insert into Document_Signature ([RecordID],[MarkName],[UserName],[DateTime],[HostName],[MarkGuid]) values (?,?,?,?,?,? ) ";

		   }else{	
			  Sql="insert into Document_Signature ([RecordID],[MarkName],[UserName],[DateTime],[HostName],[MarkGuid]) values (?,?,?,?,?,? ) ";

		   }

   

 
  if (DbaObj.OpenConnection())
  {
    java.sql.PreparedStatement prestmt=null;
    try
    {

		 if ("oracle".equals(databaseType)) {//

			  prestmt =DbaObj.Conn.prepareStatement(Sql);
			  prestmt.setInt(1, iSignatureID);
			  prestmt.setString(2, mRecordID);
			  prestmt.setString(3, mMarkName);
			  prestmt.setString(4, mUserName);
			  prestmt.setString(5, mHostName);
			  prestmt.setString(6, mMarkGuid);
			  DbaObj.Conn.setAutoCommit(true);
			  prestmt.execute();
			  DbaObj.Conn.commit();
			  prestmt.close();
			  mResult=true;
		
		   }else if("mysql".equals(databaseType)){

			  prestmt =DbaObj.Conn.prepareStatement(Sql);
			  prestmt.setString(1, mRecordID);
			  prestmt.setString(2, mMarkName);
			  prestmt.setString(3, mUserName);
			  prestmt.setString(4, mDateTime);
			  prestmt.setString(5, mHostName);
			  prestmt.setString(6, mMarkGuid);
			  //DbaObj.Conn.setAutoCommit(true);
			  prestmt.execute();
			  //DbaObj.Conn.commit();
			  prestmt.close();
			  mResult=true;

		   }else{	
			  prestmt =DbaObj.Conn.prepareStatement(Sql);
			  prestmt.setString(1, mRecordID);
			  prestmt.setString(2, mMarkName);
			  prestmt.setString(3, mUserName);
			  prestmt.setString(4, mDateTime);
			  prestmt.setString(5, mHostName);
			  prestmt.setString(6, mMarkGuid);
			  DbaObj.Conn.setAutoCommit(true);
			  prestmt.execute();
			  DbaObj.Conn.commit();
			  prestmt.close();
			  mResult=true;
		   }
     
    }
    catch(SQLException e)
    {
      System.out.println(e.toString()+Sql);
      mResult=false;
    }
    DbaObj.CloseConnection();
  }
  return (mResult);
 }


 //列出所有签名
 private boolean LoadSignature()
 {
   boolean mResult=false;
   SimpleDateFormat formatter = new SimpleDateFormat("yyyy-MM-dd HH:mm:ss");

   String Sql= "SELECT [MarkName],[UserName],[DateTime],[HostName],[MarkGuid] FROM Document_Signature WHERE RecordID='" + mRecordID + "'";

   mMarkName="印章名称\r\n";
   mUserName="签名人\r\n";
   mDateTime="签章时间\r\n";
   mHostName="客户端IP\r\n";
   mMarkGuid="序列号\r\n";

   if (DbaObj.OpenConnection())
   {
     try
     {
         mResult=true;
         ResultSet result=DbaObj.ExecuteQuery(Sql);
         while (result.next())
         {
           mMarkName+=result.getString("MarkName")+"\r\n";                  	     //文件号列表
           mUserName+=result.getString("UserName")+"\r\n";                           //日期列表
           mDateTime+=formatter.format(result.getTimestamp("DateTime"))+"\r\n";
           mHostName+=result.getString("HostName")+"\r\n";
           mMarkGuid+=result.getString("MarkGuid")+"\r\n";
         }
         result.close();
     }
     catch(Exception e)
     {
       System.out.println(e.toString());
       mResult=false;
     }
     DbaObj.CloseConnection();
   }
   return (mResult);
 }
// ************ 签章管理代码    结束  *******************************


//************ 扩展功能代码    开始  *******************************
 //调出所对应的文本
 private boolean LoadContent()
 {
   boolean mResult=false;
   //打开数据库
   //根据 mRecordID 或 mFileName 等信息
   //提取文本信息付给mContent即可。
   //本演示假设取得的文本信息如下：
   mContent="";
   mContent+="本文的纪录号："+mRecordID+"\n";
   mContent+="本文的文件名："+mFileName+"\n";
   mContent+="    这个部分请自己加入，和你们的数据库结合起来就可以了\n";
   mResult=true;
   return (mResult);
 }

 //保存所对应的文本
 private boolean SaveContent()
 {
   boolean mResult=false;
   //打开数据库
   //根据 mRecordID 或 mFileName 等信息
   //插入文本信息 mContent里的文本到数据库中即可。
   mResult=true;
   return (mResult);
 }

 //增加行并填充表格内容
 private boolean GetWordTable()
 {
   int i,n;
   String strI,strN;
   boolean mResult;
   mColumns=3; mCells=8;
   MsgObj.MsgTextClear();
   MsgObj.SetMsgByName("COLUMNS",String.valueOf(mColumns));  		     //设置表格行
   MsgObj.SetMsgByName("CELLS",String.valueOf(mCells));      		     //设置表格列
   //该部分内容可以从数据库中读取
   try{
     for (i=1;i<=mColumns;i++)
     {
       strI = String.valueOf(i);
       for (n=1;n<=mCells;n++)
       {
         MsgObj.SetMsgByName( String.valueOf(i)+String.valueOf(n),"内容" + DbaObj.GetDateTime());
       }
     }
     mResult=true;
   }
   catch(Exception e)
   {
     System.out.println(e.toString());
     mResult=false;
   }
   return (mResult);
 }

 //更新打印份数
 private boolean UpdataCopies(int mLeftCopies)
 {
   boolean mResult=true;
   //该函数可以把打印减少的次数记录到数据库

   //根据自己的系统进行扩展该功能
   return mResult;
 }

//************ 扩展功能代码    结束  *******************************



public void ExecuteRun(HttpServletRequest request,HttpServletResponse response){
  DbaObj=new DBstep.iDBManager2000();      //创建数据库对象
  MsgObj=new DBstep.iMsgServer2000();      //创建信息包对象

  mOption="";
  mRecordID="";
  mTemplate="";
  mFileBody=null;
  mFileName="";
  mFileType="";
  mFileSize=0;
  mFileID="";
  mDateTime="";
  mMarkName="";
  mPassword="";
  mMarkList="";
  mBookmark="";
  mMarkGuid="";
  mDescript="";
  mCommand="";
  mContent="";
  mLabelName="";
  mImageName="";
  mTableContent="";
  mMyDefine1="";

  mFilePath = request.getSession().getServletContext().getRealPath("") ;  //取得服务器路径

 // System.out.println("ReadPackage") ;

  try{
    if (request.getMethod().equalsIgnoreCase("POST")){
      MsgObj.MsgVariant(ReadPackage(request));
      if (MsgObj.GetMsgByName("DBSTEP").equalsIgnoreCase("DBSTEP")){	//如果是合法的信息包
        mOption=MsgObj.GetMsgByName("OPTION") ;							//取得操作信息
        mUserName=MsgObj.GetMsgByName("USERNAME") ;						//取得系统用户
       // System.out.println(mOption);									//打印出调试信息

        if(mOption.equalsIgnoreCase("LOADFILE")){						//下面的代码为打开服务器数据库里的文件
		  mRecordID=MsgObj.GetMsgByName("RECORDID");					//取得文档编号
		  mFileName=MsgObj.GetMsgByName("FILENAME");					//取得文档名称
		  mFileType=MsgObj.GetMsgByName("FILETYPE");					//取得文档类型
		  MsgObj.MsgTextClear();										//清除文本信息
		  //System.out.println(mFilePath+"//"+mFileName);
		  //if (MsgObj.MsgFileLoad(mFilePath+"//"+mFileName))			//从文件夹调入文档
		  if (LoadFile())												//从数据库调入文档
		  {
            MsgObj.MsgFileBody(mFileBody);								//将文件信息打包
            MsgObj.SetMsgByName("STATUS","打开成功!");					//设置状态信息
            MsgObj.MsgError("");										//清除错误信息
          }
          else{
            MsgObj.MsgError("打开失败!");								//设置错误信息
          }
        }

        else if(mOption.equalsIgnoreCase("SAVEFILE")){					//下面的代码为保存文件在服务器的数据库里

          mRecordID=MsgObj.GetMsgByName("RECORDID");		    //取得文档编号
          mFileName=MsgObj.GetMsgByName("FILENAME");		    //取得文档名称
          mFileType=MsgObj.GetMsgByName("FILETYPE");		    //取得文档类型
          mFileSize=MsgObj.MsgFileSize();			    //取得文档大小
          mFileDate=DbaObj.GetDateTime();                           //取得文档时间
          mFileBody=MsgObj.MsgFileBody();			    //取得文档内容
          //mFilePath="";                                             //如果保存为文件，则填写文件路径
          mUserName=mUserName;                                      //取得保存用户名称
          //mMyDefine1=MsgObj.GetMsgByName("MyDefine1");            //取得客户端传递变量值 MyDefine1="自定义变量值1"
		  String isDoc=MsgObj.GetMsgByName("isDoc");//是否保存为doc文档
		  String moduleType=MsgObj.GetMsgByName("moduleType");//模块类型
		  String docName=MsgObj.GetMsgByName("docName");//文件保存名
          mDescript="通用版本";                                 	    //版本说明
	  	  MsgObj.MsgTextClear();				    //清除文本信息
		  //--zhuo
		  if(isDoc.equals("false")){
			  if (SaveFile()) 					    //保存文档内容
			  {
				MsgObj.SetMsgByName("STATUS", "保存成功!");	            //设置状态信息
				MsgObj.MsgError("");				    //清除错误信息
			  }
			  else
			  {
				MsgObj.MsgError("保存失败!");			            //设置错误信息
			  }
		  }
		  else if(isDoc.equals("true")){
			 String myPath=mFilePath+"//iWebOfficeSign//Document";
			 if(moduleType.equals("information")){
				myPath=mFilePath+"//upload//information";
			 }else if(moduleType.equals("govdocument")){
				myPath=mFilePath+"//upload//govdocumentmanager";

              }else if(moduleType.indexOf("dossier")>-1){//紫金 矿业  归档 时 用！
              myPath=mFilePath+"//upload//dossier"+"//sendType"+moduleType.substring(moduleType.indexOf("dossier")+7); 
			 try {       
                    java.io.File myFilePath = new java.io.File(myPath);
                    if (!myFilePath.exists()) {
                        myFilePath.mkdir();
                    }
                } catch (Exception e) {
                    System.out.println("新建目录操作出错");
                    e.printStackTrace();
                }
			 }

			// System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
			 //System.out.println(mFileType);
		   	 //System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx"); 
			 if(moduleType.indexOf("dossier")>-1){//紫金 矿业  归档 时 用！
			  MsgObj.MsgFileSave(myPath + "//" + docName +"(带痕)"+ mFileType);
			 }else{
			 MsgObj.MsgFileSave(myPath + "//" + mRecordID + mFileType);
			 
			 }
                /*------用ftp把保存的doc文件上传到文件服务器------------*/
		    java.util.Map sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap(request.getSession(true).getAttribute("domainId").toString());
		   if(sysMap != null && sysMap.get("附件上传") != null && sysMap.get("附件上传").toString().equals("0")&&(moduleType.indexOf("dossier")<0)){//紫金 矿业  归档 时  不上传
		        java.util.Map ftpMap = (java.util.Map) request.getSession().getAttribute("ftpMap");
//System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
//		        System.out.println(ftpMap.get("server").toString());
//				System.out.println(ftpMap.get("user").toString());
//				System.out.println(ftpMap.get("oriPass") + "whir?!");
//				System.out.println(myPath + "//" + mRecordID + ".doc");
//				System.out.println(moduleType.equals("information")?"information":"govdocumentmanager");
//System.out.println("xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx");
				com.whir.common.util.FtpClientTest ftpClient = new com.whir.common.util.FtpClientTest(ftpMap.get("server").toString(), ftpMap.get("user").toString(), ftpMap.get("oriPass") + "whir?!",myPath + "//" + mRecordID + mFileType,mRecordID + mFileType,moduleType.equals("information")?"information":"govdocumentmanager");
		        ftpClient.upload();
		    }
/*------------------------------------------------------*/
          	//----------------------------------------
          	/*try{
          		byte[] buff = new byte[256];
          		java.io.File myFile = new java.io.File("config/ky.prop");
          		java.io.FileInputStream fis = new java.io.FileInputStream(myFile);
            	fis.read(buff);
            	String str = new String(buff);
            	str = str.trim();
            	String[] tmp = str.split(((char) 10) + "");
            	String myPath = tmp[4].trim();
            	MsgObj.MsgFileSave(myPath + "//" + mRecordID + ".doc");
          	}catch(Exception e){}*/
          	//----------------------------------------
		  }

          MsgObj.MsgFileClear();                                    //清除文档内容
        }

		//-----服务器处理页保存PDF文档--------------------------------------------------------//
		else if(mOption.equalsIgnoreCase("SAVEPDF")){ //下面的代码为保存PDF文件

			mRecordID=MsgObj.GetMsgByName("RECORDID"); //取得文档编号
			mFileName=MsgObj.GetMsgByName("FILENAME"); //取得文档名称
			MsgObj.MsgTextClear(); //清除文本信息



			 String myPath=mFilePath+"//upload//govdocumentmanager"+ "//" + mRecordID + ".pdf";

			//保存文档内容到文件夹中
			if (MsgObj.MsgFileSave(myPath)){
				MsgObj.SetMsgByName("STATUS", "保存成功!"); //设置状态信息

                /*------用ftp把保存的doc文件上传到文件服务器------------*/
				java.util.Map sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap(request.getSession(true).getAttribute("domainId").toString());
				if(sysMap != null && sysMap.get("附件上传") != null && sysMap.get("附件上传").toString().equals("0")){
					java.util.Map ftpMap = (java.util.Map) request.getSession().getAttribute("ftpMap");

					com.whir.common.util.FtpClientTest ftpClient = new com.whir.common.util.FtpClientTest(ftpMap.get("server").toString(), ftpMap.get("user").toString(), ftpMap.get("oriPass") + "whir?!",myPath,mRecordID +  ".pdf","govdocumentmanager");
					ftpClient.upload();
				}

				MsgObj.MsgError(""); //清除错误信息
			}
			else {
				MsgObj.MsgError("保存失败!"); //设置错误信息
			}
			MsgObj.MsgFileClear(); //清除文档内容

		}


        else if(mOption.equalsIgnoreCase("LOADTEMPLATE")){				//下面的代码为打开服务器数据库里的模板文件
           mTemplate=MsgObj.GetMsgByName("TEMPLATE");		    //取得模板文档类型
 	   //本段处理是否调用文档时打开模版，
	   //还是套用模版时打开模版。
	   mCommand=MsgObj.GetMsgByName("COMMAND");		    //取得客户端定义的变量COMMAND值
	     mFileType=MsgObj.GetMsgByName("FILETYPE");
           if (mCommand.equalsIgnoreCase("INSERTFILE"))
           {
 	     //if (MsgObj.MsgFileLoad(mFilePath+"//Document//"+mTemplate))//调入模板文档
	    // {
		//MsgObj.SetMsgByName("STATUS","打开模板成功!");	    //设置状态信息
		//MsgObj.MsgError("");		                    //清除错误信息
	    // }
	    // else
	    // {
		//MsgObj.MsgError("打开模板失败!");		            //设置错误信息
	   //  }
          //}
          // else
          //{
            // MsgObj.MsgTextClear();                                 //清除文本信息
             if (LoadTemplate())				    //调入模板文档
             {
               MsgObj.MsgFileBody(mFileBody);			    //将文件信息打包
               MsgObj.SetMsgByName("STATUS","打开模板成功!");         //设置状态信息
               MsgObj.MsgError("");		                    //清除错误信息
             }
             else
             {
               MsgObj.MsgError("打开模板失败!");			    //设置错误信息
             }
           }else{
             MsgObj.MsgTextClear();
			 if (LoadTemplate())				    //调入模板文档
             {
               MsgObj.MsgFileBody(mFileBody);			    //将文件信息打包
               MsgObj.SetMsgByName("STATUS","打开模板成功!");         //设置状态信息
               MsgObj.MsgError("");		                    //清除错误信息
             }
             else
             {
               //MsgObj.MsgError("打开模板失败!");			    //设置错误信息
			   MsgObj.MsgError("新建模板!");			    //设置错误信息
             }
		   }
        }

        else if(mOption.equalsIgnoreCase("SAVETEMPLATE")){				//下面的代码为保存模板文件在服务器的数据库里
          mTemplate=MsgObj.GetMsgByName("TEMPLATE");					//取得文档编号
          mFileName=MsgObj.GetMsgByName("FILENAME");					//取得文档名称
          mFileType=MsgObj.GetMsgByName("FILETYPE");					//取得文档类型
          //mMyDefine1=MsgObj.GetMsgByName("MyDefine1");				//取得客户端传递变量值 MyDefine1="自定义变量值1"
          mFileSize=MsgObj.MsgFileSize();								//取得文档大小
          mFileDate=DbaObj.GetDateTime();								//取得文档时间
          mFileBody=MsgObj.MsgFileBody();								//取得文档内容
          mFilePath="";													//如果保存为文件，则填写文件路径
          mUserName=mUserName;											//取得保存用户名称
          mDescript="通用模板"; 										//版本说明

		  c_userId=Integer.parseInt(MsgObj.GetMsgByName("c_userId"));
		  c_orgId=Integer.parseInt(MsgObj.GetMsgByName("c_orgId"));

          MsgObj.MsgTextClear();
          if (SaveTemplate()){											//保存模板文档内容
            MsgObj.SetMsgByName("STATUS", "保存模板成功!");				//设置状态信息
            MsgObj.MsgError("");										//清除错误信息
          }
          else{
            MsgObj.MsgError("保存模板失败!");							//设置错误信息
          }
          MsgObj.MsgFileClear();
        }

        else if(mOption.equalsIgnoreCase("LISTVERSION")){				//下面的代码为打开版本列表
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//取得文档编号
          MsgObj.MsgTextClear();
          if (ListVersion()){											//生成版本列表
            MsgObj.SetMsgByName("FILEID",mFileID);						//将文档号列表打包
            MsgObj.SetMsgByName("DATETIME",mDateTime);		            //将日期时间列表打包
            MsgObj.SetMsgByName("USERNAME",mUserName);					//将用户名列表打包
            MsgObj.SetMsgByName("DESCRIPT",mDescript);					//将说明信息列表打包
            MsgObj.SetMsgByName("STATUS","版本列表成功!");				//设置状态信息
            MsgObj.MsgError("");										//清除错误信息
          }
          else{
            MsgObj.MsgError("版本列表失败!");							//设置错误信息
          }
        }

        else if(mOption.equalsIgnoreCase("LOADVERSION")){				//下面的代码为打开版本文档
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//取得文档编号
          mFileID=MsgObj.GetMsgByName("FILEID");					    //取得版本文档号
          MsgObj.MsgTextClear();
          if (LoadVersion(mFileID)){									//调入该版本文档
            MsgObj.MsgFileBody(mFileBody);								//将文档信息打包
            MsgObj.SetMsgByName("STATUS","打开版本成功!");				//设置状态信息
            MsgObj.MsgError("");										//清除错误信息
          }
          else{
            MsgObj.MsgError("打开版本失败!");							//设置错误信息
          }
        }

        else if(mOption.equalsIgnoreCase("SAVEVERSION")){				//下面的代码为保存版本文档
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//取得文档编号
          mFileID=MsgObj.GetMsgByName("FILEID");					    //取得版本文档号   如:WebSaveVersionByFileID，则FileID值存在
          mFileName=MsgObj.GetMsgByName("FILENAME");				    //取得文档名称
          mFileType=MsgObj.GetMsgByName("FILETYPE");					//取得文档类型
          mFileSize=MsgObj.MsgFileSize();							    //取得文档大小
          mFileDate=DbaObj.GetDateTime();								//取得文档时间
          mFileBody=MsgObj.MsgFileBody();								//取得文档内容
          mFilePath="";													//如果保存为文件，则填写文件路径
          mUserName=mUserName;											//取得保存用户名称
          mDescript=MsgObj.GetMsgByName("DESCRIPT");				    //取得说明信息
          MsgObj.MsgTextClear();
          if (SaveVersion()){ 				        				    //保存版本文档
            MsgObj.SetMsgByName("STATUS", "保存版本成功!");				//设置状态信息
            MsgObj.MsgError("");										//清除错误信息
          }
          else{
            MsgObj.MsgError("保存版本失败!");							//设置错误信息
          }
          MsgObj.MsgFileClear();										//清除文档内容
        }

        else if(mOption.equalsIgnoreCase("LOADBOOKMARKS")){				//下面的代码为取得文档标签
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//取得文档编号
          mTemplate=MsgObj.GetMsgByName("TEMPLATE");					//取得模板编号
          mFileName=MsgObj.GetMsgByName("FILENAME");					//取得文档名称
          mFileType=MsgObj.GetMsgByName("FILETYPE");					//取得文档类型
          MsgObj.MsgTextClear();
          if (LoadBookMarks()){
            MsgObj.MsgError("");										//清除错误信息
          }
          else{
            MsgObj.MsgError("装入标签信息失败!");						//设置错误信息
          }
        }

        else if (mOption.equalsIgnoreCase("SAVEBOOKMARKS")){			//下面的代码为取得标签文档内容
          mTemplate=MsgObj.GetMsgByName("TEMPLATE");					//取得模板编号
          if (SaveBookMarks()){
            MsgObj.MsgError("");										//清除错误信息
          }
          else{
            MsgObj.MsgError("保存标签信息失败!");						//设置错误信息
          }
          MsgObj.MsgTextClear();										//清除文本信息
        }

        else if(mOption.equalsIgnoreCase("LISTBOOKMARKS")){				//下面的代码为显示标签列表
          MsgObj.MsgTextClear();										//清除文本信息
          if (ListBookmarks()){
            MsgObj.SetMsgByName("BOOKMARK",mBookmark);					//将用户名列表打包
            MsgObj.SetMsgByName("DESCRIPT",mDescript);					//将说明信息列表打包
            MsgObj.MsgError("");										//清除错误信息
          }
          else{
            MsgObj.MsgError("调入标签失败!");							//设置错误信息
          }
        }

        else if(mOption.equalsIgnoreCase("LOADMARKLIST")){				//下面的代码为创建印章列表
          MsgObj.MsgTextClear();										//清除文本信息
          if(LoadMarkList2("0", request.getSession().getAttribute("userId").toString(), request.getSession().getAttribute("orgIdString").toString())){
            MsgObj.SetMsgByName("MARKLIST",mMarkList);					//显示签章列表
            MsgObj.MsgError("");										//清除错误信息
          }
          else{
            MsgObj.MsgError("创建印章列表失败!");						//设置错误信息
          }
        }

        else if(mOption.equalsIgnoreCase("LOADMARKIMAGE")){				//下面的代码为打开印章文件
          mMarkName=MsgObj.GetMsgByName("IMAGENAME");					//取得签名名称
          mUserName=MsgObj.GetMsgByName("USERNAME");					//取得用户名称
          mPassword=MsgObj.GetMsgByName("PASSWORD");					//取得用户密码
          MsgObj.MsgTextClear();										//清除文本信息
          if (LoadMarkImage(mMarkName,mPassword)){						//调入签名信息
            MsgObj.SetMsgByName("IMAGETYPE",mFileType);					//设置签名类型
            MsgObj.MsgFileBody(mFileBody);								//将签名信息打包
            MsgObj.SetMsgByName ("POSITION","Manager");					//插入位置  在文档中标签"Manager"
            MsgObj.SetMsgByName ("ZORDER","5");							//4:在文字上方 5:在文字下方
            MsgObj.SetMsgByName("STATUS","打开成功!");					//设置状态信息
            MsgObj.MsgError("");										//清除错误信息
          }
          else{
            MsgObj.MsgError("签名或密码错误!");							//设置错误信息
          }
        }

        else if(mOption.equalsIgnoreCase("SAVESIGNATURE")){				//下面的代码为保存签章基本信息
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//取得文档编号
          mFileName=MsgObj.GetMsgByName("FILENAME");					//取得文件名称
          mMarkName=MsgObj.GetMsgByName("MARKNAME");					//取得签名名称
          mUserName=MsgObj.GetMsgByName("USERNAME");					//取得用户名称
          mDateTime=MsgObj.GetMsgByName("DATETIME");				    //取得签名时间
          mHostName=request.getRemoteAddr();							//取得用户IP
          mMarkGuid=MsgObj.GetMsgByName("MARKGUID");					//取得唯一编号
          MsgObj.MsgTextClear();										//清除文本信息
          if (SaveSignature()){											//保存签章
            MsgObj.SetMsgByName("STATUS","保存印章成功!");				//设置状态信息
            MsgObj.MsgError("");										//清除错误信息
          }
          else{
            MsgObj.MsgError("保存印章失败!");							//设置错误信息
          }
        }

        else if(mOption.equalsIgnoreCase("LOADSIGNATURE")){				//下面的代码为调出签章基本信息
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//取得文档编号
          MsgObj.MsgTextClear();										//清除文本信息
          if (LoadSignature()){											//调出签章
            MsgObj.SetMsgByName("MARKNAME",mMarkName);					//将签名名称列表打包
            MsgObj.SetMsgByName("USERNAME",mUserName);					//将用户名列表打包
            MsgObj.SetMsgByName("DATETIME",mDateTime);					//将时间列表打包
            MsgObj.SetMsgByName("HOSTNAME",mHostName);					//将盖章IP地址列表打包
            MsgObj.SetMsgByName("MARKGUID",mMarkGuid);					//将唯一编号列表打包
            MsgObj.SetMsgByName("STATUS","调入印章成功!");				//设置状态信息
            MsgObj.MsgError("");										//清除错误信息
          }
          else{
            MsgObj.MsgError("调入印章失败!");							//设置错误信息
          }
        }

        else if (mOption.equalsIgnoreCase("SAVEASHTML")){				//下面的代码为将OFFICE存为HTML页面
          mHtmlName=MsgObj.GetMsgByName("HTMLNAME");					//取得文件名称
          mDirectory=MsgObj.GetMsgByName("DIRECTORY");					//取得目录名称
          MsgObj.MsgTextClear();
          if (mDirectory.trim().equalsIgnoreCase("")){
            mFilePath=mFilePath + "//HTML";
          }
          else{
            mFilePath=mFilePath + "//HTML//" + mDirectory;
          }
          MsgObj.MakeDirectory(mFilePath);								//创建路径


          if (MsgObj.MsgFileSave(mFilePath+"//"+mHtmlName)){			//保存HTML文件

               //将文件上传至FTP服务器
			   java.util.Map sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap(request.getSession().getAttribute("domainId").toString());
			   if(sysMap != null && sysMap.get("附件上传") != null && sysMap.get("附件上传").toString().equals("0")){
					java.util.Map ftpMap = (java.util.Map) request.getSession().getAttribute("ftpMap");
					com.whir.common.util.FtpClientTest ftpClient = new com.whir.common.util.FtpClientTest(ftpMap.get("server").toString(), ftpMap.get("user").toString(), ftpMap.get("oriPass") + "whir?!",mFilePath + "/" + mHtmlName,mHtmlName,"webofficehtml");
					ftpClient.upload(mDirectory);
				}

            MsgObj.MsgError("");										//清除错误信息
            MsgObj.SetMsgByName("STATUS","保存HTML成功!");				//设置状态信息
          }
          else{
            MsgObj.MsgError("保存HTML失败!");							//设置错误信息
          }
          MsgObj.MsgFileClear();
        }

        else if (mOption.equalsIgnoreCase("SAVEIMAGE"))	{				//下面的代码为将OFFICE存为HTML图片页面
           mHtmlName=MsgObj.GetMsgByName("HTMLNAME");		    //取得文件名称
           mDirectory=MsgObj.GetMsgByName("DIRECTORY");	            //取得目录名称

           String moduleType=MsgObj.GetMsgByName("EXTPARAM");		    //取得模块类型
		   String myPath="//iWebOfficeSign";//默认位置
		   if(moduleType.equals("information")){
				myPath="//upload//information";
		   }
		   else if(moduleType.equals("govdocument")){
				myPath="//upload//govdocumentmanager";
		   }

           MsgObj.MsgTextClear();
           if (mDirectory.trim().equalsIgnoreCase(""))
           {
             mFilePath=mFilePath +myPath+ "//HTMLIMAGE";
           }
           else
           {
             mFilePath=mFilePath +myPath+ "//HTMLIMAGE//" + mDirectory;
           }
           //System.out.println("****************************************");
		  // System.out.println(mFilePath);
		  // System.out.println("*****************************************");
           MsgObj.MakeDirectory(mFilePath);                         //创建路径
           if (MsgObj.MsgFileSave(mFilePath+"//"+mHtmlName))        //保存HTML文件
           {
             MsgObj.MsgError("");                                   //清除错误信息
             MsgObj.SetMsgByName("STATUS","保存HTML图片成功!");       //设置状态信息
           }
           else
           {
             MsgObj.MsgError("保存HTML图片失败!");                    //设置错误信息
           }
           MsgObj.MsgFileClear();
		}

        else if (mOption.equalsIgnoreCase("SAVEASPAGE")){				//下面的代码为将手写批注存为HTML图片页面
          mHtmlName=MsgObj.GetMsgByName("HTMLNAME");					//取得文件名称
          mDirectory=MsgObj.GetMsgByName("DIRECTORY");					//取得目录名称
          MsgObj.MsgTextClear();
          if (mDirectory.trim().equalsIgnoreCase("")){
            mFilePath=mFilePath + "//HTML";
          }
          else{
            mFilePath=mFilePath + "//HTML//" + mDirectory;
          }
          MsgObj.MakeDirectory(mFilePath);								//创建路径
          if (MsgObj.MsgFileSave(mFilePath+"//"+mHtmlName)){			//保存HTML文件
		    
			 //将文件上传至FTP服务器
			   java.util.Map sysMap = com.whir.org.common.util.SysSetupReader.getInstance().getSysSetupMap(request.getSession(true).getAttribute("domainId").toString());
			   if(sysMap != null && sysMap.get("附件上传") != null && sysMap.get("附件上传").toString().equals("0")){
					java.util.Map ftpMap = (java.util.Map) request.getSession().getAttribute("ftpMap");
					com.whir.common.util.FtpClientTest ftpClient = new com.whir.common.util.FtpClientTest(ftpMap.get("server").toString(), ftpMap.get("user").toString(), ftpMap.get("oriPass") + "whir?!",mFilePath + "/" + mHtmlName,mHtmlName,"webofficehtml");
					ftpClient.upload(mDirectory);
				}
            MsgObj.MsgError("");										//清除错误信息
            MsgObj.SetMsgByName("STATUS","保存批注HTML图片成功!");		//设置状态信息
          }
          else{
            MsgObj.MsgError("保存批注HTML图片失败!");					//设置错误信息
          }
          MsgObj.MsgFileClear();
        }

        else if(mOption.equalsIgnoreCase("INSERTFILE")){				//下面的代码为插入文件
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//取得文档编号
          mFileName=MsgObj.GetMsgByName("FILENAME");					//取得文档名称
          mFileType=MsgObj.GetMsgByName("FILETYPE");					//取得文档类型
          MsgObj.MsgTextClear();
          if (LoadFile()){												//调入文档
            MsgObj.MsgFileBody(mFileBody);								//将文件信息打包
            MsgObj.SetMsgByName("POSITION","Content");					//设置插入的位置[书签]
            MsgObj.SetMsgByName("STATUS","插入文件成功!");				//设置状态信息
            MsgObj.MsgError("");										//清除错误信息
          }
          else{
            MsgObj.MsgError("插入文件成功!");							//设置错误信息
          }
        }

        else if(mOption.equalsIgnoreCase("UPDATEFILE")){				//下面的代码为更新保存文件
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//取得文档编号
          mFileName=MsgObj.GetMsgByName("FILENAME");					//取得文档名称
          mFileType=MsgObj.GetMsgByName("FILETYPE");					//取得文档类型
          mFileSize=MsgObj.MsgFileSize();								//取得文档大小
          mFileDate=DbaObj.GetDateTime();								//取得文档时间
          mFileBody=MsgObj.MsgFileBody();								//取得文档内容
          mFilePath="";													//如果保存为文件，则填写文件路径
          mUserName=mUserName;											//取得保存用户名称
          mDescript="定稿版本";											//版本说明
          MsgObj.MsgTextClear();
          if (SaveVersion()){											//保存文档内容
            MsgObj.SetMsgByName("STATUS", "保存定稿版本成功!");			//设置状态信息
            MsgObj.MsgError("");										//清除错误信息
          }
          else{
            MsgObj.MsgError("保存定稿版本失败!");						//设置错误信息
          }
          MsgObj.MsgFileClear();
        }

        else if(mOption.equalsIgnoreCase("INSERTIMAGE")){				//下面的代码为插入服务器图片
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//取得文档编号
          mLabelName=MsgObj.GetMsgByName("LABELNAME");					//标签名
          mImageName=MsgObj.GetMsgByName("IMAGENAME");					//图片名
          mFilePath=mFilePath+"//upload//govReadHead//"+mImageName;				//图片在服务器的完整路径
          mFileType=mImageName.substring(mImageName.length()-4).toLowerCase() ;	//取得文件的类型
          MsgObj.MsgTextClear();
          if (MsgObj.MsgFileLoad(mFilePath)){							//调入图片
            MsgObj.SetMsgByName("IMAGETYPE",mFileType);					//指定图片的类型
            MsgObj.SetMsgByName("POSITION",mLabelName);					//设置插入的位置[书签对象名]
            MsgObj.SetMsgByName("STATUS","插入图片成功!");				//设置状态信息
            MsgObj.MsgError("");										//清除错误信息
          }
          else{
            MsgObj.MsgError("插入图片失败!");							//设置错误信息
          }
        }

        else if(mOption.equalsIgnoreCase("PUTFILE")){					//下面的代码为请求上传文件操作
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//取得文档编号
          mFileBody=MsgObj.MsgFileBody();								//取得文档内容
          mLocalFile=MsgObj.GetMsgByName("LOCALFILE");					//取得本地文件名称
          mRemoteFile=MsgObj.GetMsgByName("REMOTEFILE");				//取得远程文件名称
          MsgObj.MsgTextClear();										//清除文本信息
          mFilePath=mFilePath+"//Document//"+mRemoteFile;
          if (MsgObj.MsgFileSave(mFilePath)){							//调入文档
            MsgObj.SetMsgByName("STATUS","保存上传文件成功!");			//设置状态信息
            MsgObj.MsgError("");										//清除错误信息
          }
          else{
            MsgObj.MsgError("上传文件失败!");							//设置错误信息
          }
        }

        else if(mOption.equalsIgnoreCase("GETFILE")){					//下面的代码为请求下载文件操作
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//取得文档编号
          mLocalFile=MsgObj.GetMsgByName("LOCALFILE");					//取得本地文件名称
          mRemoteFile=MsgObj.GetMsgByName("REMOTEFILE");				//取得远程文件名称
          MsgObj.MsgTextClear();										//清除文本信息
          mFilePath=mFilePath+"//Document//"+mRemoteFile;
          if (MsgObj.MsgFileLoad(mFilePath)){							//调入文档内容
            MsgObj.SetMsgByName("STATUS","保存下载文件成功!");			//设置状态信息
            MsgObj.MsgError("");										//清除错误信息
          }
          else{
            MsgObj.MsgError("下载文件失败!");							//设置错误信息
          }
        }

        else if(mOption.equalsIgnoreCase("DATETIME")){					//下面的代码为请求取得服务器时间
          MsgObj.MsgTextClear();										//清除文本信息
          MsgObj.SetMsgByName("DATETIME",DbaObj.GetDateTime());		//标准日期格式字串，如 2005-8-16 10:20:35
		  //MsgObj.SetMsgByName("DATETIME","2006-01-01 10:24:24");		//标准日期格式字串，如 2005-8-16 10:20:35
        }

        else if(mOption.equalsIgnoreCase("SENDMESSAGE")){				//下面的代码为Web页面请求信息[扩展接口]
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//取得文档编号
          mFileName=MsgObj.GetMsgByName("FILENAME");					//取得文档名称
          mFileType=MsgObj.GetMsgByName("FILETYPE");					//取得文档类型
          mCommand=MsgObj.GetMsgByName("COMMAND");						//取得操作类型 InportText or ExportText
          mContent=MsgObj.GetMsgByName("CONTENT");						//取得文本信息 Content
          mOfficePrints=MsgObj.GetMsgByName("OFFICEPRINTS");			//取得Office文档的打印次数
		  mInfo = MsgObj.GetMsgByName("TESTINFO");						//取得客户端传来的自定义信息

          MsgObj.MsgTextClear();
          MsgObj.MsgFileClear();
        //  System.out.println(mCommand);

          if (mCommand.equalsIgnoreCase("INPORTTEXT")){
			if (LoadContent()){
			  MsgObj.SetMsgByName("CONTENT",mContent);
			  MsgObj.SetMsgByName("STATUS", "导入成功!");				//设置状态信息
			  MsgObj.MsgError("");										//清除错误信息
            }else{
			  MsgObj.MsgError("导入失败!");								//设置错误信息
            }
          }else if (mCommand.equalsIgnoreCase("EXPORTTEXT")){
			if (SaveContent()){
			  MsgObj.SetMsgByName("STATUS", "导出成功!");				//设置状态信息

			  String myPath=mFilePath+"//upload//govdocumentmanager//"+mRecordID+".txt";
			  FileWriter file = new FileWriter(myPath);
			  file.write(mContent,0,mContent.length());
			  file.close();

			  MsgObj.MsgError("");										//清除错误信息
			}else{
			  MsgObj.MsgError("导出失败!");								//设置错误信
			}
          }else if (mCommand.equalsIgnoreCase("WORDTABLE")){
			if (GetWordTable()){
			  MsgObj.SetMsgByName("COLUMNS",String.valueOf(mColumns));	//列
			  MsgObj.SetMsgByName("CELLS",String.valueOf(mCells));		//行
			  MsgObj.SetMsgByName("WORDCONTENT",mTableContent);			//表格内容
			  MsgObj.SetMsgByName("STATUS", "增加和填充成功成功!");		//设置状态信息
			  MsgObj.MsgError("");										//清除错误信息
			}else{
			  MsgObj.MsgError("增加表格行失败!");						//设置错误信息
			}
          }else if (mCommand.equalsIgnoreCase("COPIES")){				//打印限制
            System.out.println(mOfficePrints);
            mCopies=Integer.parseInt(mOfficePrints);					//获得客户需要打印的份数
            if (mCopies<=2){											//比较打印份数，拟定该文档允许打印的总数为2份，注：可以在数据库中设置好文档允许打印的份数
              if (UpdataCopies(2-mCopies)){								//更新打印份数
                MsgObj.SetMsgByName("STATUS", "1");						//设置状态信息，允许打印
                MsgObj.MsgError("");									//清除错误信息
              }
            }
            else{
              MsgObj.SetMsgByName("STATUS", "0");						//不允许打印
              MsgObj.MsgError("超过打印限度不允许打印!");				//设置错误信息
            }
          }else if (mCommand.equalsIgnoreCase("SELFINFO")){
			mInfo = "服务器端收到客户端传来的信息：“" + mInfo + "” | " ;
            //组合返回给客户端的信息
			mInfo = mInfo + "服务器端发回当前服务器时间：" + DbaObj.GetDateTime();
			MsgObj.SetMsgByName("RETURNINFO",mInfo);					//将返回的信息设置到信息包中
		  }else{
            MsgObj.MsgError("客户端Web发送数据包命令没有合适的处理函数!["+mCommand+"]");
            MsgObj.MsgTextClear();
            MsgObj.MsgFileClear();
          }
        }

        else if(mOption.equalsIgnoreCase("SAVEPAGE")){					//下面的代码为保存为全文批注格式文件
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//取得文档编号
          MsgObj.MsgTextClear();										//清除文本信息
          mFilePath=mFilePath+"//Document//"+mRecordID+".pgf";			//全文批注文件的完整路径
          if (MsgObj.MsgFileSave(mFilePath)){							//保存全文批注文件
            MsgObj.SetMsgByName("STATUS","保存全文批注成功!");			//设置状态信息
            MsgObj.MsgError("");										//清除错误信息
          }
          else{
            MsgObj.MsgError("保存全文批注失败!");						//设置错误信息
          }
        }

        else if(mOption.equalsIgnoreCase("LOADPAGE")){					//下面的代码为调入全文批注格式文件
          mRecordID=MsgObj.GetMsgByName("RECORDID");					//取得文档编号
          MsgObj.MsgTextClear();										//清除文本信息
          mFilePath=mFilePath+"//Document//"+mRecordID+".pgf";			//全文批注文件的完整路径
          if (MsgObj.MsgFileLoad(mFilePath)){							//调入文档内容
            MsgObj.SetMsgByName("STATUS","打开全文批注成功!");			//设置状态信息
            MsgObj.MsgError("");										//清除错误信息
          }
          else{
            MsgObj.MsgError("打开全文批注失败!");						//设置错误信息
          }
        }
      }
      else{      
        MsgObj.MsgError("客户端发送数据包错误!");
        MsgObj.MsgTextClear();
        MsgObj.MsgFileClear();
      }
    }
    else{    
      MsgObj.MsgError("请使用Post方法");
      MsgObj.MsgTextClear();
      MsgObj.MsgFileClear();
    }
    System.out.println("SendPackage") ;
    System.out.println("") ;
    ServletOutputStream out = response.getOutputStream();
    SendPackage(response);
    out = null ;
  }
  catch(IOException e){  
    System.out.println(e.toString()) ;
  }
}
}
%>
<%
iWebOffice officeServer = new iWebOffice();
officeServer.ExecuteRun(request,response);
%>