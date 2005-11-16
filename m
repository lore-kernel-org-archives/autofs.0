From: Ian Kent <raven@themaw.net>
Subject: Re: autofs timeout behavior
Date: Wed, 16 Nov 2005 20:56:23 +0800 (WST)
Message-ID: <Pine.LNX.4.63.0511162049590.2593@donald.themaw.net>
References: <Pine.LNX.4.62.0511141618530.6122@snowball.fnal.gov>
Mime-Version: 1.0
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <Pine.LNX.4.62.0511141618530.6122@snowball.fnal.gov>
List-Id: <autofs.vger.kernel.org>
List-Unsubscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=unsubscribe>
List-Archive: <http://hera.kernel.org/pipermail/autofs>
List-Post: <mailto:autofs@linux.kernel.org>
List-Help: <mailto:autofs-request@linux.kernel.org?subject=help>
List-Subscribe: <http://linux.kernel.org/mailman/listinfo/autofs>,
	<mailto:autofs-request@linux.kernel.org?subject=subscribe>
Sender: autofs-bounces@linux.kernel.org
Errors-To: autofs-bounces@linux.kernel.org
Content-Type: TEXT/PLAIN; charset="us-ascii"
Content-Transfer-Encoding: 7bit
To: Steven Timm <timm@fnal.gov>
Cc: autofs@linux.kernel.org

On Mon, 14 Nov 2005, Steven Timm wrote:

> 
> I have a single NFS server serving approximately 200 clients.
> It is exporting three file systems to each. (actually to a 9-bit wide
> network subnet).
> 
> /home           /etc/auto.home
> -rw,hard,tcp,timeo=15,retrans=8,intr,noatime,nodiratime,rsize=32768,wsize=32768
> 0 0
> /farm           /etc/auto.farm
> -rw,hard,tcp,timeo=15,retrans=8,intr,noatime,nodiratime,rsize=32768,wsize=32768
> 0 0
> /fnal           /etc/auto.fnal
> -rw,hard,tcp,timeo=15,retrans=8,intr,noatime,nodiratime,rsize=32768,wsize=32768
> 0 0
> 
> 
> First few lines of /etc/auto.home look like this:
> 
> ktevdb          fnpcsrv1:/export/lsi_home/ktevdb
> jaws            fnpcsrv1:/export/lsi_home/jaws
> glazov          fnpcsrv1:/export/lsi_home/glazov
> jshields        fnpcsrv1:/export/lsi_home/jshields
> seturner        fnpcsrv1:/export/lsi_home/seturner
> 
> there are 394 possible home directories that could be mounted but
> on average only one or two of them are in fact mounted on any given client.
> 
> This machine is running Kernel 2.4.21-37.XFS, all version 3 NFS
> across TCP.
> 
> We are seeing a significant number of times when the attempted
> automount just fails.  we see "Failed to mount...." in
> /var/log/messages in the client and nothing on the server.
> These tend to be during times of high server load >=60 on the server.

Might be a known bug.

> 
> 
> My questions:
> 1) what controls when an automount attempt just times out?
>    Is it variable and can it be lengthed?

Might be the same bug.

> 
> 2) Does the automounter honor the fg/bg options?  (I have tried
> it both ways and it looks like it does not.)  But what is the
> behavior if a directory is requested and the request fails?  Is
> there any way to specify a retry?

No. autofs is dependant on mount for that.
Some versions of mount will background a failed request but I've seen 
others behave differently but lets not go there now.

> 
> 
> Occasionally we see the export tables get confused, and then
> automount fails with "permission denied."  exportfs -va usually
> restores the permission so that all clients can mount, but why would
> it get confused in the first place?

Also likely a known bug.

The backgrounding of a mount has the potential to break the locking in 
autofs which is meant to prevent (what sounds like) mtab corruption you 
are seeing. But that's another long story as well.

What versions of autofs and kernel are you running?
Are you able to get a debug log trace if needed?

Ian
