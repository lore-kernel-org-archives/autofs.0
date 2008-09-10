From: Ian Kent <raven@themaw.net>
Subject: Re: 5.0.3 oddity with LDAP map
Date: Wed, 10 Sep 2008 13:58:45 +0800
Message-ID: <1221026325.3030.69.camel@raven.themaw.net>
References: <20080909220416.GB22997@u20m2mm.qualcomm.com>
	<1221018890.3030.66.camel@raven.themaw.net>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <1221018890.3030.66.camel@raven.themaw.net>
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
To: Mike Marion <mmarion@qualcomm.com>
Cc: autofs@kernel.org

On Wed, 2008-09-10 at 11:54 +0800, Ian Kent wrote:
> On Tue, 2008-09-09 at 15:04 -0700, Mike Marion wrote:
> > Taking my first real stab at testing 5.0.3 (patched up to all patches in
> > the patch_order file from last night).  Have been sticking to supported
> > autofs5 from Novell on our hosts thus far, but still having some issues
> > here and there (long story, mostly because we have HUGE maps I think)
> > but ran into a problem starting 5.0.3.  It seems to be truncating info
> > the ldap server gives it.  The patches all successfully applied and the
> > compile went smoothly.
> > 
> > The debug info shows failure to mount like:
> > do_bind: lookup(ldap): ldap anonymous bind returned 0
> > get_query_dn: lookup(ldap): query succeeded, no matches for (&(objectclass=automountMap)(automountMapName=o.projects))
> > do_bind: lookup(ldap): failed to get query dn
> > lookup(ldap): couldn't connect to server default
> > do_read_map: lookup module ldap failed
> > mount_autofs_direct: failed to read direct map
> > handle_mounts: mount of /- failed!
> > master_do_mount: failed to startup mount
> 
> Mmmm .. what have I done now!
> 
> Lets have a look at the maps and I'll try to duplicate it.

I've tried a bunch of variations but can't see a problem.
I'll need the map configuration.

Ian
