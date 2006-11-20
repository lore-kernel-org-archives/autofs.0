From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: Automount with a local NFS export and a remote NFS
	export using the same mount path name over LDAP
Date: Mon, 20 Nov 2006 10:27:36 -0500
Message-ID: <x49k61quoif.fsf@segfault.boston.devel.redhat.com>
References: <E2AC825D4FC7764DA86D9C8ECA27A2DEAF7B34@catoexm05.noam.corp.platform.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <E2AC825D4FC7764DA86D9C8ECA27A2DEAF7B34@catoexm05.noam.corp.platform.com>
	(Shawn Starr's message of "Fri, 17 Nov 2006 17:27:35 -0500")
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
To: Shawn Starr <sstarr@platform.com>
Cc: autofs@linux.kernel.org

For some reason, I can't find your original post in my mailbox...

==> On Fri, 17 Nov 2006 17:27:35 -0500, "Shawn Starr" <sstarr@platform.com> said:

Shawn> Nevermind, I found an ugly workaround.  Just add another entry
Shawn> to auto.home in the LDAP config to map back to the local
Shawn> machine.

Shawn> > -----Original Message----- > From: Shawn Starr > Sent:
Shawn> Friday, November 17, 2006 3:46 PM > To:
Shawn> 'autofs@linux.kernel.org' > Subject: Automount with a local NFS
Shawn> export and a remote NFS export using the same mount path name
Shawn> over LDAP
Shawn> > 
Shawn> > Hi,
Shawn> > 
Shawn> > Does Automount v4 support the ability do the following:
Shawn> > 
Shawn> > 
Shawn> > 1) A local machine with NFS export /home mounted with a local
Shawn> /etc/auto.home map.
Shawn> > 
Shawn> > 2) a external machine with NFS export /home and using LDAP to
Shawn> export a auto.home map to automount.
Shawn> > 
Shawn> > If I set nsswitch.conf on the local machine to: automount:
Shawn> files ldap. Automount ignores LDAP mounts and only mounts the
Shawn> local files.
Shawn> > 
Shawn> > If I flip the order and use 'ldap files' automount only
Shawn> mounts the remote NFS /home and clobbers the local NFS /home
Shawn> map. Yet if I try to pass more than one auto.home mapping via
Shawn> LDAP to automount it ignores them.

For the RHEL variants, add this to your /etc/sysconfig/autofs

ONE_AUTO_MASTER=1

Shawn> > If Automount 4 can't do this does version 5? :)

Yes, but in the v5 case no special settings are necessary.

-Jeff
