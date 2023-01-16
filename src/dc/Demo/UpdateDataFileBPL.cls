/// 
Class dc.Demo.UpdateDataFileBPL Extends Ens.BusinessProcessBPL
{

/// BPL Definition
XData BPL [ XMLNamespace = "http://www.intersystems.com/bpl" ]
{
<process language='objectscript' request='Ens.Request' response='Ens.Response' height='2000' width='2000' >
<context>
<property name='DataLine' type='%String' instantiate='0' >
<parameters>
<parameter name='MAXLEN'  value='2500' />
</parameters>
</property>
<property name='ReadStatus' type='%Library.Status' instantiate='0' />
<property name='UpdatedFile' type='Ens.StreamContainer' instantiate='0' />
</context>
<sequence xend='200' yend='550' >
<code name='Init UpdatedFile' xpos='200' ypos='250' >
<![CDATA[ Set context.UpdatedFile = ##class(Ens.StreamContainer).%New()
 Set context.UpdatedFile.OriginalFilename = "test.txt"
 Set context.UpdatedFile.Stream = ##class(%Stream.FileCharacter).%New()]]>
</code>
<until name='Read DataLines' condition='(context.ReadStatus = 0)' xpos='200' ypos='350' xend='200' yend='350' >
<code xpos='200' ypos='250' >
<![CDATA[ Set context.ReadStatus = 1
 Set context.DataLine = request.Stream.ReadLine(/*.len,.context.ReadStatus*/)
 If (request.Stream.AtEnd) Set context.ReadStatus = 0
 If (context.ReadStatus) {
   Set context.DataLine = $Replace(context.DataLine,1,"One")
   Set sc = context.UpdatedFile.Stream.WriteLine(context.DataLine)
 }]]>
</code>
</until>
<call name='File Operation' target='dc.Demo.FileOperation' async='1' xpos='200' ypos='450' >
<request type='Ens.Request' >
<assign property="callrequest" value="context.UpdatedFile" action="set" />
</request>
<response type='Ens.Response' />
</call>
</sequence>
</process>
}

Storage Default
{
<Type>%Storage.Persistent</Type>
}

}
