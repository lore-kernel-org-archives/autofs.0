From: Jeff Moyer <jmoyer@redhat.com>
Subject: Re: some questions about the configuration
Date: Thu, 26 Jan 2006 12:10:45 -0500
Message-ID: <17369.661.597510.89926@segfault.boston.redhat.com>
References: <43D4F1E0.2060201@inria.fr>
	<Pine.LNX.4.64.0601242036050.3037@eagle.themaw.net>
	<43D8F3DE.5080003@inria.fr>
Reply-To: jmoyer@redhat.com
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <43D8F3DE.5080003@inria.fr>
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
Content-Type: text/plain; charset="us-ascii"
To: Guillaume Rousse <Guillaume.Rousse@inria.fr>
Cc: autofs@linux.kernel.org

==> Regarding Re: [autofs] some questions about the configuration; Guillaume Rousse <Guillaume.Rousse@inria.fr> adds:

Guillaume.Rousse> Ian Kent wrote:
>> On Mon, 23 Jan 2006, Guillaume Rousse wrote:
>> 
>> 
>>> I recently started to clean-up the mandriva autofs package a bit, and I
>>> have some questions about the default configuration handling.
>>> 
>>> First, it seems autofs-ldap-auto-master, which is installed in
>>> /usr/lib/autofs, and auto.{net,smb}, which are installed in /etc, have
>>> exactly the same purpose: to automatically produce a list of available
>>> mount points from a remote host. If I am right, why are them installed
>>> and named differently ? Apart the fact that the first one is native
>>> code, whereas the others are shell scripts, they could as well get
>>> installed as /usr/lib/autofs/auto.{ldap,smb,net}
>> 
>> 
>> the autofs-ldap-auto-master reads the master map from an ldap
>> server. Only the master map.
>> 
>> All the things in /usr/lib/autofs are system things, internal, whereas
>> things in the map directory, often /etc are the user maps. The example
>> program maps auto.smb and auto.net are, well, examples. Given a key they
>> return the entry for it. Neither returns master map entries.
Guillaume.Rousse> OK, I understand they have different nature, so they
Guillaume.Rousse> can't have the exact same naming scheme. But if auto.smb
Guillaume.Rousse> and auto.smb are exemple, they should not get installed,
Guillaume.Rousse> and especially not among configuration files whereas they
Guillaume.Rousse> are executables programs.

Guillaume.Rousse> I'd rather have called ldap.master.map, smb.user.map and
Guillaume.Rousse> net.user.map, or something similar, and have them
Guillaume.Rousse> installed in the same place.

You can modify auto.net or auto.smb to suit your needs.  In that sense,
they are user-configurable automounter maps, and belong with the other
maps.  I understand that autofs configuration is a bit overwhelming, and
the documentation is lacking.  Perhaps we should focus on improving the
documentation.

>> The master map and the maps that are contained in the master map have a
>> different syntax.
>> 
>> 
>>> Second, it's not clear why ldap and nis use are triggered from the
>>> content of /etc/nsswitch.conf, while smb and net (simple rpcinfo
>>> listing) use are triggered from content of /etc/auto.master. Shouldn't
>>> all those syntax be available from both locations?
>> 
>> 
>> Master vs client maps again.
Guillaume.Rousse> According to my init script understanding, however, it
Guillaume.Rousse> seems you can't refer to LDAP user maps from
Guillaume.Rousse> /etc/auto.master, whereas you can refer to NIS user maps
Guillaume.Rousse> from there, using a syntax such as '+foobar', which is
Guillaume.Rousse> not documented in auto.master man page.

Your understanding is wholly incorrect.  The following web sites are good
references that I use frequently.  I hope they are helpful to you.

http://docs.sun.com/app/docs/doc/805-3479/6j3agk1v5?q=autofs&a=view
http://docs.sun.com/app/docs/doc/816-0211/6m6nc66nc?a=view
http://www.ldapguru.com/modules/newbb/viewtopic.php?topic_id=2029&forum=6

Regards,

Jeff
