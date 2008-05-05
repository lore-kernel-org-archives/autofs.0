From: Ian Kent <raven@themaw.net>
Subject: Re: Some reload problems.
Date: Mon, 05 May 2008 23:06:12 +0800
Message-ID: <1209999972.2768.8.camel@raven.themaw.net>
References: <481F1623.1050505@bononline.nl>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <481F1623.1050505@bononline.nl>
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
To: Stef Bon <stef@bononline.nl>
Cc: autofs@linux.kernel.org


On Mon, 2008-05-05 at 16:13 +0200, Stef Bon wrote:
> Hello,
> 
> I'm working on a construction which makes it able for ordinary users to 
> browse (and mount) the network over
> different services like SSH and SMB.
> 
> It creates a networkmap in the homedirectory:
> 
> /home/sbon/Global Network
> 
> for example.
> 
> Now this contruction creates and uses a temporarly master map in 
> /var/run/autofs:
> 
> /var/run/autofs.master
> 
> which in my single user case looks like:
> 
> /home/sbon/Global\ Network     /etc/autofs/session/auto.network.sbon -browse
> 
> The map is in /var/run, because it only contains runtime data.
> The line is added by a script run by KDM, when my session starts.
> (and removed by another script run by KDM, when a sessions ends)
> 
> Now I'v added this "networkrelated/usersession auto.master" to the 
> "main" auto.master:
> 
> #
> # other mountpoints and maps here....
> #
> +/var/run/autofs/auto.master
> 
> 
> Now, there is an (I think reasonable) assumption:
> - when the automount daemon is not started at boottime, the creation of 
> the networkfolders should not be done
> (this construction does not start it, it should already be running)
> - the daemon will start and continu running with an empty master map
> - a reload hasn't much consequences for existing trees.
> 
> But what is necessary, is that after any change in the 
> /var/run/autofs/auto.master file, the daemon should get a reload.
> 
> Now my experience is that the first issue is ok. There is even a patch 
> for it. (I'm using version 5.0.3)
> The daemon starts, even with an empty auto.master file (and an empty 
> /var/run/autofs/auto.master).
> 
> It's also ok when a line is added. But there are some problems when 
> stopping.
> When stopping a session (by logging out), the line in 
> /var/run/autofs/auto.master is removed and the
> daemon gets a reload. Now, when there are no other lines here, and there 
> also no other mountpoints in the main mastermap, the daemon stops.

You'll need to provide a debug log as well as the explanation, ensure
you are capturing all the output to syslog.

> 
> To avoid this problem, I've added valid mountpoint to the main 
> mastermap, and this problem did not occur anymore.
> But, what remained is that the top level directory of a unused 
> "browseable network tree" was removed after a reload. I have to avtivate 
> it again.
> 
> Let me explain: my construction supports two services at this moment: 
> SSH and SMB.
> When I login, both are activated by a litlle script which does:
> 
> ls -A "/home/sbon/Global Network/Windows Network" and
> ls -A "/home/sbon/Global Network/SSH hosts"
> 
> Now I can browse the network. (I've discussed this earlier..)
> 
> The /var/run/autofs/auto.master file has two lines, one for me and one 
> for root.
> There are smb shares for me (sbon) mounted, so there are active mounts. 
> No ssh host is mounted
> for sbon.
> When root is logging out, the  line with for root is removed, and the 
> daemon gets a reload.
> The result is that the Windows Network does still exist in 
> "/home/sbon/Global Network", but "SSH hosts" not
> anymore, which should not be the case.
> 
> I hope you're able to understand the situation.
> 
> Stef Bon
> 
> 
> 
> 
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs
