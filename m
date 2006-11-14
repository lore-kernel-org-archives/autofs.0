From: Ian Kent <raven@themaw.net>
Subject: Re: autofsv5 enhancement - map names in /proc/mounts
Date: Tue, 14 Nov 2006 10:00:07 +0800
Message-ID: <1163469607.3297.22.camel@localhost>
References: <44AE7785.74E63D70@ggr.co.uk> <4554696C.5030400@ggr.co.uk>
	<45546B1F.5030306@ggr.co.uk> <1163213639.3113.15.camel@localhost>
	<45584448.2000102@ggr.co.uk> <1163432685.3016.21.camel@localhost>
	<4558A441.1030303@ggr.co.uk>
Mime-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 7bit
Return-path: <autofs-bounces@linux.kernel.org>
In-Reply-To: <4558A441.1030303@ggr.co.uk>
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
To: Gordon Lack <gml4410@ggr.co.uk>
Cc: autofs@linux.kernel.org

On Mon, 2006-11-13 at 16:58 +0000, Gordon Lack wrote:
> Ian Kent wrote:
> >>     Given that there can only be one map active at a mountpoint, and the 
> >> first one wins (which is why the -null map works) that would be 
> >> /etc/auto.server1.home,
> > 
> > Ya but for some reason I believed that I was able to do this with the

"believed", past tense.

> > Solaris automounter and so v5 now will merge each map.
> 
>     Just tried it on Solaris8:
> 
> Added these to /etc/auto_master:
> 
>   /local/AM /etc/auto.AM1
>   /local/AM /etc/auto.AM2
> 
> /etc/mntab now has *just* this 1 line at the end:
> 
>   /etc/auto.AM1   /local/AM       autofs  indirect,..........
> 
> and only the entries in /etc/auto.AM1 work.
> 
> This is what I would expect.  eg: -null is there so that you can 
> "remove" an entry from an included NIS  auto.master (or equiv).  If the 
> code is merging then this won't work, and its supposed to.
> 
> It's also perfectly reasonable to have, say, a standard auto.master map, 
> and a smaller auto.master.wizards map, with maps in it which are meant 
> to *override* the standard ones.
> 
> I can't see any benefit in merging things here - only confusing 
> complexity.  On Solaris and Irix (and Linux up to autofsv4) I've only 
> ever seen the first map mentioned be used (OSF1 uses the last, which is 
> truly bizarre, as it creates mountpoints then has to immediately rip 
> them out in order to replace them...)

I did this because I believed I had used this in Solaris previously.
I'm still deciding whether to change the semantics.

The "-null" handling is incorrect atm as well.
I'm fixing that now.

And as far as allowing multiple maps per indirect mount point goes,
there was another reason for this. In autofs v4 there is a map type
called "milti-map" where multiple map names can be given and this allows
such maps to be migrated to v5. The "-null" map handling will now be
setup to white-out all further occurrences of the nulled mount point. 

As far as adding the map name goes I haven't finished checking the
Solaris behavior yet.

> 
> > An individual file name can be up to 255 characters alone.
> > They don't have to have spaces to be long.
> 
>     Agreed - but is there a limit to the line lengths or total size of 
> /proc/mounts?

Not sure. I'd have to refer to the source.

> 
> > How do you use this feature?
> 
>     I have a script which reads it and prints the actual mounts that 
> exists at a given automount point.  It means I don't need to find out 
> which map is handling a particular automount point, nor do I have to 
> type in the map name, and I get the keys sorted for me.

I'd like to find a simple way to accommodate this while retaining the
multiple map functionality.

Ian
