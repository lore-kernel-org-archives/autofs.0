From: "Syed Khader" <syedk@google.com>
Subject: Re: autofs to load MAP from LDAP
Date: Fri, 10 Nov 2006 10:03:28 +0530
Message-ID: <29c5cd460611092033m2e0de71cpa6e9e29d74555c24@mail.gmail.com>
References: <29c5cd460611082119u63dcc765j56c58c07f6ccd072@mail.gmail.com>
	<1163077907.9612.18.camel@houuc8>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5579563457490140817=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1163077907.9612.18.camel@houuc8>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://linux.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
To: "Stephen C. Rigler" <srigler@marathonoil.com>
Cc: autofs@linux.kernel.org

--===============5579563457490140817==
Content-Type: multipart/alternative; 
	boundary="----=_Part_42762_3157252.1163133208111"

------=_Part_42762_3157252.1163133208111
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

But in my ldap entries i don't have automountmapname.

dn: ou=auto.master,dc=testlab,dc=com
objectClass:top
objectClass:automountMap
ou:auto.master

dn: cn=/home,ou=auto.master,dc=testlab,dc=com
objectClass:automount
cn:/home
automountInformation: ldap server.testlab.com:ou=auto.home,dc=testlab,dc=com
--timeout 60


Auto.Home

 dn: ou=auto.home,dc=testlab,dc=com
objectClass:top
objectClass:automountMap
ou:auto.home

dn: cn=user1,ou=auto.home,dc=testlab,dc=com
objectClass: automount
cn:user1
automountInformation: -fstype=nfs,hard,intr server.testlab.com:/home/user1

What do i set LDAPAUTOMASTER to?

Abdul.


On 11/9/06, Stephen C. Rigler <srigler@marathonoil.com> wrote:
>
>  On Thu, 2006-11-09 at 10:49 +0530, Syed Khader wrote:
>
> Hello Everybody,
>
> How to make autofs read map from ldap rather than files.
>
>
> Syed,
>
> We run a mixed environment of Irix, Solaris and Linux machines.  To keep
> the Solaris machines happy, we use their schema (keys are "automountkey"
> rather than "cn", etc).  With autofs-4, Linux needs a different master map,
> but with version 5 it looks like we'll be able to use the same map as the
> other platforms.
>
> To point the Linux machines at your master map set "LDAPAUTOMASTER" in
> /etc/sysconfig/autofs to the name of the map (the name, not the dn).
>
> Our master map looks like:
>
> dn: automountMapName=auto.master_linux,dc=example,dc=com
> automountMapName: auto.master_linux
> objectClass: top
> objectClass: automountMap
>
> dn: automountkey=/home,automountmapname=auto.master_linux
> ,dc=example,dc=com
> objectClass: automount
> objectClass: top
> automountKey: /home
> automountInformation: ldap:automountmapname=auto_home,dc=example,dc=com
>
> auto_home looks like:
>
> dn: automountMapName=auto_home,dc=example,dc=com
> automountMapName: auto_home
> objectClass: top
> objectClass: automountMap
>
> dn: automountkey=someuser,automountmapname=auto_home,dc=example,dc=com
> objectClass: automount
> objectClass: top
> automountKey: someuser
> automountInformation: -rw    server:/export/home/&
>
> Hope this helps.
>
> -Steve
>
>
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
>
>
>

------=_Part_42762_3157252.1163133208111
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

But in my ldap entries i don't have automountmapname.<br><br><div>dn: ou=auto.master,dc=testlab,dc=com</div>
<div>objectClass:top</div>
<div>objectClass:automountMap</div>
<div>ou:auto.master</div>
<div>&nbsp;</div>
<div>dn: cn=/home,ou=auto.master,dc=testlab,dc=com</div>
<div>objectClass:automount</div>
<div>cn:/home</div>
<div>automountInformation: ldap server.testlab.com:ou=auto.home,dc=testlab,dc=com --timeout 60</div>
<div>&nbsp;</div>
<div>&nbsp;</div>
<div>Auto.Home</div>
<div>&nbsp;</div>
<div>
<div>dn: ou=auto.home,dc=testlab,dc=com</div>
<div>objectClass:top</div>
<div>objectClass:automountMap</div>
<div>ou:auto.home</div>
<div>&nbsp;</div>
<div>dn: cn=user1,ou=auto.home,dc=testlab,dc=com</div>
<div>objectClass: automount</div>
<div>cn:user1</div>
<div>automountInformation: -fstype=nfs,hard,intr server.testlab.com:/home/user1</div></div>
<div>&nbsp;<br>What do i set LDAPAUTOMASTER to?<br><br>Abdul.<br></div><br><br><div><span class="gmail_quote">On 11/9/06, <b class="gmail_sendername">Stephen C. Rigler</b> &lt;<a href="mailto:srigler@marathonoil.com">srigler@marathonoil.com
</a>&gt; wrote:</span><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">


  
  

<div><span class="q">
On Thu, 2006-11-09 at 10:49 +0530, Syed Khader wrote:<br>
</span><span class="q"><blockquote type="CITE">
    <font color="#000000">Hello Everybody,</font><br>
    <br>
    <font color="#000000">How to make autofs read map from ldap rather than files.</font><br>
    <br>
</blockquote></span>
<br>
Syed,<br>
<br>
We run a mixed environment of Irix, Solaris and Linux machines.&nbsp; To keep the Solaris machines happy, we use their schema (keys are &quot;automountkey&quot; rather than &quot;cn&quot;, etc).&nbsp; With autofs-4, Linux needs a different master map, but with version 5 it looks like we'll be able to use the same map as the other platforms.
<br>
<br>
To point the Linux machines at your master map set &quot;LDAPAUTOMASTER&quot; in /etc/sysconfig/autofs to the name of the map (the name, not the dn).<br>
<br>
Our master map looks like:<br>
<br>
<tt>dn: automountMapName=auto</tt>.<tt>master</tt>_linux<tt>,dc=example,dc=com</tt><br>
<tt>automountMapName: auto</tt>.<tt>master</tt>_linux<br>
<tt>objectClass: top</tt><br>
<tt>objectClass: automountMap</tt><br>
<br>
<tt>dn: automountkey=/home,automountmapname=auto</tt>.master_linux<tt>,dc=example,dc=com</tt><br>
<tt>objectClass: automount</tt><br>
<tt>objectClass: top</tt><br>
<tt>automountKey: /home</tt><br>
<tt>automountInformation: </tt>ldap:automountmapname=auto_home,dc=example,dc=com<br>
<br>
<tt>auto_home looks like:</tt><br>
<br>
<tt>dn: automountMapName=auto_home,dc=example,dc=com</tt><br>
<tt>automountMapName: auto_home</tt><br>
<tt>objectClass: top</tt><br>
<tt>objectClass: automountMap</tt><br>
<br>
<tt>dn: automountkey=someuser,automountmapname=auto_home,dc=example,dc=com</tt><br>
<tt>objectClass: automount</tt><br>
<tt>objectClass: top</tt><br>
<tt>automountKey: someuser</tt><br>
<tt>automountInformation: -rw&nbsp;&nbsp;&nbsp; server:/export/home/&amp;</tt><br>
<br>
Hope this helps.<br>
<br>
-Steve<br>
<br>
</div>


<br>_______________________________________________<br>autofs mailing list<br><a onclick="return top.js.OpenExtLink(window,event,this)" href="mailto:autofs@linux.kernel.org">autofs@linux.kernel.org</a><br><a onclick="return top.js.OpenExtLink(window,event,this)" href="http://linux.kernel.org/mailman/listinfo/autofs" target="_blank">
http://linux.kernel.org/mailman/listinfo/autofs</a><br><br><br></blockquote></div><br>

------=_Part_42762_3157252.1163133208111--


--===============5579563457490140817==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============5579563457490140817==--

