                    
                <s:hidden name="myInfo.id" id="id" />
                <table width="100%" border="0" cellpadding="2" cellspacing="0" class="Table_bottomline">
                    <tr>  
                        <td for='<s:text name="personalwork.empName"></s:text>' class="td_lefttitle" width="8%" >  
                            <s:text name="personalwork.empName"></s:text>：  
                        </td>  
                        <td width="41%">  
                            <s:textfield name="myInfo.empName" id="empName" cssClass="inputText" readonly="true" />  
                        </td>  
                        <td for='<s:text name="personalwork.empEnglishName"></s:text>' class="td_lefttitle" width="8%">  
                            <s:text name="personalwork.empEnglishName"></s:text>：  
                        </td>  
                        <td width="41%">  
                            <s:textfield name="myInfo.empEnglishName" id="empEnglishName" cssClass="inputText"  whir-options="vtype:[{'maxLength':20}]" maxLength="20" />  
                        </td>  
                    </tr>  
                    <tr>  
                        <td for='<s:text name="personalwork.userAccounts"></s:text>' class="td_lefttitle">  
                            <s:text name="personalwork.userAccounts"></s:text>：
                        </td>  
                        <td>  
                            <s:textfield name="myInfo.userAccounts" id="userAccounts" cssClass="inputText" readonly="true" />  
                        </td>  
                        <td for='<s:text name="personalwork.userSimpleName"></s:text>' class="td_lefttitle">  
                            <s:text name="personalwork.userSimpleName"></s:text>： 
                        </td>  
                        <td>  
                            <s:textfield name="myInfo.userSimpleName" id="userSimpleName" cssClass="inputText" readonly="true" />  
                        </td>  
                    </tr>  
                    <tr>  
                        <td for='<s:text name="innercontact.mobile"></s:text>1' class="td_lefttitle">  
                            <s:text name="innercontact.mobile"></s:text>1：
                        </td>  
                        <td>  
                            <s:textfield name="myInfo.empMobilePhone" id="empMobilePhone" cssClass="inputText" whir-options="vtype:['mobile',{'maxLength':13}]"  maxLength="13" />  
                        </td>  
                        <td for='<s:text name="innercontact.mobile"></s:text>2' class="td_lefttitle">  
                            <s:text name="innercontact.mobile"></s:text>2：
                        </td>  
                        <td>  
                            <s:textfield name="myInfo.empMobilePhone2" id="empMobilePhone2" cssClass="inputText" whir-options="vtype:['mobile',{'maxLength':13}]"  maxLength="13" />  
                        </td>  
                    </tr>  
                    <tr>  
                        <td for='<s:text name="personalinfo.businessnumber"></s:text>' class="td_lefttitle">  
                            <s:text name="personalinfo.businessnumber"></s:text>： 
                        </td>  
                        <td>  
                            <s:textfield name="myInfo.empbusPhone" id="empbusPhone" cssClass="inputText" whir-options="vtype:['tel']" />  
                        </td>  
                        <td for='<s:text name="personalinfo.homenumber"></s:text>' class="td_lefttitle">  
                            <s:text name="personalinfo.homenumber"></s:text>：
                        </td>  
                        <td>  
                            <s:textfield name="myInfo.empPhone" id="empPhone" cssClass="inputText" whir-options="vtype:['tel']" />  
                        </td>  
                    </tr>  
                    <tr>  
                        <td for='<s:text name="personalinfo.email1"></s:text>' class="td_lefttitle">  
                            <s:text name="personalinfo.email1"></s:text>：
                        </td>  
                        <td>  
                            <s:textfield name="myInfo.empEmail" id="empEmail" cssClass="inputText" whir-options="vtype:['email']" />  
                        </td>  
                        <td for='<s:text name="personalinfo.email2"></s:text>' class="td_lefttitle">  
                            <s:text name="personalinfo.email2"></s:text>： 
                        </td>  
                        <td>  
                            <s:textfield name="myInfo.empEmail2" id="empEmail2" cssClass="inputText" whir-options="vtype:['email']" />  
                        </td>  
                    </tr>  
                    <tr>  
                        <td for='<s:text name="personalinfo.email3"></s:text>' class="td_lefttitle">  
                            <s:text name="personalinfo.email3"></s:text>：  
                        </td>  
                        <td>  
                            <s:textfield name="myInfo.empEmail3" id="empEmail3" cssClass="inputText" whir-options="vtype:['email']" />  
                        </td>  
                        <td for='<s:text name="personalinfo.sex"></s:text>' class="td_lefttitle">  
                            <s:text name="personalinfo.sex"></s:text>：
                        </td>  
                        <td>  
                            <s:radio name="myInfo.empsex" id="empsex" list="%{#{'0':getText('pubcontact.male'),'1':getText('pubcontact.female'),-1:'空'}}" theme="simple"></s:radio>
                        </td>  
                    </tr>  
                    <tr>  
                        <td for='<s:text name="personalinfo.profile"></s:text>' class="td_lefttitle">  
                            <s:text name="personalinfo.profile"></s:text>：
                        </td>  
                        <td colspan="3">  
                            <s:textarea name="myInfo.empDescribe" id="empDescribe" cols="112" rows="3" cssClass="inputTextarea" cssStyle="width:99%;" whir-options="vtype:[{'maxLength':500}]" maxLength="500" ></s:textarea>
                        </td>  
                    </tr>  
                    <tr>  
                        <td for='<s:text name="personal.nickname"></s:text>' class="td_lefttitle">  
                            <s:text name="personal.nickname"></s:text>：
                        </td>  
                        <td>  
                            <s:textfield name="myInfo.nickName" id="nickName" cssClass="inputText"  whir-options="vtype:[{'maxLength':10, 'minLength':4}]" minLength="4" maxLength="10" /> 
                        </td>  
                        <td colspan="2"><font color="red"><s:text name="personal.nicknameDescrible"></s:text></font></td>
                    </tr>  
                    <tr>  
                        <td for='<s:text name="personalinfo.esignature"></s:text>' class="td_lefttitle">  
                            <s:text name="personalinfo.esignature"></s:text>：  
                        </td>  
                        <td colspan="3">  
                            <s:hidden name="myInfo.empGnome" id="empGnome" />  
                            <iframe id="ewebeditorIFrame" src="<%=rootPath%>/public/edit/ewebeditor.htm?id=myInfo.empGnome&style=coolblue&lang=<%=whir_locale%>" frameborder="0" scrolling="no" width="99%" height="350"></iframe>
                        </td>  
                    </tr>  
                    <tr class="Table_nobttomline">  
                        <td nowrap="nowrap">&nbsp;</td> 
                        <td colspan="3" nowrap>  
                            <input type="button" class="btnButton4font" onClick="if(checkForm()){ok(1,this);}" value='<s:text name="comm.save"/>' />
                            <input type="button" class="btnButton4font" onClick="resetDataForm(this);" value='<s:text name="comm.reset"/>' />  
                        </td>  
                    </tr>  
                </table>  