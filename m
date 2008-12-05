From: Ian Kent <raven@themaw.net>
Subject: Re: automounter segfaults when using negative cache?
Date: Sat, 06 Dec 2008 01:23:41 +0900
Message-ID: <1228494221.14030.82.camel@zeus.themaw.net>
References: <4937BBBC.9030305@s3group.cz>
	<x497i6e6291.fsf@segfault.boston.devel.redhat.com>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <x497i6e6291.fsf@segfault.boston.devel.redhat.com>
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
Cc: "autofs@linux.kernel.org" <autofs@linux.kernel.org>

On Fri, 2008-12-05 at 11:00 -0500, Jeff Moyer wrote:
> Ondrej Valousek <webserv@s3group.cz> writes:
> 
> > Interesting thing:
> > I have 2 identical login01 and login02 machines (Rhel4, full updates).
> > login01 is running old kernel (2.6.9-42.ELsmp), login02 is running the
> > latest one (2.6.9-78.0.8.ELsmp). Both have autofs debug enabled and are
> > running the latest autofs (autofs-4.1.3-234).
> > Now:
> > 1) login01:
> > [root@login01 ondrejv]# cat /var/log/debug.log* | grep "Dec  4 09:15:09"
> > Dec  4 09:15:09 login01 automount[3939]: handle_packet: type = 0
> > Dec  4 09:15:09 login01 automount[3939]: handle_packet_missing: token
> > 3533, name .raw_data
> > Dec  4 09:15:09 login01 automount[3939]: attempting to mount entry
> > /proj/.raw_data
> > Dec  4 09:15:09 login01 automount[1649]: lookup(yp): looking up .raw_data
> > Dec  4 09:15:09 login01 automount[3939]: mt->key set to .raw_data
> > Dec  4 09:15:09 login01 kernel: automount[1649]: segfault at
> > 0000000000000000 rip 0000002a95916be0 rsp 0000007fbfffd5c8 error 4
> > Dec  4 09:15:09 login01 automount[3939]: handle_child: got pid 1649, sig
> > 1 (11), stat 0
> > Dec  4 09:15:09 login01 automount[3939]: sig_child: found pending iop
> > pid 1649: signalled 1 (sig 11), exit status 0
> > Dec  4 09:15:09 login01 automount[3939]: send_fail: token=3533
> > Dec  4 09:15:09 login01 automount[3939]: handle_packet: type = 0
> > Dec  4 09:15:09 login01 automount[3939]: handle_packet_missing: token
> > 3534, name .raw_data
> > Dec  4 09:15:09 login01 automount[3939]: attempting to mount entry
> > /proj/.raw_data
> > Dec  4 09:15:09 login01 automount[1650]: lookup(yp): looking up .raw_data
> > Dec  4 09:15:09 login01 automount[3939]: mt->key set to .raw_data
> > Dec  4 09:15:09 login01 kernel: automount[1650]: segfault at
> > 0000000000000000 rip 0000002a95916be0 rsp 0000007fbfffd5c8 error 4
> 
> Can you enable core dumps and get us a stack trace of this?
> 
> > Note that .raw_data map does not exist in the yp map so it should go
> > into the negative cache - which happens correctly on login02:
> > ov 28 23:27:43 login01 automount[4201]: attempting to mount entry
> > /proj/.raw_data
> > Nov 28 23:27:43 login01 automount[13394]: lookup(yp): looking up .raw_data
> > Nov 28 23:27:43 login01 automount[4201]: mt->key set to .raw_data
> > Nov 28 23:27:43 login01 automount[13394]: lookup(yp): key ".raw_data"
> > not found in map.
> > Nov 28 23:27:43 login01 automount[13394]: failed to mount /proj/.raw_data
> > Nov 28 23:27:43 login01 automount[13394]: umount_multi:
> > path=/proj/.raw_data incl=1
> > Nov 28 23:27:43 login01 automount[4201]: handle_child: got pid 13394,
> > sig 0 (0), stat 3
> > Nov 28 23:27:43 login01 automount[4201]: sig_child: found pending iop
> > pid 13394: signalled 0 (sig 0), exit status 3
> > Nov 28 23:27:43 login01 automount[4201]: update_negative_cache: key:
> > .raw_data
> > Nov 28 23:27:43 login01 automount[4201]: Adding negative cache entry for
> > key .raw_data
> > Nov 28 23:27:43 login01 automount[4201]: Key .raw_data added to negative
> > cache
> > Nov 28 23:27:43 login01 automount[4201]: send_fail: token=15625
> >
> > I thought all the negative caching is done in user space, but apparently
> > kernel has some influence here....
> > Any explanation?
> 
> The negative caching is done in userspace.  I'm not sure I understand
> your question.

Me neither but I'm working on the negative caching of non-existent map
keys. Turns out to be a bit tricky when multiple nsswitch sources can be
tried for each mount since the map may not exist within a given source
and so we get NSS_STATUS_UNAVAIL instead of NSS_STATUS_NOTFOUND. Maybe I
should just cache the unavailable in the same way?

Ian
