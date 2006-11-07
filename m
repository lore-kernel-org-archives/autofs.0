From: "Syed Khader" <syedk@google.com>
Subject: Re: problem with autofs
Date: Tue, 7 Nov 2006 19:42:02 +0530
Message-ID: <29c5cd460611070612x1d046f91u3a3c0577bb1fd77@mail.gmail.com>
References: <29c5cd460611060850p4972e906s65990c968db963e4@mail.gmail.com>
	<x49psbzxtfa.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============3708241903929888186=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x49psbzxtfa.fsf@segfault.boston.devel.redhat.com>
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
Cc: autofs@linux.kernel.org

--===============3708241903929888186==
Content-Type: multipart/alternative; 
	boundary="----=_Part_4089_9633853.1162908722604"

------=_Part_4089_9633853.1162908722604
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

The ldif for master is like this.

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

I'm using 4.1.3-155 version of autofs

My problem is to tell autofs daemon to read the map from LDAP and not from
files.
My autofs reads from the file /etc/auto.master.
If i give the entry

/home ldap:server.testlab.com:ou=auto.home,dc=testlab,dc=com

in the /etc/auto.master file and say Service autofs status

Then i see the mount point as the above.But when i try to login on the
client side.Still it doesn't mount the user's home directory.

I have changed the entry AUTOMOUNT:LDAP in /etc/nsswitch.conf file.

Thanks,
Abdul






On 11/7/06, Jeff Moyer <jmoyer@redhat.com> wrote:
>
> ==> Regarding [autofs] problem with autofs; "Syed Khader" <
> syedk@google.com> adds:
>
> syedk> Hello Evrybuddy,
> syedk> I had configured Openldap and succesfully configured for
> authentication of
> syedk> users.I'm facing problem with autofs
> syedk> I'm using Rhel4.When i say service autofs start it says
>
> syedk> No mount points defined.
>
> syedk> I have written the correct entries in /etc/exports file.
>
> syedk> I have sucessfully mounted directories using /etc/auto.master and
> syedk> indirect maps on the client side But when i'm using the ldap maps
> syedk> it's giving me problems How can i make my autofs service to read
> the
> syedk> auto.master from LDAP Ou= auto.master.
>
> syedk> I have changed in the /etc/nsswitch.conf file to Automount: ldap
> but
> syedk> no use
>
> syedk> when i use service autofs start it says "No mountpoints defined".
>
> syedk> Are they any bugs with RHEL4?
>
> Bugs?  In software?  Nooo, none here.  ;)
>
> syedk> Or am i going wrong somewhere?
>
> Since you can authenticate users using ldap, I'm guessing that your
> /etc/openldap/ldap.conf file points to the right server with the right
> base
> DN.  If that is the case, then we'll need to see the ldif for your master
> map, as Ian noted in his reply.
>
> What version of autofs are you using?  What LDAP schema are you using?
>
> -Jeff
>

------=_Part_4089_9633853.1162908722604
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

<div>The ldif for master is like this.</div>
<div>&nbsp;</div>
<div>dn: ou=auto.master,dc=testlab,dc=com</div>
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
<div>&nbsp;</div>
<div>I'm using 4.1.3-155 version of autofs</div>
<div>&nbsp;</div>
<div>My problem is to tell autofs daemon to read the map from LDAP and not from files.</div>
<div>My autofs reads from the file /etc/auto.master.</div>
<div>If i give the entry <pre class="program" style="MARGIN-TOP: 0pt">/home ldap:server.testlab.com:ou=auto.home,dc=testlab,dc=com</pre><pre class="program" style="MARGIN-TOP: 0pt">in the /etc/auto.master file and say Service autofs status
</pre><pre class="program" style="MARGIN-TOP: 0pt">Then i see the mount point as the above.But when i try to login on the client side.Still it doesn't mount the user's home directory.</pre><pre class="program" style="MARGIN-TOP: 0pt">
I have changed the entry AUTOMOUNT:LDAP in /etc/nsswitch.conf file.</pre><pre class="program" style="MARGIN-TOP: 0pt">Thanks,<br>Abdul</pre><pre class="program" style="MARGIN-TOP: 0pt">&nbsp;</pre></div>
<div><br><br>&nbsp;</div>
<div><span class="gmail_quote">On 11/7/06, <b class="gmail_sendername">Jeff Moyer</b> &lt;<a href="mailto:jmoyer@redhat.com">jmoyer@redhat.com</a>&gt; wrote:</span>
<blockquote class="gmail_quote" style="PADDING-LEFT: 1ex; MARGIN: 0px 0px 0px 0.8ex; BORDER-LEFT: #ccc 1px solid">==&gt; Regarding [autofs] problem with autofs; &quot;Syed Khader&quot; &lt;<a href="mailto:syedk@google.com">
syedk@google.com</a>&gt; adds:<br><br>syedk&gt; Hello Evrybuddy,<br>syedk&gt; I had configured Openldap and succesfully configured for authentication of<br>syedk&gt; users.I'm facing problem with autofs<br>syedk&gt; I'm using 
Rhel4.When i say service autofs start it says<br><br>syedk&gt; No mount points defined.<br><br>syedk&gt; I have written the correct entries in /etc/exports file.<br><br>syedk&gt; I have sucessfully mounted directories using /etc/auto.master and
<br>syedk&gt; indirect maps on the client side But when i'm using the ldap maps<br>syedk&gt; it's giving me problems How can i make my autofs service to read the<br>syedk&gt; auto.master from LDAP Ou= auto.master.<br><br>
syedk&gt; I have changed in the /etc/nsswitch.conf file to Automount: ldap but<br>syedk&gt; no use<br><br>syedk&gt; when i use service autofs start it says &quot;No mountpoints defined&quot;.<br><br>syedk&gt; Are they any bugs with RHEL4?
<br><br>Bugs?&nbsp;&nbsp;In software?&nbsp;&nbsp;Nooo, none here.&nbsp;&nbsp;;)<br><br>syedk&gt; Or am i going wrong somewhere?<br><br>Since you can authenticate users using ldap, I'm guessing that your<br>/etc/openldap/ldap.conf file points to the right server with the right base
<br>DN.&nbsp;&nbsp;If that is the case, then we'll need to see the ldif for your master<br>map, as Ian noted in his reply.<br><br>What version of autofs are you using?&nbsp;&nbsp;What LDAP schema are you using?<br><br>-Jeff<br></blockquote></div>
<br>

------=_Part_4089_9633853.1162908722604--


--===============3708241903929888186==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============3708241903929888186==--

