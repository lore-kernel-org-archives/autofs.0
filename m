From: "Vincent LEFORT" <vincent.lefort@gmail.com>
Subject: Re: Mount very when reboot
Date: Mon, 11 Feb 2008 16:37:36 +0100
Message-ID: <3a98c5000802110737y52bce2f0s2e0d3a07b9a1cf1e@mail.gmail.com>
References: <3a98c5000802080122q56d81c92x67806c7d15aeb108@mail.gmail.com>
	<1202717516.24318.8.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="===============2895272365704857625=="
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1202717516.24318.8.camel@raven.themaw.net>
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

--===============2895272365704857625==
Content-Type: multipart/alternative; 
	boundary="----=_Part_29769_7094011.1202744256389"

------=_Part_29769_7094011.1202744256389
Content-Type: text/plain; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

So

*rpm -q autofs : *autofs-4.1.4-6
*uname -r :* 2.6.13-15.18-smp

*auto.master on clients : *
     /serveurpst /etc/auto.pst --timeout 60

*auto.pst on clients :*
    prods1  -soft,intr,rsize=8192,wsize=8192,timeo=15,rw
192.168.0.48:/media/disk1_prods1

*nsswitch.conf on clients :*

#####################
#
# /etc/nsswitch.conf
#
# An example Name Service Switch config file. This file should be
# sorted with the most-used services at the beginning.
#
# The entry '[NOTFOUND=return]' means that the search for an
# entry should stop if the search in the previous entry turned
# up nothing. Note that if the search failed due to some other reason
# (like no NIS server responding) then the search continues with the
# next entry.
#
# Legal entries are:
#
#       compat                  Use compatibility setup
#       nisplus                 Use NIS+ (NIS version 3)
#       nis                     Use NIS (NIS version 2), also called YP
#       dns                     Use DNS (Domain Name Service)
#       files                   Use the local files
#       [NOTFOUND=return]       Stop searching if not found so far
#
# For more information, please read the nsswitch.conf.5 manual page.
#

# passwd: files nis
# shadow: files nis
# group:  files nis

passwd: compat
group:  compat

hosts:          files dns
networks:       files dns

services:       files
protocols:      files
rpc:            files
ethers:         files
netmasks:       files
netgroup:       files
publickey:      files

bootparams:     files
automount:      files nis
aliases:        files


#####################

*
sysconfig/autofs on clients :*

#######################
## Path:           System/File systems/Autofs
## Description:    Additional options for the autofs daemon.
## Type:           string
## Default:        ""
## ServiceReload:  autofs
#
# autofs daemon options (e.g. --timeout 60)
#
AUTOFS_OPTIONS=""
#######################


I will do the debug output, do you see some problems here ?


On Feb 11, 2008 9:11 AM, Ian Kent <raven@themaw.net> wrote:

>
> On Fri, 2008-02-08 at 10:22 +0100, Vincent LEFORT wrote:
> > Hello, it's my first message so be nice with me :)
> >
> > I'm about 20 computers in a network with suse 10.0 x86_64. I had
> > install nfs with autofs on all my computer and this works almost fine.
> >
> > In fact when start, first time my computer, its well, i can connect on
> > my folder and this one automount. Now if a reboot, when i try to
> > access to my folder it's very slow to connect to him...
> >
> > When i read /var/log/messages i can read sometimes : rpc error 5 or
> > cant read superblock.
> >
> > For me i think when i reboot and i'm already connected, when i reboot
> > the computer, he want connect to server but server said "ho baby, i'm
> > you are already connected... don't understand..."
> >
> > Can you have some solutions because its very boring for user (and if
> > the user put a link on their desktop the desktop will not be
> > displayed...)
>
> How about providing the information described at
> http://people.redhat.com/jmoyer.
>
> Ian
>
>
>


-- 
LEFORT Vincent

------=_Part_29769_7094011.1202744256389
Content-Type: text/html; charset=ISO-8859-1
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

So <br><br><u>rpm -q autofs : </u>autofs-4.1.4-6<br><u>uname -r :</u> 2.6.13-15.18-smp<br><br><u>auto.master on clients : </u><br>&nbsp;&nbsp;&nbsp;&nbsp; /serveurpst /etc/auto.pst --timeout 60<br><br><u>auto.pst on clients :</u><br>&nbsp;&nbsp;&nbsp; prods1&nbsp; -soft,intr,rsize=8192,wsize=8192,timeo=15,rw&nbsp;&nbsp;&nbsp; 192.168.0.48:/media/disk1_prods1<br>
<br><u>nsswitch.conf on clients :</u><br><br>#####################<br>#<br># /etc/nsswitch.conf<br>#<br># An example Name Service Switch config file. This file should be<br># sorted with the most-used services at the beginning.<br>
#<br># The entry &#39;[NOTFOUND=return]&#39; means that the search for an<br># entry should stop if the search in the previous entry turned<br># up nothing. Note that if the search failed due to some other reason<br># (like no NIS server responding) then the search continues with the<br>
# next entry.<br>#<br># Legal entries are:<br>#<br>#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; compat&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Use compatibility setup<br>#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nisplus&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Use NIS+ (NIS version 3)<br>#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; nis&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Use NIS (NIS version 2), also called YP<br>
#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; dns&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Use DNS (Domain Name Service)<br>#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; files&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Use the local files<br>#&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; [NOTFOUND=return]&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; Stop searching if not found so far<br>#<br># For more information, please read the nsswitch.conf.5 manual page.<br>
#<br><br># passwd: files nis<br># shadow: files nis<br># group:&nbsp; files nis<br><br>passwd: compat<br>group:&nbsp; compat<br><br>hosts:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; files dns<br>networks:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; files dns<br><br>services:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; files<br>protocols:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; files<br>
rpc:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; files<br>ethers:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; files<br>netmasks:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; files<br>netgroup:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; files<br>publickey:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; files<br><br>bootparams:&nbsp;&nbsp;&nbsp;&nbsp; files<br>automount:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; files nis<br>aliases:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; files<br><br><br>#####################<br>
<br><u><br>sysconfig/autofs on clients :</u><br><br>#######################<br>## Path:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; System/File systems/Autofs<br>## Description:&nbsp;&nbsp;&nbsp; Additional options for the autofs daemon.<br>## Type:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; string<br>
## Default:&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp; &quot;&quot;<br>## ServiceReload:&nbsp; autofs<br>#<br># autofs daemon options (e.g. --timeout 60)<br>#<br>AUTOFS_OPTIONS=&quot;&quot;<br>#######################<br><br><br>I will do the debug output, do you see some problems here ?<br>
<br><br><div class="gmail_quote">On Feb 11, 2008 9:11 AM, Ian Kent &lt;<a href="mailto:raven@themaw.net">raven@themaw.net</a>&gt; wrote:<br><blockquote class="gmail_quote" style="border-left: 1px solid rgb(204, 204, 204); margin: 0pt 0pt 0pt 0.8ex; padding-left: 1ex;">
<div><div></div><div class="Wj3C7c"><br>On Fri, 2008-02-08 at 10:22 +0100, Vincent LEFORT wrote:<br>&gt; Hello, it&#39;s my first message so be nice with me :)<br>&gt;<br>&gt; I&#39;m about 20 computers in a network with suse 10.0 x86_64. I had<br>
&gt; install nfs with autofs on all my computer and this works almost fine.<br>&gt;<br>&gt; In fact when start, first time my computer, its well, i can connect on<br>&gt; my folder and this one automount. Now if a reboot, when i try to<br>
&gt; access to my folder it&#39;s very slow to connect to him...<br>&gt;<br>&gt; When i read /var/log/messages i can read sometimes : rpc error 5 or<br>&gt; cant read superblock.<br>&gt;<br>&gt; For me i think when i reboot and i&#39;m already connected, when i reboot<br>
&gt; the computer, he want connect to server but server said &quot;ho baby, i&#39;m<br>&gt; you are already connected... don&#39;t understand...&quot;<br>&gt;<br>&gt; Can you have some solutions because its very boring for user (and if<br>
&gt; the user put a link on their desktop the desktop will not be<br>&gt; displayed...)<br><br></div></div>How about providing the information described at<br><a href="http://people.redhat.com/jmoyer" target="_blank">http://people.redhat.com/jmoyer</a>.<br>
<font color="#888888"><br>Ian<br><br><br></font></blockquote></div><br><br clear="all"><br>-- <br>LEFORT Vincent

------=_Part_29769_7094011.1202744256389--


--===============2895272365704857625==
Content-Type: text/plain; charset="us-ascii"
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
Content-Disposition: inline

_______________________________________________
autofs mailing list
autofs@linux.kernel.org
http://linux.kernel.org/mailman/listinfo/autofs

--===============2895272365704857625==--

