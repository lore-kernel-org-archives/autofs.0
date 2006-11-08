From: "Syed Khader" <syedk@google.com>
Subject: Re: problem with autofs
Date: Wed, 8 Nov 2006 09:23:16 +0530
Message-ID: <29c5cd460611071953w5c3ab139w274c75b913aee36e@mail.gmail.com>
References: <29c5cd460611060850p4972e906s65990c968db963e4@mail.gmail.com>
	<x49psbzxtfa.fsf@segfault.boston.devel.redhat.com>
	<29c5cd460611070612x1d046f91u3a3c0577bb1fd77@mail.gmail.com>
	<x49ejsfxqix.fsf@segfault.boston.devel.redhat.com>
	<1162912613.18975.59.camel@localhost>
	<29c5cd460611070732h1cbdd998n3dd627c4e554b98a@mail.gmail.com>
	<x497iy7xmtp.fsf@segfault.boston.devel.redhat.com>
	<29c5cd460611070820o6cb2a08fp2c9e9adf67651ce3@mail.gmail.com>
	<x493b8vxeqr.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3170798737538686215=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x493b8vxeqr.fsf@segfault.boston.devel.redhat.com>
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

--===============3170798737538686215==
Content-Type: multipart/alternative; 
	boundary="----=_Part_14506_18690977.1162957996584"

------=_Part_14506_18690977.1162957996584
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Jeff,
It gives me

dn: cn=/home,dc=testlab,dc=com
and the automount information which i specified in the auto.home map.

I think Ldap entries are fine,but the problem is to make autofs read from
the LDAP rather than files.

Thanks,
Abdul.



On 11/8/06, Jeff Moyer <jmoyer@redhat.com> wrote:
>
> ==> Regarding Re: [autofs] problem with autofs; "Syed Khader" <
> syedk@google.com> adds:
>
> syedk> Hi Jeff,
> syedk> Here's the output
>
> >> ldapsearch -x -s subtree '(&(objectclass=automountMap)(ou=auto.master
> ))'
>
> syedk> dn:ou=auto.master,dc=testlab,dc=com
> syedk> objectClass:top
> syedk> objectClass:automountMap
> syedk> ou:auto.master
>
> syedk> I have configured to allow anonymous bind.No ACLS are given
>
> OK, then what do you get with this:
>
> ldapsearch -x -s subtree -b 'ou=auto.master,dc=testlab,dc=com'
> 'objectclass=automount'
>
> -Jeff
>

------=_Part_14506_18690977.1162957996584
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Jeff,</div>
<div>It gives me</div>
<div>&nbsp;</div>
<div>dn: cn=/home,dc=testlab,dc=com</div>
<div>and the automount information which i specified in the auto.home map.</div>
<div>&nbsp;</div>
<div>I think Ldap entries are fine,but the problem is to make autofs read from the LDAP rather than files.</div>
<div>&nbsp;</div>
<div>Thanks,</div>
<div>Abdul.</div>
<div><br><br>&nbsp;</div>
<div><span class="gmail_quote">On 11/8/06, <b class="gmail_sendername">Jeff Moyer</b> &lt;<a href="mailto:jmoyer@redhat.com">jmoyer@redhat.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">==&gt; Regarding Re: [autofs] problem with autofs; &quot;Syed Khader&quot; &lt;<a href="mailto:syedk@google.com">
syedk@google.com</a>&gt; adds:<br><br>syedk&gt; Hi Jeff,<br>syedk&gt; Here's the output<br><br>&gt;&gt; ldapsearch -x -s subtree '(&amp;(objectclass=automountMap)(ou=auto.master))'<br><br>syedk&gt; dn:ou=auto.master,dc=testlab,dc=com
<br>syedk&gt; objectClass:top<br>syedk&gt; objectClass:automountMap<br>syedk&gt; ou:auto.master<br><br>syedk&gt; I have configured to allow anonymous bind.No ACLS are given<br><br>OK, then what do you get with this:<br><br>
ldapsearch -x -s subtree -b 'ou=auto.master,dc=testlab,dc=com' 'objectclass=automount'<br><br>-Jeff<br></blockquote></div><br>

------=_Part_14506_18690977.1162957996584--


--===============3170798737538686215==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3170798737538686215==--

