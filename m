From: "Shawn Starr" <sstarr@platform.com>
Subject: Re: Automount with a local NFS export and a remote NFS
	export using the same mount path name over LDAP
Date: Tue, 21 Nov 2006 13:58:53 -0500
Message-ID: <E2AC825D4FC7764DA86D9C8ECA27A2DEAF7B39@catoexm05.noam.corp.platform.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
content-class: urn:content-classes:message
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

Hi Jeff, 

This didn't work on RHEL4 U4.

It again skipped mounting the remote LDAP NFS map.

It is clobbering the two NFS exports sharing /home

I noticed you made a patch this month for LDAP and automount, that seems
to be what I'm trying to do.

basically, If my nssswitch.conf has:   automount: files ldap

Automount should respect *both* file and LDAP automounts. Right now only one is expected Even If I use the option you mentioned below.

Thanks, 
Shawn.


-----Original Message-----
From: Jeff Moyer [mailto:jmoyer@redhat.com]
Sent: Monday, November 20, 2006 10:28 AM
To: Shawn Starr
Cc: autofs@linux.kernel.org
Subject: Re: [autofs] Automount with a local NFS export and a remote NFS
export using the same mount path name over LDAP


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
