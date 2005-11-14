From: Steven Timm <timm@fnal.gov>
Subject: autofs timeout behavior
Date: Mon, 14 Nov 2005 16:29:26 -0600 (CST)
Message-ID: <Pine.LNX.4.62.0511141618530.6122@snowball.fnal.gov>
Mime-Version: 1.0
Content-Transfer-Encoding: 7BIT
Return-path: <autofs-bounces@linux.kernel.org>
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
Content-Type: TEXT/PLAIN; charset="us-ascii"; format="flowed"
To: autofs@linux.kernel.org


I have a single NFS server serving approximately 200 clients.
It is exporting three file systems to each. (actually to a 9-bit wide
network subnet).

/home           /etc/auto.home      -rw,hard,tcp,timeo=15,retrans=8,intr,noatime,nodiratime,rsize=32768,wsize=32768 
0 0
/farm           /etc/auto.farm      -rw,hard,tcp,timeo=15,retrans=8,intr,noatime,nodiratime,rsize=32768,wsize=32768 
0 0
/fnal           /etc/auto.fnal      -rw,hard,tcp,timeo=15,retrans=8,intr,noatime,nodiratime,rsize=32768,wsize=32768 
0 0


First few lines of /etc/auto.home look like this:

ktevdb          fnpcsrv1:/export/lsi_home/ktevdb
jaws            fnpcsrv1:/export/lsi_home/jaws
glazov          fnpcsrv1:/export/lsi_home/glazov
jshields        fnpcsrv1:/export/lsi_home/jshields
seturner        fnpcsrv1:/export/lsi_home/seturner

there are 394 possible home directories that could be mounted but
on average only one or two of them are in fact mounted on any given 
client.

This machine is running Kernel 2.4.21-37.XFS, all version 3 NFS
across TCP.

We are seeing a significant number of times when the attempted
automount just fails.  we see "Failed to mount...." in
/var/log/messages in the client and nothing on the server.
These tend to be during times of high server load >=60 on the server.


My questions:
1) what controls when an automount attempt just times out?
    Is it variable and can it be lengthed?

2) Does the automounter honor the fg/bg options?  (I have tried
it both ways and it looks like it does not.)  But what is the
behavior if a directory is requested and the request fails?  Is
there any way to specify a retry?


Occasionally we see the export tables get confused, and then
automount fails with "permission denied."  exportfs -va usually
restores the permission so that all clients can mount, but why would
it get confused in the first place?

Steve Timm




-- 
------------------------------------------------------------------
Steven C. Timm, Ph.D  (630) 840-8525  timm@fnal.gov  http://home.fnal.gov/~timm/
Fermilab Computing Div/Core Support Services Dept./Scientific Computing Section
Assistant Group Leader, Farms and Clustered Systems Group
Lead of Computing Farms Team
