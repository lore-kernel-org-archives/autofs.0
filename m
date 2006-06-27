From: "Peter C. Norton" <spacey-autofs@lenin.net>
Subject: Re: [autofs] [ANNOUNCE] autofs 5.0.0 beta5 beta release
Date: Mon, 26 Jun 2006 20:34:00 -0700
Message-ID: <20060627033400.GD27804@lenin.net>
References: <200606200407.k5K47AUt022166@raven.themaw.net>
Mime-Version: 1.0
Content-Transfer-Encoding: 7bit
Return-path: <linux-fsdevel-owner@vger.kernel.org>
Content-Disposition: inline
In-Reply-To: <200606200407.k5K47AUt022166@raven.themaw.net>
Sender: linux-fsdevel-owner@vger.kernel.org
List-Id: <autofs.vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
To: Ian Kent <raven@themaw.net>
Cc: autofs@linux.kernel.org, linux-fsdevel@vger.kernel.org

Using auto.master will break NIS+ (and possibly sql-based nsswich
modules, if there are any in real use), which uses auto_master since
"." is used as the namespace heirarchy separator. If you're going to
assume a name, you may want to see if there's a per-nameservice way of
specifying the map/schema/table to look up.

-Peter

On Tue, Jun 20, 2006 at 12:07:10PM +0800, Ian Kent wrote:
> Hi all,
> 
> Another beta.
> 
> A few changes since beta4.
> 
> Please find a little time to check this out.
> 
> autofs
> ======
> 
> The package can be found at:
> 
> ftp://ftp.kernel.org/pub/linux/daemons/autofs/v5
> 
> It is autofs-5.0.0_beta5.tar.[gz|bz2]
> 
> No source rpm is there as it can be produced by using:
> 
> rpmbuild -ts autofs-5.0.0_beta5.tar.gz
> 
> and the binary rpm by using:
> 
> rpmbuild -tb autofs-5.0.0_beta5.tar.gz
> 
> See the INSTALL file for information about configure options and
> kernel requirements.
> 
> Here are the entries from the CHANGELOG which outline the updates:
> 
> 20/6/2006 autofs-5.0.0_beta5
> ----------------------------
> - re-instate v4 directory cleanup.
> - backout master map lookup changes made to beta3.
> - change default master map from /etc/auto.master to auto.master
>   so that we always use nsswitch to locate master map.
> - change default installed master map to include "+auto.master"
>   to pickup NIS master map.
> - correct config names in default.c (jpro@bas.ac.uk).
> - check base of offset mount tree is not a mount before umounting
>   its offsets.
> - fix replicated mount parse for case where last name in list
>   fails lookup.
> - correct indirect mount expire broken by the wildcard lookup fix.
> - fix up multi-mount handling when wildcard map entry present.
> - fix mutex not being unlocked on map read.
> - fix rpc routines not logging errors.
> - fix handling of invalid directory for nobrowse hosts map lookup.
> - add free for working var in get_default_logging.
> - add inialisation for kver in autofs_point struct.
> - fix sources list corruption in check_update_map_sources.
> - fix memory leak in walk_tree.
> - fix memory leak in rpc_portmap_getport and rpc_ping_proto.
> - fix memory leak in initialisation of lookup modules.
> - fix handling of master map entry update.
> - fix program map handling of invalid multi-mount offsets.
> - move autofs4 module loading back to init script.
> - add export access list matching to "hosts" lookup module.
> - add check for key length to long (Jeff Moyer).
> - add patch to restrict /proc lookup to pid directories (Jeff Moyer).
> - fix directory cleanup at exit.
> 
> Ian
> 
> _______________________________________________
> autofs mailing list
> autofs@linux.kernel.org
> http://linux.kernel.org/mailman/listinfo/autofs

-- 
The 5 year plan:
In five years we'll make up another plan.
Or just re-use this one.

