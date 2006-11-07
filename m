From: "Syed Khader" <syedk@google.com>
Subject: Re: problem with autofs
Date: Tue, 7 Nov 2006 21:04:53 +0530
Message-ID: <29c5cd460611070734o1e3790a7u8c459931dd10a2a2@mail.gmail.com>
References: <29c5cd460611060850p4972e906s65990c968db963e4@mail.gmail.com>
	<x49psbzxtfa.fsf@segfault.boston.devel.redhat.com>
	<29c5cd460611070612x1d046f91u3a3c0577bb1fd77@mail.gmail.com>
	<x49ejsfxqix.fsf@segfault.boston.devel.redhat.com>
	<1162912613.18975.59.camel@localhost>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============1167769331729782974=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1162912613.18975.59.camel@localhost>
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
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org

--===============1167769331729782974==
Content-Type: multipart/alternative; 
	boundary="----=_Part_5307_25044140.1162913693969"

------=_Part_5307_25044140.1162913693969
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

Hi Kent,

I mean when i write the map in the /etc/auto.master also it doesn't make any
difference when i login with the username on the client machine which is
configured to use LDAP and autofs.

Thanks,
Abdul


On 11/7/06, Ian Kent <raven@themaw.net> wrote:
>
> On Tue, 2006-11-07 at 09:47 -0500, Jeff Moyer wrote:
> > syedk> /home ldap:server.testlab.com:ou=auto.home,dc=testlab,dc=com
> >
> > syedk> in the /etc/auto.master file and say Service autofs status
> >
> > syedk> Then i see the mount point as the above.But when i try to login
> on the
> > syedk> client side.Still it doesn't mount the user's home directory.
>
> You refer to "the client side", you do mean the client that is running
> autofs with the configuration you describe above, don't you?
>
> Ian
>
>
>

------=_Part_5307_25044140.1162913693969
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>Hi Kent,</div>
<div>&nbsp;</div>
<div>I mean when i write the map in the /etc/auto.master also it doesn't make any difference when i login with the username on the client machine which is configured to use LDAP and autofs.</div>
<div>&nbsp;</div>
<div>Thanks,<br>Abdul<br><br>&nbsp;</div>
<div><span class="gmail_quote">On 11/7/06, <b class="gmail_sendername">Ian Kent</b> &lt;<a href="mailto:raven@themaw.net">raven@themaw.net</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">On Tue, 2006-11-07 at 09:47 -0500, Jeff Moyer wrote:<br>&gt; syedk&gt; /home ldap:server.testlab.com:ou=auto.home
,dc=testlab,dc=com<br>&gt;<br>&gt; syedk&gt; in the /etc/auto.master file and say Service autofs status<br>&gt;<br>&gt; syedk&gt; Then i see the mount point as the above.But when i try to login on the<br>&gt; syedk&gt; client 
side.Still it doesn't mount the user's home directory.<br><br>You refer to &quot;the client side&quot;, you do mean the client that is running<br>autofs with the configuration you describe above, don't you?<br><br>Ian<br>
<br><br></blockquote></div><br>

------=_Part_5307_25044140.1162913693969--


--===============1167769331729782974==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============1167769331729782974==--

