From: "Syed Khader" <syedk@google.com>
Subject: Re: problem with autofs
Date: Tue, 7 Nov 2006 21:50:06 +0530
Message-ID: <29c5cd460611070820o6cb2a08fp2c9e9adf67651ce3@mail.gmail.com>
References: <29c5cd460611060850p4972e906s65990c968db963e4@mail.gmail.com>
	<x49psbzxtfa.fsf@segfault.boston.devel.redhat.com>
	<29c5cd460611070612x1d046f91u3a3c0577bb1fd77@mail.gmail.com>
	<x49ejsfxqix.fsf@segfault.boston.devel.redhat.com>
	<1162912613.18975.59.camel@localhost>
	<29c5cd460611070732h1cbdd998n3dd627c4e554b98a@mail.gmail.com>
	<x497iy7xmtp.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============5189474734461963046=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x497iy7xmtp.fsf@segfault.boston.devel.redhat.com>
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
To: Jeff Moyer <jmoyer@redhat.com>
Cc: autofs@linux.kernel.org, Ian Kent <raven@themaw.net>

--===============5189474734461963046==
Content-Type: multipart/alternative; 
	boundary="----=_Part_6040_14017788.1162916406174"

------=_Part_6040_14017788.1162916406174
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Jeff,
Here's the output
dn:ou=auto.master,dc=testlab,dc=com
objectClass:top
objectClass:automountMap
ou:auto.master

I have configured to allow anonymous bind.No ACLS are given

Thanks,
Abdul


On 11/7/06, Jeff Moyer <jmoyer@redhat.com> wrote:
>
> ==> Regarding Re: [autofs] problem with autofs; "Syed Khader" <
> syedk@google.com> adds:
>
> syedk> Hi Jeff,
> syedk> AND  /usr/lib[64]/autofs/autofs-ldap-auto-master DOESn't give any
> ouput
>
> That's bad.  What does the following show?
>
> ldapsearch -x -s subtree '(&(objectclass=automountMap)(ou=auto.master))'
>
> Is the ldap server configured to allow anonymous binds?
>
> -Jeff
>

------=_Part_6040_14017788.1162916406174
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Jeff,</div>
<div>Here's the output</div>
<div>dn:ou=auto.master,dc=testlab,dc=com</div>
<div>objectClass:top</div>
<div>objectClass:automountMap</div>
<div>ou:auto.master</div>
<div>&nbsp;</div>
<div>I have configured to allow anonymous bind.No ACLS are given</div>
<div>&nbsp;</div>
<div>Thanks,<br>Abdul<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 11/7/06, <b class="gmail_sendername">Jeff Moyer</b> &lt;<a href="mailto:jmoyer@redhat.com">jmoyer@redhat.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">==&gt; Regarding Re: [autofs] problem with autofs; &quot;Syed Khader&quot; &lt;<a href="mailto:syedk@google.com">
syedk@google.com</a>&gt; adds:<br><br>syedk&gt; Hi Jeff,<br>syedk&gt; AND&nbsp;&nbsp;/usr/lib[64]/autofs/autofs-ldap-auto-master DOESn't give any ouput<br><br>That's bad.&nbsp;&nbsp;What does the following show?<br><br>ldapsearch -x -s subtree '(&amp;(objectclass=automountMap)(ou=
auto.master))'<br><br>Is the ldap server configured to allow anonymous binds?<br><br>-Jeff<br></blockquote></div><br>

------=_Part_6040_14017788.1162916406174--


--===============5189474734461963046==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============5189474734461963046==--

