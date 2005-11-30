From: "Prakash Velayutham" <Prakash.Velayutham@cchmc.org>
Subject: Re: autofs-4.1.3 not working properly
Date: Tue, 29 Nov 2005 19:54:38 -0500
Message-ID: <s38cb20d.066@n6mcgw16.cchmc.org>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
Content-Disposition: inline
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
To: autofs@linux.kernel.org

No. nscd is what I missed. I will try this for my next home dir move.

Thanks,
Prakash

>>> Chris Croswhite <csc@cadence.com> 11/29/05 7:32 PM >>>
are you sure you stop/restarted nscd?  try this, umount -f
/home/user1;nscd stop;autofs reload;nscd start. 


On Tue, 2005-11-29 at 16:26, Prakash Velayutham wrote:
> Neither is the case. I initialized manually umounted the user before
> moving his home directory and even restarted autofs. But it still kept
> looking at the previous entry for some strange reason. I did not do
the
> nscd portion though and probably that is the issue. But finger
> <username> properly showed the home directory as the new one???
> Also I do not have a LDAP master/slave setup yet? It is just master
> every client talks to.
> 
> Thanks,
> Prakash
> 
> >>> Chris Croswhite <csc@cadence.com> 11/29/05 7:22 PM >>>
> hmm, the delay would probably be associated with either:
> A: time out for the active mount point (see /etc/init.d/autofs, daemon
> options which defaults to 300 seconds)
> B: latency with replication between ldap consumers and masters/hubs
> (i.e. replication latency between master ldap and slave servers (nis
> parlance)?
> 
> 
> On Tue, 2005-11-29 at 16:18, Prakash Velayutham wrote:
> > Thanks Chris,
> > 
> > Of course, I did all that before sending the previous email and
still
> > the client kept looking at the old mount entry. But about 5 minutes
> > after I sent the email it started looking at the new entry. Just
some
> > delay in the change propagating I guess. Thanks again.
> > 
> > Prakash
> > 
> > >>> Chris Croswhite <csc@cadence.com> 11/29/05 6:44 PM >>>
> > uhh, you mean you migrated it to a different server?  Now you need
to
> > update the ldap maps, and force autofs to rehash all the maps
(though
> it
> > really does not do a rehash) on the client (autofs reload).  You
might
> > want to first force umount of the changed dir or the old mount will
> > stay.  Also, you should hup nscd so that the entry is not cached.
> > 
> > 
> > On Tue, 2005-11-29 at 15:30, Prakash Velayutham wrote:
> > > Hi,
> > > 
> > > What is the best practice when you want to move a user's home dir
> from
> > > one server to another in an LDAP setting. Server1's /home/<user>
is
> > > mounted via NFS on the client's /server1/users mount point and
> > server2's
> > > /home/<user> is mounted via NFS on the client's /server2/users
> > > mountpoint. The 2 are defined as separate map entries in the LDAP.
> How
> > > do I go about migrating a user's home dir from server1 to server2
or
> > > vice versa.
> > > 
> > > Thanks for the help,
> > > Prakash
> > > 
> > > >>> Ian Kent <raven@themaw.net> 11/27/05 4:49 AM >>>
> > > On Sat, 26 Nov 2005, Prakash Velayutham wrote:
> > > 
> > > > >>> Ian Kent <raven@themaw.net> 11/25/05 1:47 PM >>>
> > > > On Thu, 24 Nov 2005, Prakash Velayutham wrote:
> > > > 
> > > > > Hi,
> > > > > 
> > > > > I am new to this list, so please forgive my ignorances.
> > > > > I had a SuSE Pro 9.0 system running autofs (v3) running
earlier.
> > The
> > > 
> > > > > autofs itself did not have any issues at all until I decided
to
> > > > upgrade 
> > > > > the system to SuSE 9.3. It was a clean install, and
> autofs4-4.1.3
> > > > became 
> > > > > the default kernel autofs module. My autofs master map comes
> from
> > a 
> > > > > OpenLDAP server and it contains 3 different mount maps.
> > > > > /users (LDAP map)
> > > > > /protein/users (LDAP map)
> > > > > /import/users (LDAP map)
> > > > > I also have a file-based map in this server (/export/users).
> > > > > 
> > > > > Recently I was trying to move a user's home dir from server1
to
> > > > server2. 
> > > > > After moving his home dir and making the relevant changes to
his
> > > LDAP 
> > > > > entry (homeDirectory attribute), I tried to restart autofs in
> the 
> > > > > above-mentioned server. The server already had several users
> > logged
> > > in
> > > > 
> > > > > under /protein/users. Though the restart did not complain, I
> > noticed
> > > 
> > > > > that autofs status showed "Configured mount points" correctly
> and 
> > > > > removed the currently mounted mount points from "Active mount
> > > points".
> > > > 
> > > > > Is there a reason why? Also strangely the ownerships of the
> > > previously
> > > > 
> > > > > mounted dirs had been changed to root:root.
> > > > 
> > > > I'm not sure what is not working or what has been broken.
> > > > What is the actual problem and symptom?
> > > > 
> > > > Ian
> > > > 
> > > > Thanks Ian for a reply. What if I restart autofs when a user
whose
> > > home
> > > > dir is mounted through autofs is already logged into the system
> (and
> > > > hence at least one of the automount entries is being used)? What
> > will
> > > > the system do in that case?
> > > 
> > > On runing "reload" it should, depending on version and patch
levels 
> > > re-read and update the map, leave the mounted directory mounted
and
> > > leave 
> > > the stale map entry for cleanup next time the map is reloaded and
> the 
> > > entry isn't mounted. 
> > > 
> > > "Restart"ing is much more agressive and I wouldn't recommend it if
> you
> > 
> > > have mount that are in use. To restart you really need to have
> nothing
> > 
> > > actually in use.
> > > 
> > > > 
> > > > And also if I change the ldap attribute "homeDirectory" for a
> user,
> > do
> > > I
> > > > have to restart autofs in a system for that change to be seen.
> > Because
> > > I
> > > > sometimes see that the system has cached the user's attributes
> from
> > > LDAP
> > > > and tries to use that and fails.
> > > 
> > > autofs doesn't use that attribute so no, but you'll need to be
sure
> > that
> > > 
> > > the automount map entry that is used to access that directory is
> still
> > 
> > > valid following the change and if it also had to be changed then
you
> > > might 
> > > need to "reload" autofs. It's worth pointing out that later
versions
> > > (most 
> > > RedHat versions and 4.1.4 I think) of autofs should recognise this
> > > change 
> > > on access without needing to re-load the map.
> > > 
> > > The other thing I noticed about your query was the question about
> the
> > > root 
> > > owned directory. At variuos times in the past development autofs
has
> > > been 
> > > (mostly intentionally) lazy about cleaning up mount point
> directories.
> > 
> > > When autofs directories don't have a filesystem mounted on them
they
> > > will 
> > > appear root owned. It shouldn't make a difference to operation.
> > > 
> > > Ian
> > > 
> > > _______________________________________________
> > > autofs mailing list
> > > autofs@linux.kernel.org
> > > http://linux.kernel.org/mailman/listinfo/autofs
> > > 
> > > _______________________________________________
> > > autofs mailing list
> > > autofs@linux.kernel.org
> > > http://linux.kernel.org/mailman/listinfo/autofs
> > 
> > 
> 
> 
