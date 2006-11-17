From: Ian Kent <raven@themaw.net>
Subject: Re: Autofs hang, centos 4.4
Date: Fri, 17 Nov 2006 15:41:04 +0800
Message-ID: <1163749264.2993.67.camel@localhost>
References: <455C8BA8.9070609@soe.ucsc.edu>
	<x49ac2rxrc1.fsf@segfault.boston.devel.redhat.com>
	<455CB5F6.9040201@soe.ucsc.edu>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <455CB5F6.9040201@soe.ucsc.edu>
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
To: Erich Weiler <weiler@soe.ucsc.edu>
Cc: autofs@linux.kernel.org

On Thu, 2006-11-16 at 11:03 -0800, Erich Weiler wrote:
> > The version of autofs would be a bit more useful than the version of
> > CentOS you are using.
> 
> You're absolutely right, sorry about that.  I'm running autofs 4.1.3.
> 
> > Add the mount options "hard" and "intr" to your map.  Most likely that
> > will take care of the problem by allowing you to hit Ctrl-C.  If it
> > doe%sn't, then please consult http://people.redhat.com/jmoyer for a
> > list of things we need to diagnose problems.
> 
> 'hard' and 'intr' are already in the options list, but unfortunately I 
> still can't Ctrl-C to stop it.  Here's a list of info for the bug report:
> 
> % rpm -q autofs
> autofs-4.1.3-187
> 
> % uname -r
> 2.6.9-42.0.3.ELsmp
> 
> My autofs maps are served by our OpenLDAP server.  The map that has the 
> problem (because sometimes it tries to reference NFS servers outside our 
> private network) is /projects.  From the auto.master entry in LDAP:
> 
> nisMapName: auto.master
> nisMapEntry: ldap:nisMapName=auto.projects,dc=kilokluster,dc=ucsc,dc=edu 
> -browse,hard,intr,rw
> 
> And an example of a map that hangs:
> 
> nisMapName: auto.projects
> nisMapEntry: myserver.ucsc.edu:/export/projects/compbio
> 
> Other maps (/home, etc) work fine, probably because those NFS servers 
> are reachable.  If I try to do a straight mount of this:
> 
> % /bin/mount -t nfs -s -o hard,intr,rw 
> myserver.ucsc.edu:/export/projects/compbio /projects/compbio
> 
> it hangs, but I can Ctrl-C out of it.  So it seems to problem lies with 
> the automounter because I can't Ctrl-C out of an 'automount' to this 
> mount, I have to kill it from another terminal (as root).
> 
> % cat /etc/nsswitch.conf
> passwd:     files ldap
> shadow:     files ldap
> group:      files ldap
> 
> hosts:      files dns
> 
> bootparams: files
> ethers:     files
> netmasks:   files
> networks:   files
> protocols:  files ldap
> rpc:        files
> services:   files ldap
> netgroup:   files ldap
> publickey:  files
> automount:  files ldap
> aliases:    files
> 
> % cat /etc/sysconfig/autofs
> 
> LOCALOPTIONS=""
> DAEMONOPTIONS="--timeout=60"
> LDAPAUTOMASTER=""
> UNDERSCORETODOT=1
> DISABLE_DIRECT=1
> ONE_AUTO_MASTER=0
> GHOSTDIRS=""
> 
> Again, an explanation of my problem from my previous email:
> 
> Basically I have a bunch of auto.* tables set up in /etc.  They work 
> fine.  What does not work fine is that when someone (a regular user, not 
> root) tries to automount a directory that doesn't exist, the command 
> hangs forever, and has to be killed by root.  For instance:
> 
> % cd /projects/foo
> [hangs]
> 
> because /projects/foo is unavailable.  Now let me make it a bit more 
> complex:  The machine I'm mounting on is on a private network 
> (10.x.x.x), the nfs server is on a public network.  There is no NAT 
> routing to the public network.  I was assuming that because the machine 
> could not reach the NFS server it would just fail or timeout, not hang 
> the terminal...
> 
> Odd thing is that if I try to go to this automount as root, it hangs, 
> but I *can* Ctrl-C out of it (which is good).  If I try to cd to this 
> directory as a regular user, I cannot Ctrl-C out of it.  Which is bad, 
> because it's more important for my users to be able to kill it, not 
> root.  This is the crux of my problem.  Failing to automount is fine, 
> but we need to be able to Ctrl-C out of it as a regular user.

And if you Ctrl-C two or more times does it then stop?

> 
> I get this in the /var/log/debug log (after turning on debugging in 
> autofs and syslog):
> 
> Nov 16 10:47:00 kkldap3 automount[2959]: parse(sun): 
> dequote("myserver.ucsc.edu:/export/projects/compbio") -> 
> myserver.ucsc.edu:/export/projects/compbio
> Nov 16 10:47:00 kkldap3 automount[2959]: parse(sun): core of entry: 
> options=hard,intr,rw, loc=myserver.ucsc.edu:/export/projects/compbio
> Nov 16 10:47:00 kkldap3 automount[2959]: parse(sun): mounting root 
> /projects, mountpoint compbio, what 
> myserver.ucsc.edu:/export/projects/compbio, fstype nfs, options hard,intr,rw
> Nov 16 10:47:00 kkldap3 automount[2959]: mount(nfs):  root=/projects 
> name=compbio what=myserver.ucsc.edu:/export/projects/compbio, 
> fstype=nfs, options=hard,intr,rw
> Nov 16 10:47:00 kkldap3 automount[2959]: mount(nfs): nfs 
> options="hard,intr,rw", nosymlink=0
> Nov 16 10:47:00 kkldap3 automount[2959]: mount(nfs): is_bad_host: 
> myserver.ucsc.edu:/export/projects/compbioNov 16 10:47:00 kkldap3 
> automount[2959]: mount(nfs): is_local_mount: 
> myserver.ucsc.edu:/export/projects/compbio
> Nov 16 10:47:00 kkldap3 automount[2959]: mount(nfs): from 
> myserver.ucsc.edu:/export/projects/compbio elected 
> myserver.ucsc.edu:/export/projects/compbio
> Nov 16 10:47:00 kkldap3 automount[2959]: mount(nfs): calling mkdir_path 
> /projects/compbio
> Nov 16 10:47:00 kkldap3 automount[2959]: mount(nfs): calling mount -t 
> nfs -s  -o hard,intr,rw myserver.ucsc.edu:/export/projects/compbio 
> /projects/compbio

So it is mount that's hanging but there isn't a way to cancel the mount
process. Difficult.

Ian
